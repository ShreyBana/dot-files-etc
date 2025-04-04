(defun shift-shift-project-find-file ()
  "Run project-find-file when shift is pressed twice quickly."
  (interactive)
  (let ((last-kbd-macro last-kbd-macro)
        (message-log-max nil))
    (if (equal (this-single-command-keys) [shift])
        (when (equal (vector (read-event)) [shift])
          (project-find-file))
      (setq unread-command-events (listify-key-sequence (this-single-command-keys))))))

(use-package project
  :straight (:type built-in)
  :config
  (global-set-key [shift] 'shift-shift-project-find-file)
  (add-to-list 'project-switch-commands '(magit-project-status "Magit" ?m)))

(provide 'setup-project)
