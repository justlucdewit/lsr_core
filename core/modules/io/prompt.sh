read_info() {
    echo -ne "\e[34m[info] $1\e[0m"
    read -r user_input
    printf -v "$2" "%s" "$user_input"
}

read_normal() {
    echo -n "$1"
    read -r user_input
    printf -v "$2" "%s" "$user_input"
}

read_error() {
    echo -ne "\e[31m[error] $1\e[0m"
    read -r user_input
    printf -v "$2" "%s" "$user_input"
}

read_debug() {
    echo -ne "\e[33m[debug] $1\e[0m"
    read -r user_input
    printf -v "$2" "%s" "$user_input"
}

read_success() {
    echo -ne "\e[32m[success] $1\e[0m"
    read -r user_input
    printf -v "$2" "%s" "$user_input"
}
