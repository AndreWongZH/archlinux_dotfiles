#!/bin/bash

echo "checking in $USER home folder for changes in dotfiles"

echo "diff zshrc"
diff .zshrc /home/$USER/.zshrc
echo "diff xinitrc"
diff .xinitrc /home/$USER/.xinitrc

echo "diff i3"
diff .config/i3/config /home/$USER/.config/i3/config
echo "diff alacritty"
diff .config/alacritty/alacritty.yml /home/$USER/.config/alacritty/alacritty.yml
echo "diff picom"
diff .config/picom/picom.conf /home/$USER/.config/picom/picom.conf
echo "diff polybar"
diff .config/polybar/config.ini /home/$USER/.config/polybar/config.ini
diff .config/polybar/launch.sh /home/$USER/.config/polybar/launch.sh
echo "diff rofi"
diff -r .config/rofi /home/$USER/.config/rofi
