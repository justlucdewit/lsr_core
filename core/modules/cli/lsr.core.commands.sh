declare -a sub_commands_help_keys
declare -a sub_commands_help_values

# composite_help_overwrite() {
#     CURRENT_COMPOSITE_HELP_OVERWRITE="$1"
# }

LSR_COMMAND_SET_HELP() {
    local key=${1//./_}
    local value="$2"

    sub_commands_help_keys+=("$key")
    sub_commands_help_values+=("$value")
}

LSR_COMMAND_PRINT_HELP() {
    local cmd="$1"

    printf "${LSR_STYLE_UNDERLINE}Usage:${LSR_STYlE_RESET}\n $CURRENT_COMPOSITE_COMMAND [COMMAND] [ARGUMENTS] \n\n"
    printf "${LSR_STYLE_UNDERLINE}Commands:${LSR_STYlE_RESET}\n"

    local i=1

    for subcommand in "${sub_commands_help_keys[@]}"; do

        # help_message="$subcommand"
        local sbcmd=${sub_commands_help_keys[i]//./_}
        local help_message="${sub_commands_help_values[i]}"

        # echo "'$help_message' from $sub_commands_help_values"

        # Split by the first dot
        local parts=("${(s/_/)subcommand}")
        local main_cmd="${parts[1]}"
        local sub_cmd="${parts[2]}" # Everything after the first dot

        # echo " - $main_cmd vs $cmd"

        if [[ "$main_cmd" == "$cmd" ]]; then
            echo "$cmd $sub_cmd - $help_message"
        fi

        i=$((i + 1))
    done
}

LSR_COMMAND() {
    local cmd="$1"
    shift

    # If no arguments were given, print help message
    if [[ -z "$1" ]]; then
        LSR_COMMAND_PRINT_HELP "$cmd"
        return
    fi

    local subcmd=${1//-/_}
    if typeset -f "${cmd}_${subcmd}" > /dev/null; then
        # Execute the cmd_subcommand function
        "${cmd}_${subcmd}" "${@:2}"
    else
        print_error "$cmd does not have a subcommand named '$subcmd'. ${cmd} usage: \n"
        LSR_COMMAND_PRINT_HELP "$cmd"
    fi
}

# LSR_SET_SUBCOMMAND() {
#     local subcommand="$1"
#     local arguments="$2"

#     CURRENT_COMPOSITE_SUBCOMMANDS+=("$subcommand")
#     CURRENT_COMPOSITE_SUBCOMMAND_ARGUMENTS["$subcommand"]="$arguments"
# }

# LSR_DESCRIBE_SUBCOMMAND() {
#     local subcommand="$1"
#     local description="$2"

#     CURRENT_COMPOSITE_SUBCOMMAND_DESCRIPTIONS["$subcommand"]="$description"
# }

# composite_define_subcommand_parameter() {
#     local subcommand="$1"
#     local parameter="$2"
#     local description="$3"

#     CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER["$subcommand/$parameter"]="$parameter"
#     CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER_DESCRIPTION["$subcommand/$parameter"]="$description"
# }

# composite_print_help_message() {
#     # Help overwrite
#     if [[ -n "$CURRENT_COMPOSITE_HELP_OVERWRITE" ]]; then
#         eval "${CURRENT_COMPOSITE_COMMAND}_$CURRENT_COMPOSITE_HELP_OVERWRITE $@"
#         return
#     fi



#     # Start with 4 due to 'help' command
#     local longest_command_length=4
#     for subcommand in "${CURRENT_COMPOSITE_SUBCOMMANDS[@]}"; do

#         local argument_description=${CURRENT_COMPOSITE_SUBCOMMAND_ARGUMENTS["$subcommand"]}
#         if [[ -n "$argument_description" ]]; then
#             argument_description=" $argument_description"
#         fi

#         local text="$subcommand$argument_description "
#         local subcommand_length=${#text}
#         if [[ "$subcommand_length" -gt "$longest_command_length" ]]; then
#             longest_command_length=$subcommand_length
#         fi
#     done

#     # Print all subcommands with their description
#     echo -n "  help"
#     echo "$(str_repeat " " "$((longest_command_length - 4))") Show this help message"
#     for subcommand in "${CURRENT_COMPOSITE_SUBCOMMANDS[@]}"; do
#         local argument_description=${CURRENT_COMPOSITE_SUBCOMMAND_ARGUMENTS["$subcommand"]}
#         if [[ -n "$argument_description" ]]; then
#             argument_description=" $argument_description"
#         fi
        
#         echo -n "  $subcommand$argument_description " #  ${CURRENT_COMPOSITE_SUBCOMMAND_ARGUMENTS[$subcommand]}

#         if [[ -n "${CURRENT_COMPOSITE_SUBCOMMAND_DESCRIPTIONS[$subcommand]}" ]]; then
#             local text="$subcommand$argument_description "
#             local current_command_command_length=${#text}
#             echo -n "$(str_repeat " " "$((longest_command_length - current_command_command_length))")"
#             echo -n " ${CURRENT_COMPOSITE_SUBCOMMAND_DESCRIPTIONS[$subcommand]}"
#         fi

#         echo

#         local longest_parameter_length=1
#         for key in "${!CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER[@]}"; do
#             local value="${CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER[$key]}"
#             if [[ "$key" == "$subcommand/"* && "${#value}" -gt "$longest_parameter_length" ]]; then
#                 longest_parameter_length="${#value}"
#             fi
#         done

#         for key in "${!CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER[@]}"; do
#             if [[ "$key" == "$subcommand/"* ]]; then
#                 local value="${CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER[$key]}"
#                 local value_length="${#value}"

#                 local description="${CURRENT_COMPOSITE_SUBCOMMAND_PARAMETER_DESCRIPTION[$subcommand/$value]}"
#                 echo "    $value$(str_repeat " " "$((longest_parameter_length - value_length))") $description"
#             fi
#         done
#     done
# }

# LSR_HANDLE_COMMAND() {
#     local subcommand="$1"
#     shift

#     # Help sub command
#     if [[ "$subcommand" == "" || "$subcommand" == "help" ]]; then
#         composite_print_help_message
#         return 0
#     fi

#     for attempted_subcommand in "${CURRENT_COMPOSITE_SUBCOMMANDS[@]}"; do
#         if [[ "$attempted_subcommand" == "$subcommand" ]]; then
#             eval "${CURRENT_COMPOSITE_COMMAND}_$subcommand \"$@\""
#             return 0
#         fi
#     done

#     echo "Error: Command '$CURRENT_COMPOSITE_COMMAND $subcommand' does not exist"
#     echo "Error: Try '$CURRENT_COMPOSITE_COMMAND help' instead"
#     return 1
# }