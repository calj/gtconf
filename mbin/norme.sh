#!/usr/bin/perl -w

use strict;
use Getopt::Std;
use vars qw { $filename $line_number $nb_errors $unget $nb_files $nb_ok
	      $verbose $func_name $func_lines $func_col $preproc_indent
              $nb_funcs_ext $nb_funcs_static };


my %opts;
getopts('fhv', \%opts);

$nb_files = @ARGV;
usage() if $nb_files < 1 or $opts{'h'};

$nb_ok = 0;
$verbose = $opts{'v'};
while (@ARGV) {
    $filename = shift;
    if (-f $filename and open FILE, $filename) {
	$filename = `basename "$filename"`;
	chomp $filename;
	$nb_funcs_ext = $nb_funcs_static = 0;
	check_file() or err("fatal: unexpected EOF");
	err("5 exported functions max ($nb_funcs_ext found)") if
	    $nb_funcs_ext > 5;
	err("10 functions max (".($nb_funcs_ext+$nb_funcs_static)." found)") if
	    $nb_funcs_ext + $nb_funcs_static > 10;
	$nb_ok++ if $nb_errors == 0;
	if ($verbose) {
	    print "$filename: ";
	    if ($nb_errors > 0) {
		print "$nb_errors error";
		print "s" if $nb_errors > 1;
		print "\n";
	    } else {
		print "OK\n";
	    }
	}
	if ($opts{'f'}) {
	    print "functions: $nb_funcs_ext exported, ";
	    print "$nb_funcs_static static\n";
	}
    } else {
        my $msg = "No such file";
        $msg = $! if $!;
        warn "Unable to open '$filename': $msg\n";
    }
}

if ($verbose) {
    print "$nb_ok/$nb_files files OK\n";
}
exit(($nb_ok == $nb_files) ? 0 : 1);

sub usage {
    print "Usage: jen [-fhv] file.c [...]\n";
    print "\t-f\tshow functions count\n";
    print "\t-h\tthis help\n";
    print "\t-v\tverbose mode\n";
    exit(-1);
}

sub err {
    my $msg = shift;
    print "$filename ($line_number): $msg\n";
    $nb_errors++;
    return 0;
}

sub get_line {
    if (defined $unget) {
        $_ = $unget;
        undef $unget;
        $line_number++;
        return 1;
    }
    $_ = <FILE>;
    return 0 unless defined $_;
    chomp;
    $line_number++;
    1 while s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e;
    err("trailing whitespace") if m/ $/;
    s/ +$//;
    err("line exceed 80 columns (".length($_).")") if length($_) > 80;
    s/\".*?[^\\]\"/s/g;
    s/\'.*?[^\\]\'/s/g;
    return get_line() if check_preproc();
    return 1;
}

sub unget_line {
    $unget = $_;
    $line_number--;
}

sub check_header {
    my @header = ( '/\*', '\*\* .+ for .+ in .+', '\*\*', '\*\* Made by .+',
                   '\*\* Login   <.+>', '\*\*', '\*\* Started on  .+',
		   '\*\* Last update .+', '\*/' );

    foreach my $i (0..8) {
        get_line() or return 0;
        err("bad header") unless m/^$header[$i]$/;
    }
    return 1;
}

sub check_preproc {
    err("preprocessor directive mark (#) must appear on the first column") if
	m/^ +\#/;
    return 0 unless m/ *\#( *)([\w\d]+) *(.*)$/;
    my $indent = length $1;
    my $directive = $2;
    $preproc_indent-- if $directive eq 'endif' or $directive eq 'else';
    err("bad preprocessor directive indentation") unless
	$indent == $preproc_indent;
    $preproc_indent++ if $directive =~ m/^(if|else)/;
    get_line() while m/\\ *$/;
    return 1;
}

sub check_global {
    if (m|/\*|) {
	1 while not m|\*/| and get_line();
	get_line();
    }
    return 1 if m/^ *$/ or m/^typedef [\w ]+ [\w\[\]]+; *$/;
    if (m/^(typedef +)?(static +)?(const +)?(struct|enum)$/) {
	check_struct() or return 0;
	return 1;
    }
    if (m/^(typedef +)?(static +)?(const +)?(struct|enum) +\w+$/) {
	check_struct() or return 0;
	return 1;
    }
    if (m/^static +.+?=(.+)?$/) {
	do {
	    return 1 if m/; *$/;
	} while (get_line());
	return 0;
    }
    return 1 if m/^(inline +)?static [\w ]+ +\**[\w\[\]]+;$/;
    if (m/; *$/) {
	err("invalid function prototype") unless
	    m/^[\w\d ]+ +\**[\w\d]+\(.+\);$/ or
	    m/^[\w\d ]+ +\**[\w\d]+\(.+,$/;
	return 1;
    }
    return check_function();
}

sub check_struct {
    while (get_line()) {
	return 1 if m/^ *\} *; *$/;
    }
    return 0;
}

