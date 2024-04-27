(use-modules (gnu) 
	     (gnu system nss) 
	     (guix utils)
	     (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules desktop sddm xorg)
(use-package-modules certs gnome)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (host-name "asgaard")
  (timezone "Europe/Budapest")
  (locale "en_US.utf8")

  (keyboard-layout (keyboard-layout "hu"))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/")
                         (type "btrfs")
                         (options "relatime,space_cache=v2,compress=lzo,subvol=@"))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/home")
                         (type "btrfs")
                         (options "relatime,space_cache=v2,compress=zstd,subvol=@home"))
                       (file-system
                         (device (uuid "1234-ABCD" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  ;; Create user `bob' with `alice' as its initial password.
  (users (cons (user-account
                (name "davy")
                (comment "Davy Jones")
		(home-directory "/home/davy")
                (password (crypt "hamahumi" "$6$abc"))
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  (packages (append (list
                     nss-certs
                     gvfs)
                    %base-packages))

  (services (if (target-x86-64?)
                (append (list (service gnome-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))))
                        %desktop-services)
                (append (list (service mate-desktop-service-type)
                              (service xfce-desktop-service-type)
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout))
                               sddm-service-type))
                        %desktop-services)))
  (name-service-switch %mdns-host-lookup-nss))
