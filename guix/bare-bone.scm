(use-modules (gnu) 
	     (gnu system nss) 
	     (guix utils)
	     (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules networking ssh desktop)
(use-package-modules screen certs )

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (host-name "ruins")
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
                         (device (file-system-label "guix-linux"))
                         (mount-point "/")
                         (type "btrfs")
                         (options "space_cache=v2,compress=lzo,discard=async,subvol=@")
			 (dependencies mapped-devices))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/home")
                         (type "btrfs")
                         (options "space_cache=v2,compress=zstd,discard=async,subvol=@home")
		         (dependencies mapped-devices))
		       (file-system
                         (device (file-system-label "guix-linux"))
                         (mount-point "/gnu/store")
                         (type "btrfs")
                         (options "space_cache,compress=lzo,discard=async,subvol=@gnu")
		         (dependencies mapped-devices))
                       (file-system
                         (device (uuid "1234-ABCD" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat"))
                 %base-file-systems))

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

  (services  %desktop-services)
  (name-service-switch %mdns-host-lookup-nss))
