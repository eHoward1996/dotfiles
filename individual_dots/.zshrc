# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep extendedglob
bindkey -v

# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/oonebaddog/.config/zsh/.zshrc'

autoload -Uz compinit
compinit -d ~/.config/zsh/zcompdump-$ZSH_VERSION
# End of lines added by compinstall

bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#################################################
#             Export some variables             #
#################################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

#################################################
#		         PRETTY COLORS!!!	       	    #	
#################################################

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)

# Install powerlevel9k for antigen
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

POWERLEVEL9K_VCS_GIT_GITHUB_ICON=
POWERLEVEL9K_LINUX_ARCH_ICON=
POWERLEVEL9K_TIME_ICON=

# Antigen Config
export ADOTDIR=$HOME/.config/antigen/info
source $HOME/.config/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle robbyrussell/oh-my-zsh plugins/archlinux
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle git
antigen bundle colored-man-pages
antigen bundle colorized
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

#########################################
#		        MACROS..                #
#########################################

function wifi()	{
	cmd=""
	
	# Print commands
	echo -e "Short-hand/more accessible wifi menu"
	echo -e "Available options:"
	echo -e "\ton/off  --> turns wifi on or off"
	echo -e "\tlist    --> lists wifi endpoints"
	echo -e "\tconnect --> connect to wifi endpoint"
	echo -e "\nEnter remaining args...\n"
	read cmd
	
	case $cmd in
		"on") 
			echo -e "Turning wifi on"
			nmcli networking on
			;;
		"off")
			echo -e "Turning wifi off"
			nmcli networking off
			;;
		"list")
			echo -e "Available endpoints"
			nmcli device wifi
			;;
		"connect")
			nmcli device wifi
			echo -e "Enter the network name"
			read name
			echo -e "Enter network password"
			read passwd

			if [[ ! $passwd ]]; then
				nmcli device wifi connect $name
			else
			nmcli device wifi connect $name password $passwd
			fi
			;;
		*) echo "What is this?"
			;;
	esac

	source ~/.config/i3/logIP.sh			
}

function transmissionctrl()	{
	if [ $1 = "launch"  ] || [ $1 = "start" ]; then
		nordvpn connect United_Kingdom
		transmission-daemon \
			--auth \
			--username arch \
			--password linux \
			--port 9091 \
			--allowed "127.0.0.1"
		txt="Launched Transmission"
		echo -e "${txt}"
	elif [ $1 = "abort" ]
		killall transmission-daemon
		nordvpn disconnect
		txt="Aborted Transmission"
		echo -e "${txt}"
}

function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f "$1" ] ; then
            NAME=${1%.*}
            #mkdir $NAME && cd $NAME
            case "$1" in
                *.tar.bz2)   tar xvjf ./"$1"    ;;
                *.tar.gz)    tar xvzf ./"$1"    ;;
                *.tar.xz)    tar xvJf ./"$1"    ;;
                *.lzma)      unlzma ./"$1"      ;;
                *.bz2)       bunzip2 ./"$1"     ;;
                *.rar)       unrar x -ad ./"$1" ;;
                *.gz)        gunzip ./"$1"      ;;
                *.tar)       tar xvf ./"$1"     ;;
                *.tbz2)      tar xvjf ./"$1"    ;;
                *.tgz)       tar xvzf ./"$1"    ;;
                *.zip)       unzip ./"$1"       ;;
                *.Z)         uncompress ./"$1"  ;;
                *.7z)        7z x ./"$1"        ;;
                *.xz)        unxz ./"$1"        ;;
                *.exe)       cabextract ./"$1"  ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "'$1' - file does not exist"
        fi
    fi
}

function yt2mp3	{
	(
		cd ~/Programs/'Python Programs'
		python youtube_dl.py $1
	)
}


#########################################
#		        Aliases                 #
#########################################
alias load="trin"
alias remove="trrem"
alias has="trlocs"
alias aur="trreps"
alias progs="trlst"
alias vpn="nordvpn"
