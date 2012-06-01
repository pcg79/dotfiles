
;; sh-mode

;; TODO update to use list of zsh mode files
(add-to-list 'auto-mode-alist '("\\.zsh$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-theme$" . sh-mode))

(defun sh-custom ()

  "sh-mode-hook"

  ;; for zsh zsh-files type
  (message "Loaded sh-custom hook: %s" (emacs-version))
  (sh-set-shell "zsh")
  ;; (defun sh-set-shell (shell &optional no-query-flag insert-flag)
  ;; 1639   "Set this buffer's shell to SHELL (a string).
  ;; 1640 When used interactively, insert the proper starting #!-line,
  ;; 1641 and make the visited file executable via `executable-set-magic',
  ;; 1642 perhaps querying depending on the value of `executable-query'.
  ;; 1644 When this function is called noninteractively, INSERT-FLAG (the third
  ;; 1645 argument) controls whether to insert a #!-line and think about making
  ;; 1646 the visited file executable, and NO-QUERY-FLAG (the second argument)
  ;; 1647 controls whether to query about making the visited file executable.
  ;; if shell-file-name extension in zsh-files then load zsh mode
  ;; (sh-set-shell (file-name-sans-extension shell-file-name))
  ;; (set-tab-stops-width-4)

)

(add-hook 'sh-mode-hook 'sh-custom)

