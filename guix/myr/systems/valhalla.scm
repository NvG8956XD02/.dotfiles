(define-module (myr systems valhalla)
  #:use-module (myr utils)
  #:use-module (myr systems base)
  #:use-module (myr systems common)
  #:use-module (myr home-services audio)
  #:use-module (myr home-services games)
  #:use-module (myr home-services video)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services sound)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu services)
  #:use-module (gnu services docker)
  #:use-module (gnu system)
  #:use-module (gnu system uuid)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (nongnu packages linux))

(system-config
 #:home
 (home-environment
  (packages (gather-manifest-packages '(mail)))
  (services (cons* (service home-pipewire-service-type)
                   (service home-video-service-type)
                   (service home-audio-service-type)
                   (service home-streaming-service-type)
                   (service home-games-service-type)
                   common-home-services)))

 #:system
 (operating-system
   (host-name "valhalla")

   ;; Add sof-firmware drivers for audio on ThinkPad X1 Nano
   (firmware (list linux-firmware sof-firmware))

   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

   (file-systems (cons*
                  (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/")
                         (type "btrfs")
                         (options "space_cache=v2,compress=lzo,discard=async,subvol=@"))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/home")
                         (type "btrfs")
                         (options "space_cache=v2,compress=zstd,discard=async,subvol=@home"))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/gnu/store")
                         (type "btrfs")
                         (options "space_cache,compress=lzo,discard=async,subvol=@gnu"))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/var/logs")
                         (type "btrfs")
                         (options "space_cache,compress=lzo,discard=async,subvol=@logs"))
		       (file-system
                         (device "/dev/nvme0n1p1")
                         (mount-point "/boot/efi")
                         (type "vfat"))
                  %base-file-systems))
   ))
