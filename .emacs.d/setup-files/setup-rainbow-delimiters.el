
(use-package rainbow-delimiters
  :ensure t
  :config
  (setq rainbow-delimiters-max-face-count 4)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(provide 'setup-rainbow-delimiters)
