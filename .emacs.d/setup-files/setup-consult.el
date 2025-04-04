(use-package consult
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :custom
  (completion-in-region-function #'consult-completion-in-region))
  ;:config ;(consult-preview-mode))

(use-package consult-eglot
  :after consult)

(provide 'setup-consult)
