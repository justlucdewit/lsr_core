# LSR Core
Brings the core functionality for lukes script repository into your terminal. This can be done by cloning the repository
and having a permanent initialization in your bashrc, or by manually initializing it remotely

## Permanent installation
You can permanently install LSR core by running the following code in your terminal:
```bash
git clone "https://github.com/justlucdewit/lsr_core" "$HOME/.lsr_core/"
echo 'source "$HOME/.lsr_core/_startup.sh"' >> ~/.bashrc
source "$HOME/.lsr_core/_startup.sh"
```

## Core functionality
The following is a list of helpfull bash helpers to help you more easily write bash scripts
```bash
# Pretty printing

print_normal "Text printing:"
print_info "Print info text"
print_warn "Print warning text"
print_normal "Print normal text"
print_error "Print error text"
print_debug "Print debug text"
print_success "Print success text\n"
```