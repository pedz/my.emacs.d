(require 'lsp-docker)

;; In the lsp-mode directory (where lsp-mode.el lives) is a
;; subdirectory called "clients".  In there is a list of "clients".  I
;; can't figure these terms out BUT the list below is a list of these
;; "clients" that you want to be enabled inside the client / server /
;; THING that you are defining / creating.  In my case, as far as I
;; know, I want just the Solargraph "client".
;;
;; Actually this list is just a list of packages to `require' at the
;; time the THING is registered -- so... it is much ado about nothing?
(setq lsp-docker-client-packages
    '(lsp-solargraph))

;; From reading, I guess they call the external server the "server"
;; and the piece either inside or outside of Emacs talking to the
;; server, the "client".  But it gets very confusing (keep reading).
;;
;; Emacs has structures which are defined via `cl-defstruct'.
;; `lsp-clients' is a hash of `lsp--client' structures which has a
;; "slot" `server-id' whose comment is: "Unique identifier for
;; representing the client object.".
;;
;; As mentioned `lsp-clients' is a hash (key value pairs) with the
;; keys being the `server-id' (which is also within the structure).
;;
;; With all that in mind, then:
;;
;; :server-id -- needs to be an existing entry in lsp-clients.  You
;;     can see the list and their priorities by executing:
;;
;;         (maphash
;;          (lambda (key value)
;;            (insert (format "%S  %d\n"
;;                            key
;;                            (lsp--client-priority value))))
;;          lsp-clients)
;;
;;     in the *scratch*  buffer.
;;
;; :docker-server-id -- The name or id of the new "client object"
;;     a.k.a. the `server-id'.  The existing entry is found via the
;;     `server-id', updated, and entered as a new client using the
;;     docker-server-id.
;;
;; :server-command -- This string is munged via
;;     `lsp-docker-launch-new-container' into a list of strings which
;;     is used to start the language server inside the Docker
;;     image/container.  Basically it will turn into:
;;
;;         docker run --name TBD1 --rm -i TBD2 TBD3 `server-command'
;;
;;     TBD1 is `docker-container-name'; TBD2 are `path-mappings' that
;;     have been transformed into a list of "-v" options.  TBD3 is
;;     `docker-image-id'
;;
;; `docker-container-name' and `docker-image-id' will be specified below.
;;
(setq lsp-docker-client-configs
      '((:server-id ruby-ls :docker-server-id rubyls-docker :server-command "/root/bin/solargraph stdio")))

(lsp-docker-init-clients
 :path-mappings '(("/Users/pedz/Source/hatred" . "/hatred"))
 :docker-image-id "pedzsan/hatred:1.0"
 :docker-container-name "docker-ruby-lsp"
 :priority 10
 :client-packages lsp-docker-client-packages
 :client-configs lsp-docker-client-configs)

(provide 'lsp-docker-start)
