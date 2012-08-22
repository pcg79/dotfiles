
;; Enable a backtrace when problems
(setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/lib/custom.el")
(load custom-file 'noerror)

(load "lib/env")
(load "lib/secrets")

(load "lib/bindings")
(load "lib/defuns")
(load "lib/erc")
(load "lib/fonts")
(load "lib/global")
(load "lib/icomplete-mode")
(load "lib/ido")
(load "lib/org-mode")
(load "lib/sh-mode")
(load "lib/tabs")
(load "lib/utf-8")

(vendor 'actionscript-mode)
(vendor 'coffee-mode)
(vendor 'color-theme)
(vendor 'haml-mode)
(vendor 'inf-ruby)
(vendor 'js2-mode 'js2-mode)
(vendor 'magit)
(vendor 'markdown-mode)
(vendor 'mode-line-bell)
(vendor 'mustache-mode)
(vendor 'popwin)
(vendor 'rainbow-mode)
(vendor 'rinari)
(vendor 'ruby-mode)
(vendor 'rvm)
(vendor 'sass-mode)
(vendor 'yaml-mode 'yaml-mode)
(vendor 'yari)
(vendor 'yasnippet)
