#!/usr/bin/env perl
########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#                  Camille Meulien                     #
#            (camille.meulien@gmail.com)               #
#                                                      #
########################################################

use strict;
use warnings;
use File::Copy;

my $dialog = 'dialog';
my $GT_VERSION = 'Prototype 0.1';
my $GT_TMPFILE = `mktemp /tmp/gtconf.XXXXX`;
my $GT_SVG_OPT = '.gt_options';

my $GT_BACKTITLE = "GeekTips.Org - The crazy config system for crazy geeks - $GT_VERSION";
my $GT_TITLE     = "GTConf $GT_VERSION";

my $GT_DIR = `pwd`;
   $GT_DIR =~ s/\s//;

my @dialog_argv =
    (
     "--backtitle",	$GT_BACKTITLE,
     "--title",		$GT_TITLE,
     "--checklist",	"Check tools or features you would like to use",
     "32", "120", "40",
    );


my $hello_sub = sub {print "That's interesting for defining filter for each module!\n"};
#Call like that: $hello_sub->();

my @modules =
    (
     {
	 Name		=>	"Sh",
	 Description	=>	"Sh Compatible Gtconf",
	 Checked	=>	"On",
	 DotFiles	=>	".shrc .bashrc .zshrc",
	 File		=>	"sh/shrc",
	 Depend		=>	"",
     },
     {
	 Name		=>	"Bash",
	 Description	=>	"Bash Compatible Gtconf",
	 Checked	=>	"On",
	 DotFiles	=>	".bashrc .zshrc",
	 File		=>	"bash/bashrc",
	 Depend		=>	"Sh",
     },
     {
	 Name		=>	"Zsh",
	 Description	=>	"Zsh Compatible Gtconf",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/zshrc",
	 Depend		=>	"Sh Bash",
     },
     {
	 Name		=>	"Zsh Module 1",
	 Description	=>	"Alias Basic",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/alias_basic.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 2",
	 Description	=>	"Alias Nocorrect",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/alias_nocorrect.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 3",
	 Description	=>	"Autocorrect",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/autocorrect.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 4",
	 Description	=>	"Developper",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/developper.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 5",
	 Description	=>	"Hitory",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/hitory.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 6",
	 Description	=>	"Alias Damn",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/alias_damn.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 7",
	 Description	=>	"Alias Noglob",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/alias_noglob.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 8",
	 Description	=>	"Completion",
	 Checked	=>	"On",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/completion.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 9",
	 Description	=>	"Epita",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/epita.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 10",
	 Description	=>	"Term Konsole",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/term_konsole.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 11",
	 Description	=>	"Term Xterm",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/term_xterm.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 12",
	 Description	=>	"Term Gnome",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/term_gnome.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Zsh Module 13",
	 Description	=>	"Term Rxvt",
	 Checked	=>	"Off",
	 DotFiles	=>	".zshrc",
	 File		=>	"zsh/modules/term_rxvt.sh",
	 Depend		=>	"Zsh Bash Sh",
     },
     {
	 Name		=>	"Emacs",
	 Description	=>	"Emacs Gtconf",
	 Checked	=>	"On",
	 DotFiles	=>	".emacs",
	 File		=>	"emacs/emacsdot_std",
	 Depend		=>	"",
     },
     {
	 Name		=>	"Vim",
	 Description	=>	"Vim Gtconf",
	 Checked	=>	"Off",
	 DotFiles	=>	".vimrc",
	 File		=>	"vim/vimrc",
	 Depend		=>	"",
     },
     {
	 Name		=>	"Git",
	 Description	=>	"Git color, relative paths and useful aliases",
	 Checked	=>	"On",
	 DotFiles	=>	".gitconfig",
	 File		=>	"git/gitconfig",
	 Depend		=>	"",
	 IncludeMethod	=>	"Copy",
     },
     {
	 Name		=>	"Ruby wirble",
	 Description	=>	"Activate the syntax color in irb (need wirble)",
	 Checked	=>	"Off",
	 DotFiles	=>	".irbrc",
	 File		=>	"ruby/irbrc_wirble.rb",
	 Depend		=>	"",
     },

    );

