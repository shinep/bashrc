######################
# DEPENDANCIES

#sudo apt-get install xmllint
#install libxml2-utils (for debian)
#sudo apt-get install figlet
#sudo apt-get install secure-delete
#sudo apt-get install git
######################

# Define a few Colours
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color


#------------------------------------------
#------WELCOME MESSAGE---------------------
# customize this first message with a message of your choice.
# this will display the username, date, time, a calendar, the amount of users, and the up time.
clear
# Gotta love ASCII art with figlet
#figlet "Welcome, " $USER;
#echo -e ""
#echo -ne "Today is "; date
#echo -e  "${BROWN}"; df ;
#echo -e  "${LIGHTBLUE}"; uname -a ;
#echo -e  "${BROWN}"; free ;
#echo -e ""
echo -ne "${BROWN}Up time:";uptime | awk /'up/'
#echo "";


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# correct misspelled directories
shopt -s cdspell

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\][\t]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w[\t]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:ignoredups
export HISTIGNORE=l:ls:ps:cd:exit
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
bind '"\e[A":history-search-backward'
bind '"\e[A":history-search-backward'

# make backups of files
or () {
	if [ -e "$@" ]; then
		for i in "$@"
		do
			cp "$i" "$i".orig
		done
	fi
}

# extract archive files
extract () {
	if [ -f "$1" ] ; then
		for i in "$@"
		do
			case "$i" in
				*.tar.bz2)	tar xvjf "$i"	;;
				*.tar.gz)		tar xvzf "$i"	;;
				*.bz2)		bunzip2 "$i"	;;
				*.rar)		unrar x "$i"	;;
				*.gz)		gunzip "$i"	;;
				*.tar)		tar xvf "$i"	;;
				*.tbz2)		tar xvjf "$i"	;;
				*.tgz)		tar xvzf "$i"	;;
				*.zip)		unzip "$i"	;;
				*.Z)		uncompress "$i"	;;
				*.7z)		7z x "$i"		;;
				*)		echo "'$i' cannot be extracted via >extract<" ;;
			esac
		done
	else
		echo "'$i' is not a valid file"
	fi
}

export EDITOR=/usr/bin/vi
export GREP_OPTIONS=--color=auto
export GREP_COLORS='ms=01;36'
export PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}:${PWD}\007"'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PS1='\[\e[0;32m[\t]\e[m$(tput setaf 3)\]\u@\h:\[$(tput sgr0)$(tput setaf 6)\]\w\[$(tput sgr0)$(tput setaf 2)\] $(__git_ps1 "[%s]") \[$(tput sgr0)\]$ '

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

## Aliases

alias -p f="find . -iname -type f"
alias install='sudo -E apt-get install'
alias search='sudo -E apt-cache search'
alias show='sudo -E apt-cache show'
alias remove='sudo -E apt-get purge'
alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
alias cleanup='sudo -E apt-get autoclean && sudo -E apt-get autoremove && sudo -E apt-get clean && sudo -E apt-get remove && orphand'
alias updatedb='sudo updatedb'
alias df='df -h -x tmpfs -x usbfs'
alias du='du -h --max-depth=1'
# empty trash
alias trash="rm -fr ~/.local/share/Trash"
alias ls='ls --color=auto'
alias less='less -W'
alias rm='srm -rvz'
alias xmllint='xmllint --format'
alias ll='ls -l --group-directories-first'
alias mkdir='mkdir -p'
alias cp="cp -v"
alias grep='grep -iIr --color=tty'
alias free='free -m'
alias ports="lsof -i -n -P"
alias ps='ps auxfwww'
alias ping='ping -c 10'
alias openports='netstat -nape --inet'
alias ssh-keygen='ssh-keygen -Rv'
alias gpull='git pull origin master -u'

# Anti-virus checks

alias rkhunter='sudo rkhuter --check'
alias clamscan='sudo clamscan -irv --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/media --exclude=/mnt'
alias lynis='sudo lynis -c'
alias tiger='sudo tiger'


export HISTIGNORE="ls:cd:[bf]g:exit"

#Automatically do an ls after each cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ll
  else
    builtin cd ~ && ll
  fi
}

md() {
    mkdir -p -v $1
    cd $1
}

xlint() {
  xmllint --output $1 --format $1
}

netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
echo ""
/sbin/ifconfig | awk /'Bcast/ {print $3}'
echo ""
/sbin/ifconfig | awk /'inet addr/ {print $4}'
echo ""
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
echo "---------------------------------------------------"
}

mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

myip()
{
wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//';
}

txtrst='\e[0m'    # Text Reset
txtcyn='\e[0;36m' # Cyan
txtpur='\e[0;35m' # Violet



functions()
{
  echo -e "\n${txtpur}FUNCTIONS
----------------------------------------------------------------------${txtrst}"
  echo -e "${txtcyn}cd 		: ${txtrst}automatically do an ls after each cd"
  echo -e "${txtcyn}extract <file> 	:${txtrst} extract a file"
  echo -e "${txtcyn}md 		: ${txtrst}creates dir structure and cd into the last one."
  echo -e "${txtcyn}myip 		: ${txtrst}gets my external ip address"
  echo -e "${txtcyn}mktar() <directory> :${txtrst} create a tar archive file"
  echo -e "${txtcyn}mktgz() <directory> :${txtrst} create a tar.gz archive file"
  echo -e "${txtcyn}mktbz() <directory> :${txtrst} create a tar.bz2 archive file"
  echo -e "${txtcyn}netinfo 	: ${txtrst}gets my internal ip address"
  echo -e "${txtcyn}or <filename> 	: ${txtrst}creates a backup file"
  echo -e "${txtcyn}up <number> 	: ${txtrst}goes <number> level up like cd .."
  echo -e "${txtcyn}xlint 	: ${txtrst}formats an xml document"
  echo -e "${txtcyn}pullall 	: ${txtrst}pulls all the git respositories in ~/workspace directory"
  echo -e ""
  echo -e "${txtcyn}tips 		: ${txtrst}general tips"
  echo -e "${txtcyn}bashtips 	: ${txtrst}tips on bash terminal"
  echo -e "${txtcyn}emacstips 	: ${txtrst}tips on emacs and clojure mode"
  echo -e "${txtcyn}vitips 		: ${txtrst}tips on vi"
  echo -e "${txtcyn}lesstips 	: ${txtrst}tips on less"
  echo -e "${txtcyn}tcpdumptips 	: ${txtrst}tips on tcpdump"
  echo -e "${txtcyn}mongotips 	: ${txtrst}basic mongo functionality"
  echo -e "${txtcyn}debugtips 	: ${txtrst}tips on debugging production servers"
  echo -e "${txtcyn}rangertips 	: ${txtrst}tips on using ranger"
  echo -e "${txtcyn}magittips 	: ${txtrst}tips on using magit"
}

