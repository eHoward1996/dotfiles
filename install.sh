# Install basic packages.
echo -e "Build basic packages...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    sudo pacman -S \
        arandr \
        base \
        base-devel \
        bash-completion \
        curl \
        git \
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

# Use Trizen to install AUR packages.
echo -e "Build Trizen for AUR support...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
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

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    mkdir ~/.config/antigen
    curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
fi

# Move dotfiles
echo -e "Moving Dotfiles...."
read -p "Continue? (Y/N): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    cp .config/i3 ~/.config
    cp .config/polybar ~/.config
    cp individual_dots/.zprofile ~/.zprofile
    cp individual_dots/.zshrc ~/.zshrc
    sudo cp individual_dots/etc.issue /etc/issue
fi

# Add programming language support? (Requires user input)
echo -e "Add programming language support?"
echo -e "Languages to be installed:\n"
echo -e "\t-Python 3\n\t-Ruby\n\t-Java (JDK)\n"
read -p "Continue? (Y/N): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    trin jdk python ruby
fi