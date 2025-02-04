# Make sure we are in tmux
if [[ -z "$TMUX" ]]; then
    tmux new-session /usr/bin/bash
fi

# Allow HOME/bin
export PATH=$PATH:$HOME/bin

source "$HOME/bin/startup/custom_ps1.sh"
source "$HOME/bin/startup/aliases.sh"