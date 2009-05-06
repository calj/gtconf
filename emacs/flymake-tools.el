;;; flymake-tools.el --- Helper functions

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

(defun flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         (msg                 "")
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (setq msg (concat msg (if (= (length msg) 0) "" "\n") (format "[%s] %s" line text)))
          )
        )
      (setq count (1- count)))
    (message msg)))

(add-hook 'post-command-hook '(lambda () (if (not (= (length (nth 0 (flymake-find-err-info flymake-err-info (flymake-current-line-no)))) 0))
                                             (flymake-display-err-minibuf))))

(provide 'flymake-tools)
;;; flymake-tools.el ends here
