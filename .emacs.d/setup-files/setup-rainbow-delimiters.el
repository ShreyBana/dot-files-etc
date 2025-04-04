
(use-package rainbow-delimiters
  :config
  (setq rainbow-delimiters-max-face-count 4)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(provide 'setup-rainbow-delimiters)
