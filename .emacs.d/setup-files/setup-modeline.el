(use-package emacs
  :straight (:type built-in)
  :config
  (column-number-mode t)
  :custom-face
  (mode-line ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98))))
  (mode-line-active ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98))))
  (mode-line-inactive ((t (:family "UbuntuMono Nerd Font Propo" :height 0.98)))))

;; (use-package doom-modeline
;;   :init
;;   (doom-modeline-mode 1)
;;   :custom
;;   (doom-modeline-vcs-max-length 24)
;;   (doom-modeline-buffer-file-name-style 'buffer-name)
;;   (doom-modeline-support-imenu t)
;;   (doom-modeline-hud t)
;;   (doom-modeline-bar-width 9)
;;   (doom-modeline-enable-word-count 0))

(defun setup/modeline--buffer-name ()
  (format " %s " (buffer-name)))

(defface setup/modeline-background
  '((t :background "#3355bb" :foreground "white" :inherit bold))
  "Face with a red background for use on the mode line.")

(defvar-local setup/modeline-buffer-name
    '(:eval
      (when (mode-line-window-selected-p)
        (propertize (setup/modeline--buffer-name) 'face 'setup/modeline-background)))
  "Mode line construct to display the buffer name.")

(defvar-local setup/modeline-major-mode-name
    '(:eval
      (list
       (propertize "λ" 'face 'shadow)
       " "
       (propertize (symbol-name major-mode) 'face 'bold)))
  "Mode line construct to display the major mode.")

(defvar-local setup/modeline-branch
    '(:eval
      (when-let* (((mode-line-window-selected-p))
                  (file (or buffer-file-name default-directory))
                  (backend (or (vc-backend file) 'Git))
                  (rev (vc-working-revision file backend))
                  (branch (or (vc-git--symbolic-ref file)
                          (substring rev 0 7))))
        (propertize (format " %s" branch) ))))

(defun setup/evil-state-string ()
  "Return formatted evil state string."
  (when (bound-and-true-p evil-mode)
    (pcase evil-state
      ('normal "NOR")
      ('insert "INS") 
      ('visual "VIS")
      ('replace "REP")
      ('operator "OPR")
      ('motion "MOT")
      ('emacs "EMC")
      (_ (upcase (symbol-name evil-state))))))


(defface prot-modeline-indicator-cyan-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#006080" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#40c0e0" :foreground "black")
    (t :background "cyan" :foreground "black"))
  "Face for modeline indicators with a background."
  :group 'prot-modeline-faces)

(defvar-local setup/modeline-narrow
    '(:eval
      (when (and (mode-line-window-selected-p)
                 (buffer-narrowed-p)
                 (not (derived-mode-p 'Info-mode 'help-mode 'special-mode 'message-mode)))
        (propertize " Narrow " 'face 'prot-modeline-indicator-cyan-bg)))
  "Mode line construct to report the narrowed state of the current buffer.")

(dolist (construct '(setup/modeline-buffer-name
                     setup/modeline-major-mode-name
                     setup/modeline-branch
                     setup/modeline-narrow))
  (put construct 'risky-local-variable t))


(kill-local-variable 'mode-line-format)
(setq-default mode-line-format
              '("%e"
                (:eval (format "*%s*" (setup/evil-state-string)))
                " "
                setup/modeline-buffer-name
                " "
                setup/modeline-branch
                " "
                setup/modeline-narrow
                mode-line-format-right-align
                setup/modeline-major-mode-name
                " "))
(force-mode-line-update)

(provide 'setup-modeline)
