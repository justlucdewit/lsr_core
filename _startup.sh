# Make sure we are in tmux
if [[ -z "$TMUX" ]]; then
    tmux new-session /usr/bin/bash
fi

source "$HOME/.lsr_core/core/lsr.core.sh"
source "$HOME/.lsr_core/startup/path_extensions.sh"
source "$HOME/.lsr_core/startup/custom_ps1.sh"
source "$HOME/.lsr_core/startup/aliases.sh"
source "$HOME/.lsr_core/startup/script_fallback.sh"
