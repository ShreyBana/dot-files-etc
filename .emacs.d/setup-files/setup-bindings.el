
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package avy)

(use-package evil :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-set-undo-system 'undo-redo)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-leader 'normal (kbd ";"))
  (evil-define-key 'normal 'global
    ;; General
    (kbd "<leader>x") 'kill-current-buffer
    (kbd "<leader>y") 'yank-from-kill-ring
    (kbd "<leader>j") 'avy-goto-symbol-1
 
    ;; Project
    (kbd "<leader>f") 'affe-find
    (kbd "<leader>di") 'project-find-dir
    (kbd "<leader>k") 'eldoc-box-help-at-point
    (kbd "<leader>p") 'project-switch-project
    (kbd "<leader>g") 'consult-ripgrep
    (kbd "<leader>s") 'consult-buffer
    (kbd "C-c s") 'consult-project-buffer
    (kbd "<leader>ws") 'consult-eglot-symbols
    (kbd "<leader>bs") 'consult-imenu
    (kbd "<leader>bo") 'consult-outline
    (kbd "<leader>tt") 'project-vterm
    (kbd "<leader>te") 'project-eshell
    (kbd "<leader>bm") 'consult-bookmark

    ;; Paredit
    (kbd "<leader>l") 'paredit-forward-slurp-sexp
    (kbd "<leader>L") 'paredit-forward-barf-sexp
    (kbd "<leader>h") 'paredit-backward-slurp-sexp
    (kbd "<leader>H") 'paredit-backward-barf-sexp

    ;; Eglot
    (kbd "<leader>r") 'eglot-rename
    (kbd "<leader>F") 'eglot-format-buffer
    (kbd "<leader>ca") 'eglot-code-actions

    ;; Magit
    (kbd "<leader>m") 'magit-project-status)
  (evil-define-key 'insert 'global
    (kbd "M-TAB") 'copilot-accept-completion))

(use-package evil-collection :after evil
  :config
  (evil-collection-init))

(provide 'setup-bindings)
