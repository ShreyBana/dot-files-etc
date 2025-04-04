

;; Define sources for tree-sitter grammars
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (c "https://github.com/tree-sitter/tree-sitter-c")
     (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")))

;; Install missing grammars automatically (or use M-x treesit-install-language-grammar)
(dolist (grammar treesit-language-source-alist)
  (unless (treesit-language-available-p (car grammar))
    (treesit-install-language-grammar (car grammar))))

;; Remap traditional modes to their tree-sitter variants
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (js-mode . js-ts-mode)
        (js-json-mode . json-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (css-mode . css-ts-mode)
        (java-mode . java-ts-mode)
        (rust-mode . rust-ts-mode)
        (go-mode . go-ts-mode)
        (bash-mode . bash-ts-mode)
        (sh-mode . bash-ts-mode)))

(provide 'setup-tree-sitter)
