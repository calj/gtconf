;;; konsole-binds.el ---

;; Copyright (C) 2009
;; Project: Geektips.Org sharing dot files system
;; Author:  <camille.meulien@gmail.com>


(define-key function-key-map "\e[H"    [C-home])
(define-key function-key-map "\e[F"    [C-end])
(define-key function-key-map "\e[A"    [C-up])
(define-key function-key-map "\e[B"    [C-down])
(define-key function-key-map "\e[D"    [C-left])
(define-key function-key-map "\e[C"    [C-right])
(define-key function-key-map "\e\e[D"  [M-left])
(define-key function-key-map "\e\e[C"  [M-right])
(define-key function-key-map "\e\e[A"  [M-up])
(define-key function-key-map "\e\e[B"  [M-down])


(provide 'konsole-binds)




