;;; -- VERTICO & FRIENDS --
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-count 15)
  (vertico-cycle t)
  :init
  (vertico-mode))
(use-package vertico-truncate
  :straight (:type git :host github :repo "jdtsmith/vertico-truncate")
  :config
  (vertico-truncate-mode 1))
(use-package savehist
  :init
  (savehist-mode))
(defun truncate-file-path (path)
  "Truncate the file path to show only the last two directories and the filename."
  (let* ((components (split-string path "/"))
         (filename (car (last components)))
         (dirs (nthcdr (max 0 (- (length components) 3)) (butlast components))))
    (concat (mapconcat 'identity dirs "/") "/" filename)))
(use-package marginalia :after vertico
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil))
  (marginalia-align 'right)
  :init
  (marginalia-mode)
  :config
  (add-to-list 'marginalia-annotator-registry
               '(file marginalia-annotate-file my-truncate-file-path)))

;;; -- CONSULT --
(use-package consult
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :custom
  (consult-async-input-debounce 0.1)
  (consult-async-input-throttle 0.1)
  (completion-in-region-function #'consult-completion-in-region))
  ;:config ;(consult-preview-mode))
(use-package consult-eglot
  :after consult)

;;; -- CORFU & FRIENDS --
(use-package corfu
  ;; TAB-and-Go customizations
  :custom
  (corfu-auto t)
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt
  (corfu-popupinfo-delay 0.2)
  (text-mode-ispell-word-completion nil)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("C-SPC" . corfu-insert-separator))

  :init
  (global-corfu-mode)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  (setq corfu-auto t
        corfu-auto-delay 0.15
        corfu-quit-no-match 'separator
        corfu-popupinfo-mode t
        completion-styles '(orderless)))
(use-package cape
  :init
  ;; Add ispell to completion-at-point-functions
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-dict))
;; Extends eshell pcomplete to give completion from MAN pages.
(use-package pcmpl-args)
;; Fish completions in eshell.
(use-package fish-completion
  :config (when (executable-find "fish") (global-fish-completion-mode)))

;;; -- EGLOT --
(use-package eglot
  :custom
  (eglot-ignored-server-capabilities '(:inlayHintProvider :signatureHelpProvider))
  (eglot-extend-to-xref t)
  :init
  (setq eglot-inlay-hints-mode nil)
  :config
  (add-to-list 'eglot-server-programs
               '(smithy-mode . ("smithy-language-server" "0")))
  (setq eglot-report-progress 'messages)
  (add-to-list 'eglot-stay-out-of 'flymake))
(use-package eldoc
  :straight (:type built-in)
  :config
  (setq eldoc-echo-area-use-multiline-p nil)
  (advice-add 'eldoc-doc-buffer :after
              (lambda (&rest _)
                (when-let ((window (get-buffer-window "*eldoc*")))
                  (select-window window)))))

(use-package eldoc-box)

;;; Ispell
(use-package ispell
  :straight (:type built-in)
  :custom
  (ispell-program-name "aspell")
  (ispell-dictionary "en_US")
  ;; Configure aspell to replace ispell
  (ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")))

;;; -- MISC --
(use-package copilot
  :bind (("M-TAB" . copilot-accept-completion)))
(use-package copilot-chat
  ;; :bind (("C-c a" . copilot-chat-transient))
  :custom
  (copilot-chat-default-model "claude-3.7-sonnet"))
(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :init
  (setenv "AIDER_DARK_MODE" "true")
  (setenv
   "OPENROUTER_API_KEY"
   (string-trim (shell-command-to-string "pass show openrouter/api-key")))
  :custom
  (aidermacs-backend 'vterm)
  ; See the Configuration section below
  (aidermacs-use-architect-mode nil)
  ;; Enable/disable showing diffs after changes (default: t)
  ;; (setq aidermacs-show-diff-after-change t)
  (aidermacs-default-model "openrouter/anthropic/claude-sonnet-4"))
(use-package llm)
(use-package ellama
  :bind (("C-c e" . ellama))
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  :custom
  ;; language you want ellama to translate to
  (ellama-language "English")
  (require 'llm-openai)
  (ellama-provider
   (make-llm-openai-compatible
    :key (getenv "OPENROUTER_API_KEY")
    :url "https://openrouter.ai/api/v1"
    :chat-model "anthropic/claude-sonnet-4"))
  :config
  (ellama-context-header-line-global-mode +1)
  (ellama-session-header-line-global-mode +1))
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))
;; Better Doc & Help Pages
 (use-package helpful
   ;:custom
   ;(counsel-describe-function-function #'helpful-callable)
   ;(counsel-describe-varaible-function #'helpful-variable)
   :bind
   ;([remap describe-function] . counsel-describe-function)
   ([remap describe-command] . helpful-command)
   ;([remap describe-variable] . counsel-describe-variable)
   ([remap describe-key] . helpful-key))

(provide 'setup-completion)
