# Custom PS1
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

function load_projects() {
    local json_file="$1"

    jq -r '.[] | "\(.dir) \(.code)"' "$json_file"
}

PROJECTS_DIR="$HOME/projects"
PROJECTS_JSON="$HOME/projects/projects.json"
function transform_path() {
    local cwd="$PWD"
    local rel_path="${cwd#$PROJECTS_DIR/}"

    # Load projects and iterate
    while read -r dir code; do
        if [[ "$rel_path" == $dir* ]]; then

        local git_part=""

        if [[ -d "$HOME/projects/$dir/.git" ]]; then
            local curr_branch="$(git branch --show-current)"
            if [[ "$curr_branch" == "development" ]]; then 
                curr_branch="dev"
            fi

            if [[ "$curr_branch" == "master" ]]; then 
                curr_branch="main"
            fi

            git_part="@$curr_branch"
        fi


        # Remove matched project dir and prepend [code]
        local subpath="${rel_path#$dir}"
        [[ -n "$subpath" ]] && subpath="$subpath"
        echo "%F{yellow}[$code$RED$git_part$YELLOW]%F{green}$subpath%F"

        return 0
    fi
    done <<< "$(load_projects "$PROJECTS_JSON")"

    # If no match
    echo "%F{green}$rel_path%F"
}

set_powerline_ps1() {
    PS1=''

    local path_value="$(transform_path)"
    PS1="${path_value}%F{white} > "
}

do_before_prompt() {
    set_powerline_ps1
}

# prmptcmd() { eval "$PROMPT_COMMAND" }
# precmd_functions=(prmptcmd)


precmd() {
    eval "$PROMPT_COMMAND"
}

set_powerline_ps1
PROMPT_COMMAND=do_before_prompt