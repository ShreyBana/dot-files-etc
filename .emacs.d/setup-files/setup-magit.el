
(use-package magit
  :ensure t
  :hook (git-commit-post-finish-hook . magit))

(provide 'setup-magit)
