
(require 'tls)
(require 'secrets)

;; TODO: autojoin ##jobon channel

;; (defun start-irc ()
;;   "Connect to IRC."
;;   (interactive)
;;   (erc-tls :server "irc.oftc.net" :port 6697
;;            :nick "ootput" :full-name "ootput"))

(defun erc-freenode ()
  "Connect to freenode."
  (interactive)
  (erc-tls :server "irc.freenode.net"
           :port 6697
           :nick freenode-nick
           :password freenode-password))

;; fires up a new frame and opens servers in there
(defun irc ()
  "Start IRC."
  (interactive)
  (select-frame (make-frame '((name . "Emacs IRC")
                              (minibuffer . t))))
  (call-interactively 'erc-freenode))
;;   (sit-for 1)
;;   (call-interactively 'erc-opn)
;;   (sit-for 1)
;;   (call-interactively 'erc-ifs))


;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

