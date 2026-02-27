print_info() {
    printf "\e[34m[info] $1\e[0m"  # \e[34m is the color code for blue
    echo
}

print_warn() {
    printf "\e[33m[warn] $1\e[0m"  # \e[34m is the color code for blue
    echo
}

print_normal() {
    echo "$1"
}

print_empty_line() {
    echo ""
}

print_error() {
    printf "\e[31m[error] $1\e[0m"  # \e[31m is the color code for red
    echo
}

print_debug() {
    printf "\e[33m[debug] $1\e[0m"  # \e[33m is the color code for yellow
    echo
}

print_success() {
    printf "\e[32m[success] $1\e[0m"  # \e[32m is the color code for green
    echo
}
