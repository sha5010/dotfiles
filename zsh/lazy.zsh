# ----------------------------
# utilities
# ----------------------------
_has() { return $( whence $1 &>/dev/null ) }

# ----------------------------
# load plugins
# ----------------------------
source "$ZDOTDIR/plugins.zsh"

# ----------------------------
# aliases
# ----------------------------
mkcd() { command mkdir -p -- "$@" && builtin cd "${@[-1]:a}" }
if _has bat; then
  diff() {
    command diff "$@" | bat --paging=never --plain --language=diff
    return "${pipestatus[1]}"
  }
fi

# ----------------------------
# etc
# ----------------------------
export EDITOR="vi"
(( ${+commands[vim]} )) && EDITOR="vim"
(( ${+commands[nvim]} )) && EDITOR="nvim"

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

# ----------------------------
# autoloads
# ----------------------------
zinit wait'2z' lucid null for \
  atinit'autoload -Uz _zinit; zicompinit' zdharma-continuum/null

# ----------------------------
# Load custom lazy config
# ----------------------------
[ -f "${ZDOTDIR}/customlazy.zsh" ] && source "${ZDOTDIR}/customlazy.zsh"
