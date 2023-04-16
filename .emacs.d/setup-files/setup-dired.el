(setq insert-directory-program "gls" dired-use-ls-dired t)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :config
  (setq all-the-icons-dired-monochrome nil)
  :hook ((dired-mode . all-the-icons-dired-mode)))

(use-package dired-open
  :ensure t
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

;; (use-package dired-hide-dotfiles
;;   :ensure t
;;   :hook (dired-mode . dired-hide-dotfiles-mode)
;;   :config
;;   (evil-collection-define-key 'normal 'dired-mode-map
;;     "H" 'dired-hide-dotfiles-mode))

(provide 'setup-dired)
