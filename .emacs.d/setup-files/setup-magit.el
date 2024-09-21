
(use-package magit
  :ensure t
  :config
  (add-hook 'git-commit-post-finish-hook 'magit))

(provide 'setup-magit)
