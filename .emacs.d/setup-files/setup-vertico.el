(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

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

;; (use-package vertico-posframe :ensure t
;;   :config
;;   (vertico-posframe-mode 1))
;;   ;; :custom
  ;; (vertico-posframe-parameters
  ;;  '((left-fringe . 8)
  ;;    (right-fringe . 8))))

;; (use-package orderless
;;   :custom
;;   (completion-styles '(orderless basic))
;;   (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'setup-vertico)
