
(use-package paredit)

(use-package emacs-lisp-mod
  :straight (:type built-in)
  :hook (emacs-lisp-mode . paredit-mode))

(provide 'setup-elisp)
