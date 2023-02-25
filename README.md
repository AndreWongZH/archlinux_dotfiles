# archlinux_dotfiles

Modifications:

- Shell: zsh
- windows manager: i3wm
- window switcher: rofi
- editor: vim and vscode
- terminal: alacritty
- multiplexer: tmux
- monitor: htop and polybar
- compositor: picom

other repo used:

[alacritty-theme](https://github.com/alacritty/alacritty-theme)

[rofi theme](https://github.com/adi1090x/rofi)

## Steps to install archlinux

1. create bootable USB drive from using the archlinux iso file from their website
2. Boot into archlinux live in UEFI mode
    can verify boot mode by running this line
    ```
    ls /sys/firmware/efi/efivars
    ```
3. Update the system clock
   ```
   timedatectl set-timezone Singapore
   timedatectl status
   ```
4. Using `fdisk`, create 300MB of space for EFI system partition and the rest of the space for the root partition
5. format the root partition
    ```
    mkfs.ext4 /dev/[root partition]
    ```
6. format the efi partition
    ```
    mkfs.fat -F 32 /dev/[efi partition]
    ```
7. mount the file systems
   ```
   mount /dev/[root partition] /mnt
   mount --mkdir /dev/[efi partition] /mnt/boot
   ```
8. install essential packages using pacman
   ```
   pacstrap -K /mnt base linux linux-firmware neovim
   ```
9. generate fstab file
   ```
   genfstab -U /mnt >> /mnt/etc/fstab
   ```
10. change root into archlinux system
    ```
    arch-chroot /mnt
    ```
11. set timezone
    ```
    ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
    hwclock --systohc

    # use local time for archlinux so it does not interfer with windows
    timedatectl set-local-rtc 1
    ```
12. localization
    ```
    locale-gen

    vim /etc/locale.conf
    # add text below
    LANG=en_US.UTF-8
    ```
13. create hostname
    ```
    vim /etc/hostname
    # add hostname inside
    ```
14. set root password
    ```
    passwd
    ```
15. install and configure bootloader (using grub)
    ```
    # install packages
    pacman -S gurb efibootmgr

    # using --removable here because UEFI firmware doesnt detect the boot correctly without it
    # referenced solution in https://bbs.archlinux.org/viewtopic.php?id=250928
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable

    # install package
    pacman -S os-prober

    # uncomment line below in /etc/default/grub
    GRUB_DISABLE_OS_PROBER=false

    # generate grub.cfg file and add archlinux OS to boot
    grub-mkconfig -o /boot/grub/grub.cfg

    # os-prober doesnt detect windows boot manager so i manually added in an entry to grub which points to bootmgfw.efi
    # add to /etc/grub.d/40_custom
    # replace (hd3,gpt3) with the disk number and partition number that points to windows boot manager
    menuentry "Windows boot manager" {
        insmod part_gpt
        insmod chain
        set root='(hd3,gpt3)'
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }

    ```
16. Install networkmanger and dhcpcd (i only need ethernet)
    ```
    pacman -S dhcpcd networkmanager

    systemctl enable NetworkManager.service
    systemctl enable dhcp.service
    ```
17. Create user and give sudo rights
    ```
    pacman -S sudo

    useradd -G wheel -m andre
    passwd andre

    visudo
    # uncomment out the line below
    %wheel ALL=(ALL:ALL) ALL
    ```

