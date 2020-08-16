# vim: set et ts=4 sw=4:
# Dependencies: exa, bat
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export PATH=$PATH:$HOME/bin
export EDITOR=nvim
bindkey -e
zmodload zsh/zprof
## Plugins
if [ ! -d "${HOME}/.zplug" ]; then
    echo "~/.zplug directory not found, installing zplug"
    git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

zplug "lib/git", from:oh-my-zsh
#zplug "plugins/command-not-found", from:oh-my-zsh
zplug "hchbaw/auto-fu.zsh"
zplug "zplug/zplug"
zplug "chrissicool/zsh-256color"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "Aloxaf/fzf-tab"
zplug "zdharma/fast-syntax-highlighting", defer:2

zplug "romkatv/powerlevel10k", as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    echo; zplug install
fi
zplug load

## Prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # os_icon               # os identifier
    context                 # user@hostname
    dir                     # current directory
    vcs                     # git status
    prompt_char             # prompt symbol
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
)
typeset -g POWERLEVEL9K_STATUS_ERROR=true
# only build completion cache once a day
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit
    touch ~/.zcompdump
else
    compinit -uC
fi
if [[ -f /etc/bash_completion.d/g4d ]]; then
    source /etc/bash_completion.d/p4
    source /etc/bash_completion.d/g4d
    source /etc/bash_completion.d/hgd
fi
zstyle ':completion:*' menu select
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'
#zstyle ':autocomplete:*' fuzzy-search off
#zstyle ':autocomplete:list-choices:*' max-lines 30%
#zstyle ':autocomplete:space:*' magic off
#zstyle ':autocomplete:tab:*' completion select
## Fuzzy completion
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'
zmodload zsh/complist
bindkey -M menuselect '^j' expand-or-complete
bindkey -M menuselect '^k' reverse-menu-complete

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_fzf_comprun() {
    local cmd=$1
    shift
    case "$cmd" in
        cd)           fzf "$@" --preview 'exa -TF --level=2 --color=always {} | head -100';;
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        ssh)          fzf "$@" --preview 'dig {}' ;;
        *)            fzf "$@" ;;
    esac
}
# --files: List files that would be searched but do not search
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
export FZF_DEFAULT_COMMAND='fd --hidden --follow'
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# give a preview of directory by exa when completing cd
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --cycle --bind=change:top
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

## Aliases
eval "$(fasd --init auto)"
[ -f ~/.aliases ] && source ~/.aliases
# Expand aliases with space
function expand-alias() {
    zle _expand_alias
    zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias
export ENHANCD_DISABLE_HOME=1
export ENHANCD_DISABLE_DOT=1
export ENHANCD_HOOK_AFTER_CD="l"
# ctrl + arrow, move by word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# ctrl + space, execute autosuggestion
bindkey '^@' autosuggest-execute

## History
export HISTFILE="$HOME/.zsh_history"
if [[ -n ~/.zsh_history ]]; then
    touch ~/.zsh_history
fi
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt extended_history       # save timestamps
setopt inc_append_history     # add executed commands immediately
setopt hist_ignore_space      # ignore commands with a space in front
setopt hist_find_no_dups      # ignore duplicates with up/down
setopt hist_ignore_dups       # ignore duplicates with ctrl R
setopt hist_expire_dups_first # delete dups first when HISTFILE size exceeds HISTSIZE
setopt hist_verify            # show history expansion before running
setopt share_history          # share history between terminals
# cd history tab completion
setopt auto_pushd                  # pushes the old directory onto the stack
setopt pushd_minus                 # exchange the meanings of '+' and '-'
setopt cdable_vars                 # expand the expression (allows 'cd -2/tmp')
# please stop autocompleting to directories that dont exist
unsetopt cdablevars
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'
# typing... + arrow, fuzzy find history
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

# fix NTFS directory colors being unreadable in ls
[ -f ~/.dircolors ] && eval $(dircolors -b ~/.dircolors)

# WSL config
if uname -r |grep -q 'Microsoft' ; then
    cd ~ # workaround for WSL bug
    export PATH=$PATH:/mnt/c/Windows/System32
fi

# Additional work-specific configs I can't put on github
[ -f ~/.work-config ] && source ~/.work-config
