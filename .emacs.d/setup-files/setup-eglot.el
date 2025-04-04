(use-package eglot
  :custom
  (eglot-ignored-server-capabilities '(:inlayHintProvider :signatureHelpProvider))
  :init
  (setq eglot-inlay-hints-mode nil)
  :config
  (add-to-list 'eglot-server-programs
               '(smithy-mode . ("smithy-language-server" "0")))
  (setq eglot-report-progress 'messages)
  (setq-default
   eglot-workspace-configuration
   '(:java
     (:classPath ["/home/shrey_bana/.gradle/caches/modules-2/files-2.1/com.android.volley/volley/1.1.0/455f45f75823751ecdc46fec5cf4fb2b671ad0a4/classes.jar" "/home/shrey_bana/.gradle/caches/modules-2/files-2.1/com.android.volley/volley/1.1.0/aa94c3b8ff347dc47325830d0895af426c6eeb87/volley-1.1.0-javadoc.jar" "/home/shrey_bana/android/sdk/platforms/android-33/android.jar"]
      :docPath ["/home/shrey_bana/.gradle/caches/modules-2/files-2.1/com.android.volley/volley/1.1.0/65ed7df4af0e83a626f383ff49c3403342659aa9/volley-1.1.0-sources.jar" "/home/shrey_bana/.gradle/caches/modules-2/files-2.1/com.android.volley/volley/1.1.0/aa94c3b8ff347dc47325830d0895af426c6eeb87/volley-1.1.0-javadoc.jar"])));; "/home/shrey_bana/android/sdk/platforms/android-33"])))
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

(provide 'setup-eglot)
