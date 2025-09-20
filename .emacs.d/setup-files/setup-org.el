
(defun efs/org-mode-setup ()
  (org-indent-mode t)
  ;; (visual-line-mode)
  ;; (visual-fill-column-mode)
  (display-fill-column-indicator-mode -1)
  (text-scale-set 0.3)
  ;; (setq-local display-fill-column-indicator-column 100)
  )

;; Needed for auto-wrapping text.
;; (use-package visual-fill-column
;;   :config
;;   (setq-default fill-column 100))

(use-package olivetti
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

(use-package org
  :straight (:type built-in)
  :hook
  (org-mode . efs/org-mode-setup)
  :config
  (org-indent-mode t)
  ;; (setq org-ellipsis " ▾"
  ;;       org-hide-emphasis-markers t
  ;;       org-fold-catch-invisible-edits t
  ;;       org-hide-block-startup t)
  ;; ;; (efs/org-mode-setup)
  ;; (font-lock-add-keywords
  ;;    'org-mode
  ;;    '(("^ *\\([-]\\) "
  ;;       (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; ;; (setq org-agenda-files '("~/sdk"))
  ;; (setq org-todo-keywords
  ;;       '((sequence "TODO(t)"
  ;;                   "DEV(d)"
  ;;                   "IN-REVIEW(r)"
  ;;                   "|"
  ;;                   "DONE(d)"
  ;;                   "DELEGATED(D)"
  ;;                   "CANCELLED(c)")
  ;;         (sequence "REPORT(r)" "|" "REPORTED")
          ;; (sequence "DISCUSS" "|" "DONE")))
  (setq org-todo-keyword-faces
        '(("TODO" . "#ff9070")
          ("DEV" . "pink")
          ("IN-REVIEW" . "#d8af7a")
          ("DISCUSS" . "#ff5f5f")
          ("CANCELLED" . "#00c06f"))))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(provide 'setup-org)
