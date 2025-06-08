;;; -- MAGIT & FRIENDS --
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
            (match-string 1 branch-name)
          (message "No Jira ticket ID found in the current branch name.")))
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

;;; -- PROJECT --
(use-package project
  :straight (:type built-in)
  :config
  (add-to-list 'project-switch-commands '(magit-project-status "Magit" ?m))
  (add-to-list 'project-switch-commands '(project-vterm "VTerm" ?t)))

(provide 'setup-vc)
