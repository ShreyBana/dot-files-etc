(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

;; Perf Tuning
(setq gc-cons-threshold (* 1024 1024 1024))
(use-package gcmh :ensure t
  :init
  (setq gcmh-high-cons-threshold (* 1024 1024 1024))
  (setq gcmh-idle-delay-factor 20)
  :config
  (gcmh-mode 1))
;; Not needed on desktop.
;; (setq jit-lock-defer-time 0.05)
(setq read-process-output-max (* 1024 1024))
(setq package-native-compile t)

;; Custom Var Options
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq package-enable-at-startup nil)
;; Load setup-files.
(add-to-list 'load-path "~/.emacs.d/setup-files/")
;; (use-package exec-path-from-shell)
;; (when (memq window-system '(mac ns x))
  ;; (exec-path-from-shell-initialize))

(use-package project
  :straight (:type built-in))

(use-package xref
  :straight (:type built-in))

(use-package treesit
  :straight (:type built-in))
(use-package async)

(require 'setup-bindings)
(require 'setup-ui)
(require 'setup-org)
(require 'setup-completion)
(require 'setup-vc)
(require 'setup-prog-modes)

(defun new-frame-setup (frame)
  (if (display-graphic-p frame)
      (setq neo-theme 'icons)))
;; Run for already-existing frames (For single instance emacs)
(mapc 'new-frame-setup (frame-list))
;; Run when a new frame is created (For emacs in client/server mode)
(add-hook 'after-make-frame-functions 'new-frame-setup)
;(add-hook 'after-make-frame-functions (lambda (frame) (set-cursor-color "#49cf66")))
(setq frame-inhibit-implied-resize t)
(setq x-gtk-use-system-tooltips nil)

(put 'downcase-region 'disabled nil)
(defun my-minibuffer-setup-hook ()
  (setq-local face-remapping-alist '((default (:height 1.1)))))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)
