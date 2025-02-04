#! /bin/bash
# Execute this file on any remote using the following command:
# source <(curl -s "https://raw.githubusercontent.com/justlucdewit/lsr_core/master/special/_remote_init.sh")

function get_file_from_git() {
    local file="$1"
    curl -s "https://raw.githubusercontent.com/justlucdewit/lsr_core/master/$file"
    echo
}

bash --rcfile <( 
    {
        get_file_from_git "startup/path_extensions.sh"
        get_file_from_git "startup/custom_ps1.sh"
        get_file_from_git "startup/aliases.sh"
        get_file_from_git "startup/script_fallback.sh"
    }
)
