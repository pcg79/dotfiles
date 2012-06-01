;;; org-mode

(setq load-path (cons "~/.emacs.d/vendor/org-mode/lisp" load-path))
(setq load-path (cons "~/.emacs.d/vendor/org-mode/contrib/lisp" load-path))

;; GTD
;; http://blog.edencardim.com/2011/05/gtd-with-org-mode-part-i/

;; (setq org-modules
;;       '(org-bbdb
;;         org-gnus
;;         org-info
;;         org-jsinfo
;;         org-irc
;;         org-w3m
;;         org-id
;;         org-crypt
;;         org-mac-message
;;         org-attach
;;         org-habit))

(require 'org-install)

(add-to-list 'auto-mode-alist
             '("\\.\\(org\\|org_archive\\)$" . org-mode))

;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-agenda-files (list "~/org/home.org"
;;                              "~/org/work.org"))

;; (setq org-log-done t)

;; http://blog.edencardim.com/2011/05/gtd-with-org-mode-part-2/
(setq org-directory (expand-file-name "~/org"))

(setq org-todo-keywords
      (quote ((sequence
               "TODO(t)"
               "NEXT(n)"
               "STARTED(s)"
               "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "INBOX"))))

(setq org-default-notes-file (concat org-directory "/todo.org"))

(setq org-capture-templates
      (quote
       (("t" "todo" entry (file+headline "todo.org" "inbox")
         "* TODO %?%a\n %U\n"
         :clock-in t
         :clock-resume t))))

(global-set-key (kbd "C-c r") 'org-capture)

(global-set-key "\C-cl" 'org-store-link)

;; (global-set-key (kbd "C-c r") 'remember)
;; (add-hook 'remember-mode-hook 'org-remember-apply-template)
;; (setq org-remember-templates
;;       '((?n "* %U %?" "~/org/inbox.org")))
;; (setq remember-annotation-functions '(org-remember-annotation))
;; (setq remember-handler-functions '(org-remember-handler))