sub check_statement {
    my $in_code = shift;

    err("comma must be followed by a whitespace") if m/,[^ \n]/;
    err("comment in function body") if m|//| or m|/\*|;
    if (m|/\*|) {
	1 while not m|\*/| and get_line();
	get_line();
    }
    err("a single line can contain at most one statement") if
	m/;./ and (!m/(.*)\bfor\b *\(.*?;.*?;.*\)(.*)/ or
	(defined $1 and $1 =~ m/;./) or (defined $2 and $2 =~ m/;./));
    err("the semicolon must not be preceded by a whitespace") if
	m/[^ (]+ ;/ and !m/(return|break|continue) ;/;
    return unless $in_code;
    err("two or more consecutive whitespaces") if m/[^ ]  /;
    err("keyword '$1' must be followed by a whitespace") if
        m/[^\w](auto|enum|short|volatile|extern|int|signed|typedef|
                case|do|float|long|sizeof|union|char|double|register|
                static|unsigned|const|else|goto|struct|void|for|if|
                while)[^ \w\n)]/x;
    err("no whitespace after '$1'") if
	m/([([]) [^;]/ or m/(!) / or m/(--|\+\+) [^+\-\/%=&!]/;
    err("no whitespace before '$1'") if
	    (m/ ([])])/ and !m/; \)/) or m/[^+\-\/%=&] (--\+\+)/;
    err("whitespace required after '$1' operator") if
        m/([<>!&|]=)[^ ]/ or m/(=)[^ =\n]/ or m/([\/%])[^ =]/ or
        (!m/\+\+/ and m/(\+)[^ =\n]/) or (!m/--/ and m/(-)[^ =>\w(]/) or
        m/(\*)[^ =\w*,)(]/ or m/(;)[^ \n]/;
    err("whitespace required before '$1' operator") if
        m/[^ ](>>=|<<=)/ or (!m/<<=|>>=/ and m/[^ ]([<>!&|^]=)/) or
        (!m/[<>!&|^]=/ and m/[^ +\-\/*%=](=)/) or m/[^ ]([\/%])/ or
        (!m/\+\+/ and m/[^ ](\+)/) or (!m/--/ and m/[^ \w\d([](-)[^>]/) or
        m/[^ (\[*!](\*)/;
}

sub skip_blanklines {
    while (get_line()) {
	next if m/^$/;
	unget_line();
	return 1;
    }
    return 0;
}

sub inc_func_count {
    my $t = shift;
    if ($t =~ m/^static/) {
	$nb_funcs_static++;
    } else {
	$nb_funcs_ext++;
    }
}

sub get_func_def {
    if (m/^(([\w\d ]+) +)\**([\w\d]+)\(.+\)$/) {
	$func_name = $3;
	$func_col = length $1;
        is_type_space($2);
	inc_func_count($1);
    } elsif (m/^((([\w\d ]+) +)\**([\w\d]+)\().+,$/) {
	$func_name = $4;
	$func_col = length $2;
        is_type_space($3);
        my $align = length $1;
	inc_func_count($1);
        while (get_line()) {
            last unless m/^( +).+,{0,1}$/;
            err("invalid parameter alignment") unless $align == length $1;
        }
        unget_line();
    } else {
	err("invalid function definition");
    }
    get_line() or return 0;
    err("expecting '{'") unless m/^\{$/;
}

sub is_type {
    my $t = shift;
    return err("invalid type '$t'") unless
        $t =~ m/^(const )?(inline +)?(static )?(const )?(unsigned )?(short )?(long )?(void|int|char|long|short|float|double|[a-zA-Z0-9_]+|struct +[a-zA-Z0-9_]+)$/;
    return 1;
}

sub is_type_space {
    my $t = shift;
    $t =~ s/ +$//;
    return is_type($t);
}

sub is_var_decl {
    if (m/^ +([\w\d ]+) +[*\w\d\[\]]+(, *[*\w\d\[\]]+)*(;| *=.*)$/ and
	$1 !~ m/^(return)$/) {
        m/^(( +)([\w\d ]+) +)([*\w\d\[\]]+(, *[*\w\d\[\]]+)*)(;| *=(.*))$/;
        my $type = $3;
        my $vars = $4;
        my $align = length $1;
	my $end = $6;
	my $s = $7;
	my $is_struct_init;
	$is_struct_init = 1 if defined $end and $end =~ m/^ *=/ and
	    defined $s and $s =~ /^ *$/;
	if (is_type_space($type)) {
	    foreach my $v (split /, /, $vars) {
		err("invalid variable name: '$v'") unless
		    $v =~ m/^\**[a-z][a-zA-Z0-9_\[\]]*$/;
	    }
	    err("invalid variable alignment") unless $align == $func_col;
	}
	check_struct() if $is_struct_init;
        return 1;
    }
    return 0;
}

sub check_function {
    get_func_def() or return 0;
    $func_lines = 0;
    while (get_line()) {
	last if m/^$/ and $func_lines > 0;
	unless (is_var_decl()) {
	    err("empty line needed between variables and code") if
		$func_lines > 0;
	    unget_line();
	    last;
	}
        check_statement(0);
	$func_lines++;
    }
    while (get_line()) {
        if (m/^\}$/) {
	    err("function '$func_name' is $func_lines lines long (25 max)") if
                $func_lines > 25;
	    undef $func_name;
            return 1;
        }
	check_statement(1);
        if (m/^$/) {
        ;
        } else {
	$func_lines++;
        }
    }
    return 0;
}

sub expect_blankline {
    get_line() or return 0;
    unless (m/^$/) {
        err("expecting blank line");
        unget_line();
    }
    return 1;
}

sub check_file {
    $line_number = 0;
    $nb_errors = 0;
    $preproc_indent = 0;
    check_header() or return 0;
    while (1) {
	get_line() or return 1;
	check_global() or return 1;
    }
    return 1;
}

