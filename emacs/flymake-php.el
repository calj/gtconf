;;; flymake-php.el --- PHP support for flymake

;; Copyright (C) 2007  Philippe

;; Author: Philippe <nuky@localhost.localdomain>
;; Keywords:

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; none

;;; Code:
(require 'flymake)

(defconst flymake-allowed-php-file-name-masks '(
                                                ("\\.php3\\'" flymake-php-init)
                                                ("\\.inc\\'" flymake-php-init)
                                                ("\\.php\\'" flymake-php-init))
  "Filename extensions that switch on flymake-php mode syntax checks")

(defconst flymake-php-err-line-pattern-re '("\\(\\(?:Parse\\|Fatal\\) error\\|Notice\\): \\(.*\\) in \\(.*\\) on line \\([0-9]+\\)" 3 4 nil 2)
  "Regexp matching PHP error messages")

(defun flymake-php-init ()
  (let* ((temp-file       (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local-file "-l"))))

(defun flymake-php-load ()
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-php-file-name-masks))
  (setq flymake-err-line-patterns (cons flymake-php-err-line-pattern-re flymake-err-line-patterns))
  (flymake-mode t))


(provide 'flymake-php)
;;; flymake-php.el ends here
