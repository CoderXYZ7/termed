# ============================================================
#  ~/.zshrc — Custom Kali i3 Gruvbox + Oh My Zsh
# ============================================================

# ── Oh My Zsh core ──────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Theme: Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Instant prompt (loads cache before plugins for speed)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Plugins ─────────────────────────────────────────────────
# Built-in OMZ plugins + community plugins installed by hook
plugins=(
    # --- Built-in OMZ plugins ---
    git                         # git aliases (ga, gcm, gst, gp, etc.)
    sudo                        # press ESC twice to prepend sudo
    command-not-found            # suggest package to install
    colored-man-pages            # syntax-highlighted man pages
    extract                     # `extract archive.tar.gz` — works for any format
    aliases                     # `als` to list all aliases
    docker                      # docker autocompletion
    docker-compose              # docker-compose autocompletion
    python                      # python aliases (pyfind, pyserver, etc.)
    pip                         # pip autocompletion and aliases
    nmap                        # nmap aliases for pentesting
    web-search                  # `google`, `github`, `stackoverflow` from terminal
    copypath                    # `copypath` copies current dir to clipboard
    copyfile                    # `copyfile <file>` copies file contents to clipboard
    dirhistory                  # Alt+Left/Right to navigate dir history
    jsontools                   # `pp_json`, `is_json`, `urlencode_json`

    # --- Community plugins (cloned by hook) ---
    zsh-autosuggestions          # fish-like inline suggestions
    zsh-syntax-highlighting      # real-time command coloring
    zsh-completions              # extra completion definitions
    zsh-history-substring-search # Up/Down searches partial commands
    fast-syntax-highlighting     # faster highlighting engine
    you-should-use               # reminds you of your aliases
    fzf-tab                     # fzf-powered tab completion
)

# Load completions from zsh-completions before compinit
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# ── Environment ─────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="zen-browser"
export LANG="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# ── Aliases ─────────────────────────────────────────────────
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias v='nvim'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'
alias ports='ss -tulanp'
alias myip='curl -s ifconfig.me'
alias update='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y && sudo apt autoclean'

# ── Plugin Config ───────────────────────────────────────────

# zsh-autosuggestions: use Gruvbox gray for ghost text
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#665c54"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# history-substring-search: bind Up/Down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# you-should-use: Gruvbox yellow for reminders
export YSU_MESSAGE_FORMAT="$(tput setaf 3)Found alias: %alias_type \"%alias\" for \"%command\"$(tput sgr0)"
export YSU_HARDCORE=0

# fzf: Gruvbox colors
export FZF_DEFAULT_OPTS="
  --color=bg+:#3c3836,bg:#282828,spinner:#fb4934,hl:#928374
  --color=fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934
  --color=marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
  --border --padding=1
"

# ── History ─────────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups

# ── Gruvbox dircolors ──────────────────────────────────────
if [ -f "$HOME/.dir_colors" ]; then
    eval "$(dircolors -b "$HOME/.dir_colors")"
fi

# ── Powerlevel10k config ───────────────────────────────────
# Run `p10k configure` to customize, or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
