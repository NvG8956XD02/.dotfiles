(define-module (daviwil systems base)
  #:use-module (srfi srfi-1)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system nss)
  #:use-module (gnu system setuid)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(use-service-modules guix admin sysctl pm nix avahi dbus cups desktop linux
                     mcron networking xorg ssh docker audio virtualization)

(use-package-modules nfs certs shells ssh linux bash emacs gnome networking wm fonts libusb
                     cups freedesktop file-systems version-control package-management)

(define-public base-operating-system
  (operating-system
   (host-name "guix")
   (timezone "Europe/Budapest")
   (locale "en_US.utf8")
   (kernel linux)
   (firmware (list linux-firmware))
   (initrd microcode-initrd)
   (kernel-loadable-modules (list v4l2loopback-linux-module))
   (keyboard-layout (keyboard-layout "hu"))

   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))
   (file-systems (cons*
                  (file-system
                   (mount-point "/tmp")
                   (device "none")
                   (type "tmpfs")
                   (check? #f))
                  %base-file-systems))
   (users (cons (user-account
                 (name "davy")
                 (comment "Davy Jones")
                 (group "users")
                 (home-directory "/home/davy")
                 (supplementary-groups '("wheel"  ;; sudo
                                         "netdev" ;; network devices
                                         "kvm"
                                         "tty"
                                         "input"
                                         "docker"
                                         "realtime" ;; Enable realtime scheduling
                                         "lp"       ;; control bluetooth devices
                                         "audio"    ;; control audio devices
                                         "video"))) ;; control video devices

                %base-user-accounts))

   ;; Add the 'realtime' group
   (groups (cons (user-group (system? #t) (name "realtime"))
                 %base-groups))

   ;; Install bare-minimum system packages
   (packages (append (map specification->package
                          '("git"
                            "ntfs-3g"
                            "exfat-utils"
                            "fuse-exfat"
                            "stow"
                            "vim"
                            "emacs-no-x-toolkit"
                            "brightnessctl"
                            "bluez"
                            "bluez-alsa"
                            "xf86-input-libinput"
                            "gvfs"))    ;; Enable user mounts
                     %base-packages))
   (services (append 
	       (list 
		 (service gnome-desktop-service-type)
		 (service xfce-desktop-service-type)
		 (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout)))
                 (udev-rules-service 'pipewire-add-udev-rules pipewire)
                 (udev-rules-service 'brightnessctl-udev-rules brightnessctl)
	         ;; Nix service
                 (service nix-service-type)
                 ;; Schedule cron jobs for system tasks
                 (simple-service 'system-cron-jobs
                                 mcron-service-type
                                 (list
                                  ;; Run `guix gc' 5 minutes after midnight every day.
                                  ;; Clean up generations older than 2 months and free
                                  ;; at least 10G of space.
                                  #~(job "5 0 * * *" "guix gc -d 2m -F 10G"))))
	     %desktop-services))

   ;; Allow resolution of '.local' host names with mDNS
   (name-service-switch %mdns-host-lookup-nss)))
