
;; setup tramp to do sudo
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

(setq tramp-debug-buffer t)
(setq tramp-verbose 10)

