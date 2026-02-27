# This bash file makes sure that if a command is not found, bash can fallback on some script that it can find in certain directories
command_not_found_handler() {
    cmd="$1"

    # When command is not found, fallback on scripts
    # If the script name starts with an underscore, it is hidden and thus not listed nor callable
    # Location Priority:
    #   - In current directory
    #   - In ./_lsr_scripts folder
    #   - In ./scripts/ folder
    # Language Priority:
    #   - .sh scripts
    #   - .py scripts
    #   - .js scripts
    #   - npm scripts
    
    # Run the bash script if it exists
    if [[ $cmd != _* ]]; then
        if [[ -f "./$cmd.sh" ]]; then # Run the script
            print_info "Running script $cmd.sh"
            bash "./$cmd.sh" "${@:2}"
            return

        # Run the /_lsr_scripts/ bash script if it exists
        elif [[ -d "./_lsr_scripts" && -f "./_lsr_scripts/$cmd.sh" ]]; then
            print_info "Running script $cmd.sh"
            bash "./_lsr_scripts/$cmd.sh" "${@:2}"
            return

        # Run the /scripts/ bash script if it exists
        elif [[ -d "./scripts" && -f "./scripts/$cmd.sh" ]]; then
            print_info "Running script $cmd.sh"
            bash "./scripts/$cmd.sh" "${@:2}"
            return

        # Run the python script if it exists
        elif [[ -f "./$cmd.py" ]]; then
            print_info "Running script $cmd.py"
            python3 "./$cmd.py" "${@:2}"
            return

        # Run the /_lsr_scripts/ python script if it exists
        elif [[ -d "./_lsr_scripts" && -f "./_lsr_scripts/$cmd.py" ]]; then
            print_info "Running script $cmd.py"
            python3 "./_lsr_scripts/$cmd.py" "${@:2}"
            return

        # Run the /scripts/ python script if it exists
        elif [[ -d "./scripts" && -f "./scripts/$cmd.py" ]]; then
            print_info "Running script $cmd.py"
            python3 "./scripts/$cmd.py" "${@:2}"
            return

        # Run the js script if it exists
        elif [[ -f "./$cmd.js" ]]; then
            print_info "Node script $cmd.js"
            node "./$cmd.js" "${@:2}"
            return

        # Run the /_lsr_scripts/ js script if it exists
        elif [[ -d "./_lsr_scripts" && -f "./_lsr_scripts/$cmd.js" ]]; then
            print_info "Node script $cmd.js"
            node "./_lsr_scripts/$cmd.js" "${@:2}"
            return

        # Run the /scripts/ js script if it exists
        elif [[ -d "./scripts" && -f "./scripts/$cmd.js" ]]; then
            print_info "Node script $cmd.js"
            node "./scripts/$cmd.js" "${@:2}"
            return

        # Run the script from the npm folder if it exists
        elif [[ -f "./package.json" && "$(grep \"$cmd\": package.json)" != "" ]]; then
            print_info "Running NPM script '$cmd'"
            npm run $cmd --silent
            return
        fi
    fi

    # Command was not found
    suggestions=$(compgen -c "$cmd" | head -n 5)
    if [[ -n "$suggestions" ]]; then
        echo "bash: $cmd: command not found. Did you mean one of these?"
        echo " - $suggestions" | while read -r suggestion; do echo "  $suggestion"; done
    else
        echo "bash: $cmd: command not found"
    fi

    return 127
}

# Function to list scripts that are available from current location
# Finds scripts to fall back on, in one of the following directories:
# .                 the root dir
# ./scripts/        the local unignored scripts
# ./_lsr_scripts    the local ignored scripts
#
# If the script name starts with an underscore, it is hidden and thus not listed nor callable
# - bash scripts
# - python scripts
# - nodejs scripts
function scripts() {
    local bashScriptsTxt=""
    local pyScriptsTxt=""
    local jsScriptsTxt=""
    local npmScriptsTxt=""

    for file in ./*.sh; do
        filename="${file##*/}"      # Remove the ./ prefix
        basename="${filename%.sh}"  # Remove the .sh suffix

        if [[ "$basename" != "*" && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            bashScriptsTxt+=" - $basename"
            bashScriptsTxt+=$'\n'
        fi
    done

    for file in ./scripts/*.sh; do
        filename="${file##*/}"      # Remove the ./ prefix
        basename="${filename%.sh}"  # Remove the .sh suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            bashScriptsTxt+=" - $basename"
            bashScriptsTxt+=$'\n'
        fi
    done
    for file in ./_lsr_scripts/*.sh; do
        filename="${file##*/}"      # Remove the ./ prefix
        basename="${filename%.sh}"  # Remove the .sh suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi
            
            bashScriptsTxt+=" - $basename"
            bashScriptsTxt+=$'\n'
        fi
    done
    for file in ./*.py; do
        filename="${file##*/}"      # Remove the ./scripts/ prefix
        basename="${filename%.py}"  # Remove the .py suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            pyScriptsTxt+=" - $basename"
            pyScriptsTxt+=$'\n'
        fi
    done
    for file in ./scripts/*.py; do
        filename="${file##*/}"      # Remove the ./scripts/ prefix
        basename="${filename%.py}"  # Remove the .py suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            echo "looking at $file"
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            pyScriptsTxt+=" - $basename"
            pyScriptsTxt+=$'\n'
        fi
    done
    for file in ./*.js; do
        filename="${file##*/}"      # Remove the ./scripts/ prefix
        basename="${filename%.js}"  # Remove the .js suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            jsScriptsTxt+=" - $basename"
            jsScriptsTxt+=$'\n'
        fi
    done
    for file in ./scripts/*.js; do
        filename="${file##*/}"      # Remove the ./scripts/ prefix
        basename="${filename%.js}"  # Remove the .py suffix

        if [[ "$basename" != "*"  && $basename != _* ]]; then
            if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^$file$") ]]; then
                continue
            fi

            jsScriptsTxt+=" - $basename"
            jsScriptsTxt+=$'\n'
        fi
    done

    if [[ -f "./package.json" ]]; then
        scripts=$(jq '.scripts' package.json)
        if [[ "$scripts" != "null" && "$scripts" != "{}" && -n "$scripts" ]]; then
            local npmscripts=$(jq -r ".scripts | keys[]" ./package.json)

            while IFS= read -r line; do
                if [[ -f "./_lsr_scripts/.lsrignore" && -n $(cat "./_lsr_scripts/.lsrignore" | grep "^npm@$line$") ]]; then
                    continue
                fi
                
                npmScriptsTxt+=" - $line"
                npmScriptsTxt+=$'\n'
            done <<< "$npmscripts"
        fi
    fi

    if [[ -n "$bashScriptsTxt" ]]; then
        echo "Bash scripts:"
        echo "$bashScriptsTxt"
    fi

    if [[ -n "$pyScriptsTxt" ]]; then
        echo "Python scripts:"
        echo "$pyScriptsTxt"
    fi

    if [[ -n "$jsScriptsTxt" ]]; then
        echo "Javascript scripts:"
        echo "$jsScriptsTxt"
    fi

    if [[ -n "$npmScriptsTxt" ]]; then
        echo "Npm scripts:"
        echo "$npmScriptsTxt"
    fi
}
