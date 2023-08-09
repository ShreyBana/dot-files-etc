
(defun efs/org-mode-setup ()
  (org-indent-mode t)
  (visual-line-mode)
  (visual-fill-column-mode)
  (setq-local display-fill-column-indicator-column 100))

;; Needed for auto-wrapping text.
(use-package visual-fill-column
  :ensure t
  :config
  (setq-default fill-column 100))

(use-package org
  :hook
  (org-mode . efs/org-mode-setup)
  :config
  (org-indent-mode t)
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)
  ;; (efs/org-mode-setup)
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
