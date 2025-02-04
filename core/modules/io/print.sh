print_info() {
    echo -e "\e[34m[info] $1\e[0m"  # \e[34m is the color code for blue
}

print_warn() {
    echo -e "\e[33m[warn] $1\e[0m"  # \e[34m is the color code for blue
}

print_normal() {
    echo "$1"
}

print_empty_line() {
    echo ""
}

print_error() {
    echo -e "\e[31m[error] $1\e[0m"  # \e[31m is the color code for red
}

print_debug() {
    echo -e "\e[33m[debug] $1\e[0m"  # \e[33m is the color code for yellow
}

print_success() {
    echo -e "\e[32m[success] $1\e[0m"  # \e[32m is the color code for green
}
