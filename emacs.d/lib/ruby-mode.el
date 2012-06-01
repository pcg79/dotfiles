;;==============================
;; apidock integration
;; http://simple-and-basic.com/2009/02/emacs-apidock-integration.html
;;==============================
(defun search-apidock-rails ()
  "Search current word in apidock for rails"
  (interactive)
  (let* ((word-at-point (thing-at-point 'symbol))
		(word (read-string "Search apidock for? " word-at-point)))
	(browse-url (concat "http://apidock.com/rails/" word))))

(define-key ruby-mode-map (kbd "C-c d") 'search-apidock-rails)

(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile.lock$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))