checkUniqDescModules();

sub dialogMsg
{
    my ($msg, $height, $width) = @_;
    my @args =
	(
	 "--backtitle",	$GT_BACKTITLE,
	 "--title",	$GT_TITLE,
	 "--msgbox",	$msg,
	 $height, $width
	);
    system ($dialog, @args);
}

# Crapy search subroutin
sub getModuleConf
{
    my $moduleName   = shift(@_);
    my $conf =
    {
	 Name		=>	"",
	 Description	=>	"",
	 Checked	=>	"",
	 DotFiles	=>	"",
	 File		=>	"",
    };

    while ( my $module = shift(@_) )
    {
	if ( $moduleName eq $module->{"Name"} )
	{
	    $conf = $module;
	    last;
	}
    }
    return $conf;
}

sub getCommentString
{
    my $filename = shift(@_);
    my $comment = '';

    if ( $filename =~ /emacs/ )
    {
	$comment = ";;";
    }
    elsif ( $filename =~ /vi/ )
    {
	$comment = '"';
    }
    else
    {
	$comment = '#';
    }

    return $comment;
}

sub getIncludeSyntax
{
    my ($dotfile, $incfile) = @_;
    my $syntax = '';

    if ( $dotfile =~ /(?:z|ba)sh/i )
    {
	$syntax = "[[ -f \"$incfile\" ]] && source \"$incfile\"";
    }
    elsif ( $dotfile =~ /sh/i )
    {
	$syntax = "test -f \"$incfile\" && source \"$incfile\"";
    }
    elsif ( $dotfile =~ /emacs/i )
    {
	$syntax = "
        (if (file-exists-p \"$incfile\")
         (load-file \"$incfile\")
        )\n";
    }
    elsif ( $dotfile =~ /vim/i )
    {
	$syntax = "
        if filereadable(\"$incfile\")
            source $incfile
        endif\n";
    }
    elsif ( $dotfile =~ /rb/i )
    {
	$syntax = "require \"$incfile\"";
    }
    else
    {
	#FIXME: Warning
    }
}

sub checkUniqDescModules
{
    my %descs;

    foreach my $module ( @modules )
    {
	if ( exists $descs{$module->{"Description"}} )
	{
	    print
		"Fatal Error: " .
		"Modules '" . $descs{$module->{"Description"}}->{"Name"} . "' and '" .
		$module->{"Name"} . "' have the same description: '" .
		$module->{"Description"} . "'\n";
	    exit;
	}
	$descs{$module->{"Description"}} = $module;
    }
}

sub updateModule
{
    my ($desc, $status) = @_;

    foreach my $module ( @modules )
    {
	$module->{"Checked"} = $status
	    if ( $module->{"Description"} eq $desc );
    }
}

sub resetModulesStatus
{
    foreach my $module ( @modules )
    {
	$module->{"Checked"} = "Off";
    }
}

sub saveConfig
{
    open OUT_OPTS, ">$GT_SVG_OPT";
    foreach my $module ( @modules )
    {
	print OUT_OPTS '"'.$module->{"Description"}."\"\t".$module->{"Checked"}."\n";
    }
    close OUT_OPTS;
}

sub loadConfig
{
    open IN_OPTS, "<$GT_SVG_OPT";
    while ( my $line = <IN_OPTS> )
    {
	if ( $line =~ /"([^"]*)"\s+(On|Off)/i )
	{
	    updateModule($1, $2);
	}
    }
    close IN_OPTS;
}

# Config Writter subroutin
sub writeConf
{
    my ($file, $cmd) = @_;
    my $comment = getCommentString($file);
    my $homedir =  $ENV{"HOME"};
    my $tmpfile = `mktemp /tmp/gtconf.XXXXX`;

    $tmpfile =~ s/\s//;

    my $rcin   = "$homedir/$file";
    my $rcout =  "$GT_DIR/$file";

    open RCOUT, ">$tmpfile" || "Warning: can not create file $tmpfile\n";

    # Add the geektips include lines
    if ( $cmd ne "" )
    {
	print RCOUT "$comment {{{ Geektips.Org\n";
	print RCOUT "$comment Do not edit this section !\n";
	print RCOUT "$comment Generated by $GT_DIR/setup.pl\n";
	print RCOUT "$cmd";
	print RCOUT "$comment }}} Geektips.Org\n";
    }

    # Copy the user rc file to the target
    if ( -f $rcin )
    {
	open RCIN, "<$rcin" || print "Warning: can not open $rcin\n" ;
	my $disable_w = 0;

	while ( my $line =  <RCIN> )
	{
	    if ( $line =~ /{{{ geektips.org/i )
	    {
		$disable_w = 1;
		next;
	    }

	    if ( $line =~ /}}} geektips.org/i )
	    {
		$disable_w = 0;
		next;
	    }
	    print RCOUT $line if ( !$disable_w );
	}

	close RCIN;
    }

    close RCOUT;
    move ($tmpfile, $rcin);
}

loadConfig();

# Add modules to the Dialog Box
for my $module ( @modules )
{
    push @dialog_argv, $module->{"Name"}, $module->{"Description"}, $module->{"Checked"};
#    print $module->{"Name"}.": ".$module->{"Description"}." (".$module->{"Checked"}.")\n";
}

resetModulesStatus();

# Run Dialog and get results on STDERR
open STDERR, ">$GT_TMPFILE";
system ($dialog, @dialog_argv);
close STDERR;

my $ret_val = $? >> 8;
my $ret_sig = $? & 127;

# Check for CANCELED action
if ( $ret_val )
{
    system "rm", "-f", $GT_TMPFILE;
    dialogMsg("Configuration CANCELED !", 10, 32);
    exit;
}

my @choices = split(/"\ ?"?/, `cat $GT_TMPFILE`);
my %modules_to_load;

# Get Modules to install and dependencies
foreach my $choice ( @choices )
{
    $choice =~ s/\\ / /g;
    next if ( $choice eq "" );

    # Get the configuration module
    my $choice_conf = getModuleConf($choice, @modules);

    if ( $choice_conf->{"Name"} eq "" )
    {
	print "Option `".$choice."` not reconized\n\n";
	next;
    }

    updateModule($choice_conf->{"Description"}, "On");

    foreach my $file ( split(/ /, $choice_conf->{"DotFiles"}) )
    {
	my $includeSyntax;
	my $incfile = $GT_DIR."/".$choice_conf->{"File"};

	if ( !exists $modules_to_load{$file} )
	{
	    $modules_to_load{$file} = ( $file =~ /sh/ ) ? "export GT_DIR=$GT_DIR\n" : "";
	}

	if ( exists $choice_conf->{"IncludeMethod"} && $choice_conf->{"IncludeMethod"} eq "Copy" )
	{
	    $includeSyntax = `cat $incfile`;
	}
	else
	{
	    $includeSyntax = getIncludeSyntax($choice_conf->{"Name"}, $incfile);
	}

	if ( $includeSyntax eq '' )
	{
	    # FIXME: Show Warning
	    next;
	}

	$modules_to_load{$file} .= $includeSyntax."\n";

    }
}

# Write every configure files
my $msg = "";
while ( my ($file, $cmds) = each (%modules_to_load) )
{
    writeConf ($file, $cmds);
    $msg .= "$file updated\n";
}

# Uninstall dotfiles unchecked
my %modules_to_unload;
foreach my $mod ( @modules )
{
    foreach my $dotf ( split(/ /, $mod->{DotFiles}) )
    {
	if ( !exists $modules_to_load{$dotf} )
	{
	    $modules_to_unload{$dotf} = 1;
	}
    }
}

while ( my ($file, $useless) = each (%modules_to_unload) )
{
    writeConf ($file, "");
    $msg .= "$file uninstalled\n";
}

dialogMsg ($msg, 20, 40);

# Save options
saveConfig();

# Remove temporary file
system "rm", "-f", $GT_TMPFILE;
