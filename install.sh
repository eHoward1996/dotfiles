# Install basic packages.
echo -e "Build basic packages...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm != [nN] ]]; then
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
        zip \
        zsh
fi

# Move dotfiles
echo -e "Moving Dotfiles...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm != [nN] ]]; then
    mkdir ~/.config
    
    pwd

    cp dotfiles/.config/i3 ~/.config
    cp dotfiles/.config/polybar ~/.config
    cp dotfiles/individual_dots/.zprofile ~/.config/zsh/.zprofile
    cp dotfiles/individual_dots/.zshrc ~/.config/zsh/.zshrc
    sudo cp individual_dots/etc.issue /etc/issue
fi

# Use Trizen to install AUR packages.
echo -e "Build Trizen for AUR support...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm != [nN] ]]; then
    git clone https://aur.archlinux.org/trizen.git
    cd trizen
    makepkg -si
    cd ..
    trizen -S \
        compton \
        google-chrome \
        nerd-fonts-complete \
        polybar \
        termite-git
fi

# Add Antigen to build.
echo -e "Build Antigen for added ZSH support...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm != [nN] ]]; then
    mkdir ~/.config/antigen
    curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
fi

# Add programming language support? (Requires user input)
echo -e "Add programming language support?"
echo -e "Languages to be installed:\n"
echo -e "\t-Python 3\n\t-Ruby\n\t-Java (JDK)\n"
read -p "Continue? (Y/N): " confirm

if [[ $confirm != [nN] ]]; then
    trin jdk python ruby
fi