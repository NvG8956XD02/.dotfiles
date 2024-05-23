(define-module (myr home-services emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (guix gexp)
  #:use-module (guix transformations)

  #:export (home-emacs-config-service-type))

(define transform
  (options->transformation
   ;; 2.3.0 does not include the `box :style none` fix
   '((with-commit . "emacs-doom-themes=3b2422b208d28e8734b300cd3cc6a7f4af5eba55"))))

(define (home-emacs-config-profile-service config)
  (map (lambda (package-name)
         (transform
          (specification->package+output package-name)))
       (list "emacs-evil"
             "emacs-evil-collection")))

(define home-emacs-config-service-type
  (service-type (name 'home-emacs-config)
                (description "Applies my personal Emacs configuration.")
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-emacs-config-profile-service)))
                (default-value #f)))
