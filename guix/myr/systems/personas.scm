(define-module (myr systems personas)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services sound)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu services)
  #:use-module (gnu services docker)
  #:use-module (gnu system)
  #:use-module (gnu system uuid)
  #:use-module (gnu system file-systems)
  #:use-module (nongnu packages linux)
  #:use-module (myr system base))

(system-config
 #:home
 
 #:system
  (operating-system 
    (host-name "asgaard")
    (firmware (list linux-firmware))

   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))


