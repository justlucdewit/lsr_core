setopt nullglob

# This is the main startup file of LSR Core
# It loads multiple ZSH libraries that make my life easier
# and sets up multiple quality-of-life thingies

# Base library with handy QOL functions for other scripts
source "$HOME/.lsr_core/core/lsr.core.sh"

# Add's generic directories to PATH variable
source "$HOME/.lsr_core/startup/path_extensions.sh"

# Custom PS1 prompt that shows a simple path, and alias'es configured
# Project dirs to [project_name]
source "$HOME/.lsr_core/startup/custom_ps1.sh"

# Set of aliases to more quickly navigate the terminal
# and manipulate files
source "$HOME/.lsr_core/startup/aliases.sh"

# Fall back script for when a command was not found
# can call bash, python, js scripts
source "$HOME/.lsr_core/startup/script_fallback.sh"

# Functions for automating the installation and deinstallation
# of my projects
source "$HOME/.lsr_core/startup/project_automatization.sh"

clear