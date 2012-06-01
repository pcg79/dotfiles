;;; Snippets make typing fun

(require 'dropdown-list)

;; Develop in ~/emacs.d/snippets, but also load snippets in ~/.emacs.d/vendor/yasnippet/snippets
(setq yas/root-directory '("~/.emacs.d/snippets"
                           "~/.emacs.d/vendor/yasnippet/snippets"))

;; Map yas/load-directory to every element
(mapc 'yas/load-directory yas/root-directory)

(yas/global-mode 1)

;; This works
;; (setq yas/snippet-dirs '("~/.emacs.d/vendor/yasnippet/snippets"
;;                          "~/.emacs.d/snippets"))

;; (yas/global-mode 1)

(setq yas/prompt-functions '(yas/ido-prompt
                             yas/dropdown-prompt
                             yas/completing-prompt))

;; Replace yasnippets's TAB
(add-hook 'yas/minor-mode-hook
          (lambda () (define-key yas/minor-mode-map
                       (kbd "TAB") 'smart-tab))) ; was yas/expand

