#!/bin/bash

echo "update zshrc"
cp /home/$USER/.zshrc ./
echo "update xinitrc"
cp /home/$USER/.xinitrc ./

echo "update i3"
cp /home/$USER/.config/i3/config ./.config/i3/config
echo "update alacritty"
cp /home/$USER/.config/alacritty/alacritty.yml ./.config/alacritty/alacritty.yml
echo "update picom"
cp /home/$USER/.config/picom/picom.conf ./.config/picom/picom.conf

