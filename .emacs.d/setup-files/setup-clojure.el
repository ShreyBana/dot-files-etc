
(use-package clojure-mode :ensure t
  :hook (clojure-mode . paredit-mode))
(use-package cider :ensure t)

(provide 'setup-clojure)
