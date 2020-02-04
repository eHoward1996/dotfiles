# Install basic packages.
echo -e "Building packages...."
sudo pacman -S \
        arandr \
        bash-completion \
        curl \
        go \
        i3blocks \
        i3-gaps \
        i3-wm \
        neofetch \
        python-pywal \
        ranger \
        rofi \
        scrot \
        tar \
        unrar \
        unzip \
        vim \
        xorg \
        xorg-xinit \
        zip \
        zsh

# Set user shell
echo -e "Changing user shell to ZSH"
chsh -s /usr/bin/zsh

# Move dotfiles
echo -e "Moving Dotfiles...."
mkdir ~/.config
mkdir ~/.config/zsh
mkdir ~/.config/rofi

yes | cp -rf ./.config/i3                       ~/.config
yes | cp -rf ./.config/polybar                  ~/.config
yes | cp -rf ./individual_dots/.zprofile        ~/.config/zsh/.zprofile
yes | cp -rf ./individual_dots/.zshrc           ~/.config/zsh/.zshrc
yes | cp -rf ./individual_dots/base.rasi        ~/.config/rofi/base.rasi
yes | cp -rf ./individual_dots/.Xresources      ~/.Xresources
yes | sudo cp -rf ./individual_dots/etc.issue   /etc/issue

touch ~/.zshenv
echo -e "export ZDOTDIR=$HOME/.config/zsh" > ~/.zshenv

# Use Trizen to install AUR packages.
echo -e "Using Trizen for AUR support...."
cd ~/.config
mkdir trizen
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ..

trizen -S \
    compton \
    google-chrome \
    nerd-fonts-complete \
    polybar \
    termite-git \
    feh \
    nemo \
    visual-studio-code-bin \
    ttf-fira-code \
    otf-fira-code \
    nordvpn-bin \
    transmission-cli \
    firefox \
    visual-studio-code-bin \
    ttf-ms-fonts \
    
    
systemctl enable nordvpnd.service
systemctl start nordvpnd.service

mkdir ~/.config/termite && touch ~/.config/termite/config

# Add Antigen to build.
echo -e "Adding Antigen for added ZSH support...."
mkdir ~/.config/antigen
touch ~/.config/antigen/antigen.zsh
cp dotfiles/individual_dots/antigen.zsh ~/.config/antigen/antigen.zsh

# Add programming language support? (Requires user input)
echo -e "Installing programming languages (Java, Python 3, Ruby)..."
trin jdk python ruby

echo -e "Moving Pictures to Home Directory"
mkdir ~/Pictures
mkdir ~/Pictures/Wallpapers
cp dotfiles/Pictures/Wallpapers/* ~/Pictures/Wallpapers

echo -e "Moving .xinitrc"
touch ~/.xinitrc
cp dotfiles/individual_dots/.xinitrc ~/.xinitrc
