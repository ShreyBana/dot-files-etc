
(defun efs/org-mode-setup ()
  (org-indent-mode)
  (auto-fill-mode 0))

(use-package org
  :config
  (org-indent-mode t)
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)
  (font-lock-add-keywords
     'org-mode
     '(("^ *\\([-]\\) "
	(0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-agenda-files '("~/sdk")))

(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(provide 'setup-org)
