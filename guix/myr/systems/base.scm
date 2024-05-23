(define-module (myr system base)
	       #:use-module (srfi srfi-1)
	       #:use-module (gnu)
	       #:use-module (gnu system)
	       #:use-module (gnu system nss)
	       #:use-module (gnu system setupid)
	       #:use-module (nongnu packages linux)
	       #:use-module (nongnu system linux-initrd)
	       #:export (system-config))

(use-service-modules guix admin sysctl pm nix avahi dbus cups desktop linux
                     mcron networking xorg ssh docker audio virtualization)

(use-package-modules audio video nfs certs shells ssh linux bash emacs
                     networking wm fonts libusb cups file-systems
                     version-control package-management vim)

(define-public base-operating-system (operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (host-name "heim")
  (timezone "Europe/Budapest")
  (locale "en_US.utf8")

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
		(home-directory "/home/davy")
                (password (crypt "hamahumi" "$6$abc"))
                (group "users")
                (supplementary-groups '("wheel" "netdev" "realtime" "kvm" "tty"
                                        "audio" "video" "input" )))
               %base-user-accounts))
  
   ;; Add the 'realtime' group
   (groups (cons (user-group (system? #t) (name "realtime"))
                 %base-groups)) 

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
                            "xf86-input-libinput"))    ;; Enable user mounts
                     %base-packages))

  (services  (append (list
	       ;; Networking services
               (service network-manager-service-type
                        (network-manager-configuration
                         (vpn-plugins
                          (list network-manager-openvpn))))
               (service wpa-supplicant-service-type) ;; Needed by NetworkManager
               (service modem-manager-service-type)  ;; For cellular modems
               (service bluetooth-service-type
                        (bluetooth-configuration
                         (auto-enable? #t)))
               (service usb-modeswitch-service-type)
               
               (simple-service 'system-cron-jobs
                                 mcron-service-type
                                 (list
                                  ;; Run `guix gc' 5 minutes after midnight every day.
                                  ;; Clean up generations older than 2 months and free
                                  ;; at least 10G of space.
                                  #~(job "5 0 * * *" "guix gc -d 2m -F 10G"))))

	       %desktop-services))
  (name-service-switch %mdns-host-lookup-nss)))
