
export EDITOR=code

# Basic navigation/file manipulation utils
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd $HOME"
alias a="" # TODO find alias function for this
alias b="echo -e \"\\07\""
alias c=clear
alias d="du -sh *"
e() {
  bun "$HOME/projects/private/tui/sniff" "$@"
  local d
  d="$(cat "$HOME/.sniff-last-dir" 2>/dev/null)"
  [ -n "$d" ] && [ -d "$d" ] && cd "$d"
}
alias f='find . -name'
alias g='git status'
alias h="echo \"$PWD\""
alias i="" # TODO find alias function for this
alias j="" # TODO find alias function for this
alias k="" # TODO find alias function for this
alias l="ls -la"
alias m="" # TODO find alias function for this
alias n=touch
alias o="open-location"
alias p="project go"
alias q=exit
alias r="source \"$HOME/.zshrc\""
alias s="scripts"
alias t="tree -L 2"
alias u="" # TODO find alias function for this
alias v='vim'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
# alias w="" # Already exists
alias x="" # TODO find alias function for this
# alias y="" # TODO find alias function for this
alias z="" # TODO find alias function for this
alias ccat="$HOME/scripts/better_cat/better-cat.sh"
alias analyze="/opt/homebrew/bin/Python3.10 $HOME/projects/project_analyzer/analyzer.py"
alias t=set_tab_title
alias python="python3.10"
alias edit="fresh ."
alias editor="fresh ."
alias ftp="termscp"

alias notes="emacs $HOME/notes/notes"
alias todo="emacs $HOME/notes/todo"
alias dreams="emacs $HOME/notes/dreams"
alias work="emacs $HOME/notes/work"

alias proxy="node $HOME/projects/reverse-proxy/index.js"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

function yazi_explore() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Git aliases
alias lg=lazygit
alias ga='git add'
alias gb='git branch --all'
alias gc='git commit -m'
alias gf='git fetch --all'
alias gl='git log -sb'
alias gco='git checkout'
alias gp='git push'
# alias gg="log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(yellow)%d%C(reset)' --all"

# Tmux aliases
alias shor="tmux split-pane -h"
alias sver="tmux split-pane -v"

# Other aliases
alias db="python3.10 $HOME/projects/private/easydb/index.py"


function set_tab_title() {
    echo -en "\033]1; $@ \007"
}

function copy() {
    echo "$1" | pbcopy
}

alias sail="./vendor/bin/sail"
function open-location() {
    if [[ -z "$1" ]]; then
        open "$1"
    else
        open .
    fi
}

function project() {
    source "$HOME/scripts/project/project.sh"
    LSR_COMMAND "project" "$@"
}

function torn() {
    bash "$HOME/scripts/torn/torn.sh" "$@"
}

function branch-watch() {
    bash "$HOME/scripts/branch-watch/branch-watch.sh" "$@"
}

# Function to intelligently execute Laravel Artisan commands
# It checks for the existence of the Sail executable (vendor/bin/sail)
# and uses 'sail artisan' if found, otherwise it uses 'php artisan'.
art() {
    # Check if the Laravel Sail script exists relative to the current working directory
    if [ -f vendor/bin/sail ]; then
        # If sail exists, execute the command using sail
        vendor/bin/sail artisan "$@"
    else
        # If sail does not exist, execute the command directly with php
        php artisan "$@"
    fi
}