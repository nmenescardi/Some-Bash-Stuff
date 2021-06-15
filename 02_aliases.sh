#!/bin/bash
exec >> ~/.bash_aliases
exec 2> /dev/null

cat << EOF
alias dcr='docker-compose run --rm'
alias dc='docker-compose'
alias dcres='dc ps && dc down && dc ps && dc up -d && dc ps && dc logs -f'
alias lsa='ls -alh'
alias ll='lsa'
alias cb='xclip -sel clip'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias cls='clear'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias h='history'
alias j='jobs -l'
alias ports='netstat -tulanp'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
EOF