function bashtips {
echo -e "${txtpur}HISTORY
----------------------------------------------------------------------${txtrst}
${txtcyn}!!        ${txtrst}last command
${txtcyn}!!:p      ${txtrst}Overview without execution of the last command
${txtcyn}!?foo     ${txtrst}Last command containing foo
${txtcyn}^foo^bar^ ${txtrst}Last command containing foo, but substitute with bar
${txtcyn}!$        ${txtrst}Last argument of the last command
${txtcyn}!*        ${txtrst}All the arguments of the last command
${txtcyn}[Ctrl]-s  ${txtrst}Search forward through the history
${txtcyn}[Ctrl]-r  ${txtrst}Search in back in history

${txtpur}ONLINE EDITION
----------------------------------------------------------------------${txtrst}
${txtcyn}[Ctrl]-a     ${txtrst}go to the beginning of the line
${txtcyn}[Ctrl]-e     ${txtrst}go to the end of the line
${txtcyn}[ Alt]-d     ${txtrst}deletes to the end of a word
${txtcyn}[Ctrl]-w     ${txtrst}erased until the beginning of a word
${txtcyn}[ Alt]-backspace     ${txtrst}erased until the beginning of a word
${txtcyn}[Ctrl]-k     ${txtrst}clears until the end of the line
${txtcyn}[Ctrl]-u     ${txtrst}erased until the beginning of the line
${txtcyn}[Ctrl]-xx    ${txtrst}move between start of command line and current cursor position (and back again)
${txtcyn}[Ctrl]-y     ${txtrst}paste the contents of the buffer
${txtcyn}[Ctrl]-o     ${txtrst}If you hit CTRL+o after picking a command from your history, the command is executed, and the next command from history is prepared on the prompt

${txtcyn}[Ctrl]-LRArrow     ${txtrst}Move between words

${txtpur}COMPLETION
----------------------------------------------------------------------${txtrst}
${txtcyn}[ Alt].      ${txtrst}scroll through the arguments of the last command

${txtpur}MISC
----------------------------------------------------------------------${txtrst}
${txtcyn}[command or \"grep\" or \]      ${txtrst}ignore aliases if present
${txtcyn}[Ctrl]-s     ${txtrst}stop printing output to the console
${txtcyn}[Ctrl]-r     ${txtrst}resume printing output to the console
${txtpur}----------------------------------------------------------------------
"
}


tips()
{
  echo ""
  echo -e "${txtcyn}top     		: ${txtrst}f-to show options,c-to show full path,1-to show individual cpus,h-help,z-color"
  echo -e "${txtcyn}ssh     		: ${txtrst}~[Ctrl]-Z to get back to local terminal, fg %1 to bring back ssh session. ssh-copy-id user@host
                          ~. disconnect, ~? help, ~# list forwarded connections"
  echo ""
  echo -e "${txtcyn}zip -e zip-name files     	: ${txtrst}for zipping with a password"
  echo -e "${txtcyn}time (command) > /dev/null      : ${txtrst}to time a command"
  echo ""
  echo -e "${txtcyn}[ Alt]-number 		: ${txtrst}switches between tabs in terminal"
  echo -e "${txtcyn}w  last lastb     	: ${txtrst}shows information about users logged in"
  echo -e "${txtcyn}dirs pushd popd     	: ${txtrst}for listing, storing and popping directory locations"
  echo -e "${txtcyn}dpkg -l | less -W     	: ${txtrst}lists all installed packages"
  echo -e "${txtcyn}cat -v OR vi -b     	: ${txtrst}to show non-printable characters"
  echo -e "${txtcyn}pgrep <text> pkill    	: ${txtrst}search and kill using process name"
  echo -e "${txtcyn}kill -3 <pid>    	: ${txtrst}to get a thread dump of the process without killing it, -9 will kill it"
  echo -e "${txtcyn}man -k <command name>   : ${txtrst}to search the man pages for a command"
  echo ""
  echo -e "${txtcyn}Various commands1       : ${txtrst}mkdir -p *, rm -- -file.txt, type <command>, file <filename>,(head;tail) < (file),update-alternatives --config editor"
  echo ""
 }

function emacstips {
echo -e "${txtpur}GENERAL
----------------------------------------------------------------------${txtrst}
${txtcyn}[C]-x-[C]-f     ${txtrst}open file
${txtcyn}[C]-x-f         ${txtrst}open recently opened files
${txtcyn}[C]-x-[C]-b     ${txtrst}open buffer
${txtcyn}[C]-x-b         ${txtrst}open mini buffer
${txtcyn}[C]-x-[C]-c     ${txtrst}will kill emacs after saving all changes.
${txtcyn}[C]-x-K        ${txtrst}to kill individual buffers

${txtcyn}[C]-x-3         ${txtrst}vertically split windows
${txtcyn}[C]-x-2         ${txtrst}horizontally split windows
${txtcyn}[C]-x-0         ${txtrst}close the current window
${txtcyn}[C]-x-1         ${txtrst}maximise the current window
${txtcyn}[C]-x-O         ${txtrst}switch between windows
${txtcyn}[C]-x-left/right arrow         ${txtrst}move between files within the buffer

${txtcyn}[C]-x-H         ${txtrst}selects all
${txtcyn}[C]-Space       ${txtrst}to start marking region
${txtcyn}[C]-W           ${txtrst}cut the region
${txtcyn}[Alt]-W         ${txtrst}copy the region
${txtcyn}[C]-Y           ${txtrst}to paste
${txtcyn}[Alt]-Y         ${txtrst}to traverse through clip board
${txtcyn}[C]-x-U         ${txtrst}shows the clipboard buffer
${txtcyn}[C]-Q           ${txtrst}to get out of the undo window or the clipboard buffer
${txtcyn}[C]-V           ${txtrst}page down
${txtcyn}[Alt]-V         ${txtrst}page up
${txtcyn}[C]-/           ${txtrst}undo the last change
${txtcyn}[Alt]-_         ${txtrst}redo last change

${txtcyn}[C]-x-+         ${txtrst}to increase the font size
${txtcyn}[C]-x--         ${txtrst}to decrease the font size
${txtcyn}[C]-x-0         ${txtrst}to normal font size

${txtcyn}[C]-S           ${txtrst}to seach repeatedly
${txtcyn}[Alt]-X-isearch-query-replace           ${txtrst}replace text or Alt-x replace-string
${txtcyn}[Alt]-X-linum-mode           ${txtrst}to show line numbers (type again to get rid of them)
${txtcyn}[Alt]-X-follow-mode           ${txtrst}to show lengthy files in two buffers
${txtcyn}[Alt]-X-shell-command-on-region wc           ${txtrst}to execute a shell command on region

${txtpur}CLOJURE
----------------------------------------------------------------------${txtrst}
${txtcyn}[C]-c-[A]-J     ${txtrst}start nrepl (Alt-x nrepl-jack-in)
${txtcyn}[C]-c-[C]-K     ${txtrst}load the current file and any of its dependencies
${txtcyn}[C]-c-[A]-N     ${txtrst}load the current name space in repl
${txtcyn}[C]-x-[C]-E     ${txtrst}evaluate the form just preceedes the cursor
${txtcyn}[C]-[A]-X       ${txtrst}evaluate the outer form (just need to anywhere inside the function)
${txtcyn}[C]-U           ${txtrst}in front of the above two commands to get the evaluated value.(*1 returns the last result, also use *2 ,*3)
${txtcyn}[C]-x-up/down arrow       ${txtrst}to traverse the nrepl history
${txtcyn}[A]-Q           ${txtrst}format inside a method
${txtcyn}[C]-x-H-Tab     ${txtrst}selects the whole file and use tab to format it
${txtcyn}[A]-.           ${txtrst}to go to the function definition while cursor on the function
${txtcyn}[A]-,           ${txtrst}get back to the current location after viewing the function definition
${txtcyn}[C]-x-[C]-I     ${txtrst}show all the functions inside a file
${txtpur}----------------------------------------------------------------------
"
}

function vitips {
echo -e "${txtpur}
----------------------------------------------------------------------${txtrst}
${txtcyn}[i]     ${txtrst}inserts text to the left of cursor
${txtcyn}[o]     ${txtrst}begins a new line below the current line
${txtcyn}[O]     ${txtrst}drops the current line and begins a new line in its place
${txtcyn}[A]     ${txtrst}appends at the end of the current line

${txtcyn}[r]     ${txtrst}replaces the character under cursor
${txtcyn}[R]     ${txtrst}replaces characters untill ESC is pressed

${txtcyn}[x]     ${txtrst}deletes a single character
${txtcyn}[dd]    ${txtrst}deletes the whole line
${txtcyn}[dw]    ${txtrst}deletes a word
${txtcyn}[D,d$]     ${txtrst}deletes all text from cursor to end of line

${txtcyn}[yy]    ${txtrst}copies the line of the text
${txtcyn}[yw]    ${txtrst}copies from the current cusror pos to end of word
${txtcyn}[y$]    ${txtrst}copies from the current cursor pos to end of line
${txtcyn}[yG]    ${txtrst}copies from the current cursor pos to end of file
${txtcyn}[P]     ${txtrst}pastes the text after the cursor
${txtcyn}[U]     ${txtrst}Undo all changes made to a line
${txtcyn}[G]     ${txtrst}end of the file
${txtcyn}[gg]    ${txtrst}start of the file

${txtcyn}[Ctrl-F]     ${txtrst}Move forward a page
${txtcyn}[Ctrl-B]     ${txtrst}Move backward a page
${txtcyn}[Ctrl-U]     ${txtrst}Move up half a page
${txtcyn}[Ctrl-D]     ${txtrst}Move down half a page
${txtcyn}[Ctrl-i]     ${txtrst}Jump to the previous location
${txtcyn}[Ctrl-o]     ${txtrst}Jump to the next location
${txtcyn}[Ctrl-G]     ${txtrst}shows file name, total lines and current position

${txtcyn}[n]              ${txtrst}search forward (start the search with /search-term or ?search-term)
${txtcyn}[N]              ${txtrst}search backwardward
${txtcyn}[:%s/bob/BOB/gc]  ${txtrst}replaces all instances of bob with BOB globally with confirmation
${txtcyn}[:%s//BOB/gc]     ${txtrst}replaces all instances of last search with BOB globally with confirmation

${txtcyn}[:set all]        ${txtrst}to view all the options
${txtcyn}[:set nu]         ${txtrst}set line number
${txtcyn}[:set nonu]       ${txtrst}unset line number
${txtcyn}[:set ic]         ${txtrst}ignore case for searching
${txtcyn}[:split file2]    ${txtrst}split window horizontally and open file2
${txtcyn}[:vsplit]         ${txtrst}split window vertically
${txtcyn}[Ctrl+W]          ${txtrst}to switch between windows
${txtcyn}[:close]          ${txtrst}to close the split window
${txtcyn}[:only]           ${txtrst}closes all the other split windows except the current one

${txtcyn}[:q!]     ${txtrst}quits without saving changes
${txtcyn}[:x]      ${txtrst}exits vi and prompts for saving
${txtcyn}[:wq]     ${txtrst}writes and quits vi
${txtcyn}[ZZ]      ${txtrst}saves and quits vi
${txtcyn}[:e!]     ${txtrst}undo all changes and reverts to the original state

${txtcyn}[:! ls -l]           ${txtrst}run external commands inside vi
${txtcyn}[:w !sudo tee %]     ${txtrst}save a read only file in Vi

${txtcyn}[+number file]      ${txtrst}open and go to the number-th line in the file (+/search-term)
${txtcyn}[#]                 ${txtrst}search backward for the current word
${txtcyn}[*]                 ${txtrst}search forward for the current word
${txtcyn}[g*]                ${txtrst}search forward for any word with current word part of it
${txtcyn}[+ file]            ${txtrst}open and go to the last line in the file
${txtpur}----------------------------------------------------------------------
"
}


function lesstips {
echo -e "${txtpur}
----------------------------------------------------------------------${txtrst}
${txtcyn}[g]     ${txtrst}go to the begining of the file
${txtcyn}[q]     ${txtrst}quit less
${txtcyn}[F]     ${txtrst}press F while less is open is simialr ro tail -f

${txtcyn}[v]     ${txtrst}open the current file in the configured editor
${txtcyn}[h]     ${txtrst}show summary of less commands

${txtcyn}[ma]           ${txtrst}mark the current position with letter a
${txtcyn}['a]           ${txtrst}go to the marked position 'a'
${txtcyn}[&pattern]     ${txtrst}display only the matching lines, not all.

${txtcyn}[:e file2]     ${txtrst}open another file
${txtcyn}[:n]           ${txtrst}next file
${txtcyn}[:p]           ${txtrst}previous file
${txtpur}----------------------------------------------------------------------
"
}

function tcpdumptips {
echo -e "${txtpur}
----------------------------------------------------------------------${txtrst}
${txtcyn}[-i etho]     ${txtrst}capture packets from a aparticular interface etho
${txtcyn}[-A]          ${txtrst}display captured packets in ASCII
${txtcyn}[-n]          ${txtrst}capture packets with IP address
${txtcyn}[-tttt]       ${txtrst}capture packets with proper readable timestamps
${txtcyn}[tcp]         ${txtrst}capture packets of TCP type (udp,ip, ip6 etc)

${txtcyn}[port 80]          		${txtrst}capture packets only on port 80
${txtcyn}[dst 1.2.3.4]      		${txtrst}capture packets for destination 1.2.3.4
${txtcyn}[dst 1.2.3.4 and port 80]      ${txtrst}capture packets for destination 1.2.3.4 and port 80

${txtcyn}[-w file.pcap]     ${txtrst}capture packets and write to file
${txtcyn}[-r file.pcap]     ${txtrst}read from file (use -tttt as well)
${txtpur}----------------------------------------------------------------------
"
}

mongotips()
{
  echo -e "${txtcyn}mongo <host-name>"
  echo -e "${txtcyn}show dbs"
  echo -e "${txtcyn}use <db-name>"
  echo -e "${txtcyn}show collections"
  echo -e "${txtcyn}db.messages.find({'subject.type':'event'}).count()"
  echo -e "${txtcyn}db.messages.find({'subject.type':'event'}).pretty()"
  echo -e "${txtcyn}db.messages.remove({'subject.type':'event'})"

 }

debugtips()
{
  echo -e "${txtcyn}Look in /var/log/jetty or jboss and /usr/log/* using tail -F"
  echo -e "${txtcyn}pstree, top , iostat -x 5 , kill -3 <java process-id> "
  echo -e "${txtcyn}http://<serviceName>/Library/1.x/info/threads"
  echo -e "${txtcyn}http://<serviceName>/Library/1.x/info/metrics"
}

function rangertips {
echo -e "${txtpur}
----------------------------------------------------------------------${txtrst}
${txtcyn}[s]     ${txtrst}opens a shell for commands like rm etc.
${txtcyn}[r]     ${txtrst}displays open-with for specifying vi,emacs etc.
${txtcyn}[E]     ${txtrst}opens the file in default editor for editing.
${txtcyn}[i]     ${txtrst}showing info/contents of the file.
${txtcyn}[I]     ${txtrst}rename the current file.

${txtcyn}[h]     ${txtrst}go backward in history.
${txtcyn}[l]     ${txtrst}go forward in history.

${txtcyn}[Space]     ${txtrst}selects a file/directory.
${txtcyn}[Escape]    ${txtrst}cancels the last command.
${txtcyn}[f<dname>]  ${txtrst}jump to directory.

${txtcyn}[V]      ${txtrst}enables viual selection mode.
${txtcyn}[u?]     ${txtrst}universal undo key.
${txtcyn}[uv]     ${txtrst}clear all the selection.

${txtcyn}[dd]     ${txtrst}to paste
${txtcyn}[yy]     ${txtrst}to copy
${txtcyn}[pp]     ${txtrst}to paste

${txtcyn}[gn]     ${txtrst}new tab
${txtcyn}[gh]     ${txtrst}to home directory
${txtcyn}[gc]     ${txtrst}close tab
${txtcyn}[gg]     ${txtrst}go to the begining
${txtcyn}[G]      ${txtrst}go to end.
${txtcyn}[q]      ${txtrst}to quit

${txtcyn}[?]          ${txtrst}displaying man page
${txtcyn}[; or :]     ${txtrst}open command tool bar (cut, copy, delete, paste,rename etc).
${txtcyn}[2?]         ${txtrst}list all commands that could be used on the shell
${txtcyn}[/s]         ${txtrst}searching file s in current directory.

${txtpur}----------------------------------------------------------------------
"
}

function magittips {
echo -e "${txtpur}
----------------------------------------------------------------------${txtrst}
${txtcyn}[Ctrl-X g]      ${txtrst}view magit status.
${txtcyn}[Tab]           ${txtrst}toggle viewing changes to a file.
${txtcyn}[s S]     	${txtrst}stage a file | all files.
${txtcyn}[u U]     	${txtrst}unstage a file | all files.
${txtcyn}[i I]     	${txtrst}add to gitignore | exclude file.
${txtcyn}[k]     	${txtrst}discard changes to a file.
${txtcyn}[c]     	${txtrst}start commit process and add a message.
${txtcyn}[Ctrl-C Ctrl-C]     	${txtrst}finishes the commit.
${txtcyn}[Ctrl-C K]     		${txtrst}discard the commit by killing the buffer.
${txtcyn}[Ctrl-C Ctrl-A]     	${txtrst}amend the last commit.

${txtcyn}[P]     	${txtrst}push all local commits.
${txtcyn}[F]     	${txtrst}pull.
${txtcyn}[$]     	${txtrst}view activity window.

${txtcyn}[z]     	${txtrst}create a stash (make sure to give a good descriptive name)
${txtcyn}[a]    		${txtrst}apply and keep the stash
${txtcyn}[A]  		${txtrst}apply and remove the stash.
${txtcyn}[k]  		${txtrst}discard a stash.

${txtcyn}[l]            ${txtrst}bring up log view
${txtcyn}[Spacebar]     ${txtrst}bring up the details of the log, again to page down the details
${txtcyn}[Del/BckSpc]   ${txtrst}page up the details
${txtcyn}[Ctrl-W]       ${txtrst}copy the sha of the commit
${txtcyn}[.]            ${txtrst}mark/unmark a commit
${txtcyn}[=]            ${txtrst}show differences between the marked commit and the current commit.

${txtcyn}[b]     	${txtrst}switch to a branch
${txtcyn}[B] 		${txtrst}create and switch to a branch
${txtcyn}[m M]		${txtrst}merge branches

${txtpur}----------------------------------------------------------------------
"






##======================================
#####NOKIA FUNCTIONS####################
##======================================
function prod() {
   /usr/bin/ssh spaul@$1.pr.int.ent.nokia.com
}

function dev() {
   /usr/bin/ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no shpaul@$1.brislabs.com
}

pullall() {
CURRENTDIR="`pwd`"
for dir in $(find ~/workspace/ -maxdepth 1 -type d);
do
  echo "$dir";
  command cd "$dir";
  git pull;
  if [ $? != 0 ]; then
  	echo -e "${RED}Git Pull Failed for  $dir ${txtrst}";
  fi
done
command cd "$CURRENTDIR"
}
