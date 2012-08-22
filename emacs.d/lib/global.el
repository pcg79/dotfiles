
(global-linum-mode t)
(setq linum-format "%4d ")

;; Change grep based searches to case insensitive
(setq find-grep-options "-q -i")

;; Use command as the meta key
(setq mac-command-modifier 'meta)

;; Use option as the super key
(setq mac-option-modifier 'super)

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Hightlight the current line
(global-hl-line-mode 1)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; Emacs gurus don't need no stinking scroll bars
;; (when (fboundp 'toggle-scroll-bar)
;;   (toggle-scroll-bar -1)
(scroll-bar-mode -1)

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Line-wrapping
(set-default 'fill-column 80)

;; Prevent the annoying beep on errors
;; (setq visible-bell t)
;; (setq visible-bell 'top-bottom)

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Gotta see matching parens
(show-paren-mode t)

;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; For emacsclient
;; (server-start)

;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; Trash can support
(setq delete-by-moving-to-trash t)

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
;; (setq ispell-extra-args '("--sug-mode=ultra"))

;; setup tramp to do sudo
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; ansi-term
(global-set-key "\C-x\C-a" '(lambda ()(interactive)(ansi-term "/usr/local/bin/zsh")))

;; should probably move this
(add-to-list 'auto-mode-alist '(".jst.eco$" . html-mode))

