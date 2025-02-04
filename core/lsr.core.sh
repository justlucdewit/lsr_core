# Global variables
LSR_COLOR_RED='\033[0;31m'
LSR_COLOR_GREEN='\033[0;32m'
LSR_COLOR_YELLOW='\033[0;33m'
LSR_COLOR_BLUE='\033[0;34m'
LSR_COLOR_RESET='\033[0m'

LSR_STYLE_UNDERLINE='\e[4m'
LSR_STYLE_ITALIC='\e[3m'
LSR_STYLE_DIM='\e[2m'
LSR_STYLE_BOLD='\e[1m'
LSR_STYlE_RESET='\e[0m'

# CLI Tools
source "$HOME/bin/core/modules/cli/lsr.core.argparser.sh"
source "$HOME/bin/core/modules/cli/lsr.core.commands.sh"

# Datatyes
source "$HOME/bin/core/modules/datatypes/lsr.core.string.sh"
source "$HOME/bin/core/modules/datatypes/lsr.core.list.sh"
source "$HOME/bin/core/modules/datatypes/lsr.core.hashmap.sh"
source "$HOME/bin/core/modules/datatypes/lsr.core.object.sh"

# Input/Output utilities
source "$HOME/bin/core/modules/io/print.sh"
source "$HOME/bin/core/modules/io/prompt.sh"
source "$HOME/bin/core/modules/io/select.sh"
source "$HOME/bin/core/modules/io/loader.sh"
source "$HOME/bin/core/modules/io/multiSelect.sh"
source "$HOME/bin/core/modules/io/writer.sh"

# Configuration reading/writing
source "$HOME/bin/core/modules/config/config.sh"

# User interface
source "$HOME/bin/core/modules/ui/window.sh"
source "$HOME/bin/core/modules/ui/table.sh"

# Parsers
source "$HOME/bin/core/modules/parsers/csv.sh"
