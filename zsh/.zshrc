# ----------------------------
# Added by Zinit's installer
# ----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command chmod g-rwX "$(dirname $ZINIT_HOME)"
    command git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ----------------------------
# Basic config
# ----------------------------
ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
source "${ZDOTDIR}/init.zsh"

# ----------------------------
# Lazyload
# ----------------------------
zinit wait lucid null for \
  atinit'source "$ZDOTDIR/lazy.zsh"' zdharma-continuum/null

# ----------------------------
# Load custom config
# ----------------------------
[ -f "${ZDOTDIR}/customrc.zsh" ] && source "${ZDOTDIR}/customrc.zsh" 
