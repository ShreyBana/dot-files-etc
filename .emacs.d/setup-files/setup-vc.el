;; -- MAGIT & FRIENDS --
(use-package diff-hl
  :config
  (global-diff-hl-mode))
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :hook
  (magit-pre-refresh . diff-hl-magit-pre-refresh)
  (magit-post-refresh . diff-hl-magit-post-refresh)
  :config
  (setopt magit-format-file-function #'magit-format-file-nerd-icons)
  :custom
  (magit-display-buffer-function
   #'magit-display-buffer-same-window-except-diff-v1))
(defun private/extract-jira-ticket ()
  "Extract Jira ticket ID from the current Magit branch name."
  (interactive)
  (if (magit-get-current-branch)
      (let ((branch-name (magit-get-current-branch)))
        (if (string-match "\\([A-Z]+-[0-9]+\\)" branch-name)
            (match-string 1 branch-name)))
    (message "Not in a Git repository or no current branch.")))
(defun private/insert-jira-ticket ()
  "Inserts Jira ticket ID if not already present in commit."
  (let ((ticket (private/extract-jira-ticket)))
    (when ticket
      (save-excursion
        (goto-char (point-min))
        (let ((first-line (buffer-substring-no-properties
                           (line-beginning-position)
                           (line-end-position))))
          (unless (string-match-p (regexp-quote ticket) first-line)
            (goto-char (point-min))
            (insert (concat "[" ticket "]") " ")))))))
(use-package git-commit
  :straight (:type built-in)
  :after magit
  :hook (git-commit-setup . private/insert-jira-ticket)
  :custom
  (git-commit-summary-max-length 90))
(use-package git-modes)
(use-package forge
  :after magit)

;;; -- PROJECT --
(defun project-vterm ()
  "Start a vterm session in the current project's root directory."
  (interactive)
  (require 'vterm)
  (require 'project)
  (let* ((project (project-current))
         (buffer-name (format "*vterm: %s*" (project-name project)))
         (buffer (get-buffer buffer-name))
         (default-directory (or (project-root project)
                                default-directory)))
    (if buffer
        (switch-to-buffer buffer)
      (vterm buffer-name))))

(use-package project
  :straight (:type built-in)
  :config
  (setq project-switch-commands
        '((magit-project-status "magit" ?m)
          (ellama "ellama" ?e)
          (project-vterm "term" ?t)
          (consult-project-buffer "switch-buffer" ?s)
          (project-find-file "find-file" ?f)
          (consult-ripgrep "(rg)grep" ?g)
          (project-query-replace-regexp "replace" ?r))))

;; MISC
;; Needed by `blamer'
(use-package posframe)
(use-package blamer
  :straight (:host github :repo "artawower/blamer.el")
  :bind (("C-c C-s" . blamer-show-commit-info))
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t))))

(provide 'setup-vc)
