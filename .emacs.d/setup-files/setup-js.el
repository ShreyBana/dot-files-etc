
(use-package js2-mode
  :hook
  (js2-mode-hook . eglot-ensure)
  (js2-mode-hook . flymake-mode))

(provide 'setup-js)
