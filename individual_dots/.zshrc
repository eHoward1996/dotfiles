# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep extendedglob
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/oonebaddog/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

#################################################
#		PRETTY COLORS!!!		#	
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
source $HOME/.config/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle robbyrussell/oh-my-zsh plugins/archlinux
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle git
antigen bundle colored-man-pages
antigen bundle colorized
antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

#########################################
#		MACROS..		#
#########################################

function wifi()	{
	cmd=""
	if [ $# = 0 ]; then 
		# Print help menu
		echo -e "Short-hand/more accessable wifi menu"
		echo -e "Available options:"
		echo -e "\ton/off  --> turns wifi or off"
		echo -e "\tlist    --> lists wifi endpoints"
		echo -e "\tconnect --> connect to wifi endpoint"
		echo -e "\n\n Enter remaining args...\n"
		read cmd
	fi
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
			echo -e "Additional credentials needed."
			echo -e "Enter the network name"
			read name
			echo -e "Enter network password"
			read passwd

			nmcli device wifi connect $name password $passwd
			;;
		*) echo "What is this?"
			;;
	esac
			
}

function transmissionctrl()	{
	if [ $1 = "launch"  ] || [ $1 = "start" ]; then
		transmission-daemon \
			--auth \
			--username arch \
			--password linux \
			--port 9091 \
			--allowed "127.0.0.1"
		txt="Launched Transmission\n"
		echo -e "${txt}"
	elif [ $1 = "abort" ]
		killall transmission-daemon
		txt="Aborted Transmission\n"
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
alias install='trin'
alias remove='trre'
