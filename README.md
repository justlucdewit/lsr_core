# LSR Core
Brings the core functionality for lukes script repository into your terminal. This can be done by cloning the repository
and having a permanent initialization in your bashrc, or by manually initializing it remotely

# Permanent installation
You can permanently install LSR core by running the following code in your terminal:
```bash
git clone "https://github.com/justlucdewit/lsr_core" "$HOME/.lsr_core/"
echo 'source "$HOME/.lsr_core/_startup.sh"' >> ~/.bashrc
source "$HOME/.lsr_core/_startup.sh"
```

# Temporary init
You can also temporarily import LSR core (for example for when you want to use it non-destructively on an SHH remote),
by running the following code:

```bash
source <(curl -s "https://raw.githubusercontent.com/justlucdewit/lsr_core/master/special/_remote_init.sh")
```
