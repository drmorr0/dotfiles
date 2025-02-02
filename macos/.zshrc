export VISUAL=vim
export EDITOR=vim
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_PUSHD
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt PROMPT_SUBST
setopt CDABLE_VARS
unsetopt NOMATCH
unsetopt PUSHD_SILENT
unsetopt CHECK_JOBS
unsetopt AUTO_CD

# Not sure if these are correct for all distros... to find out the right settings
# for bindkey, run cat and press home/end/etc., then paste those values here.

#[[ "$terminfo[kcuu1]" == "O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
#[[ "$terminfo[kcud1]" == "O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end
bindkey "^[[H" vi-beginning-of-line   # Home
bindkey "^[[F" vi-end-of-line         # End
bindkey '^[[2~' vi-insert              # Insert
bindkey '^[[3~' delete-char            # Del
bindkey '^[[5~' vi-backward-blank-word # Page Up
bindkey '^[[6~' vi-forward-blank-word  # Page Down
bindkey '^[OM' accept-line			   # Shift-Enter

autoload -Uz vcs_info

fpath=(~/.local/share/zsh/site-functions/ $fpath)
autoload -U compinit
compinit

zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Common hostnames
zstyle ':completion:*' users-hosts drmorr@evokewonder.com

# Git stuff; this slows the prompt down a bit
zstyle ':vcs_info:*' actionformats '<%r/%0.24%b...|%a>'
zstyle ':vcs_info:*' formats '(%r/%0.24b...)'
zstyle ':vcs_info:*' enable git

vcs_info_wrapper()
{
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo "${vcs_info_msg_0_}"
	fi
}

# Prompt
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_PREFIX=
export KUBE_PS1_SUFFIX=" "
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CTX_COLOR=green
export PS1=$'%(6~.\n[%96<...<%~%<<]\n$(kube_ps1)%(0?.%{\e[1;34m%}.%{\e[1;31m%})%n@%m%(0?.%{\e[1;00m%}.) %(0?.%(!.#.>).X) .$(kube_ps1)%(0?.%{\e[1;34m%}.%{\e[1;31m%})%n@%m%(0?.%{\e[1;00m%}.) %~ %(0?.%(!.#.>).X) )%{\e[1;00m%}'
export RPS1='$(vcs_info_wrapper) %T'

# This is insanity
export EXA_COLORS="\
da=34:\
di=36:\
ln=38;5;40:\
or=31:\
sb=38;5;28:\
sn=33:\
un=38;5;202;1:\
bl=38;5;220:\
ur=38;5;249:\
uw=38;5;249:\
ux=38;5;249:\
ue=38;5;249:\
gr=38;5;249:\
gw=38;5;249:\
gx=38;5;249:\
tr=38;5;249:\
tw=31:\
tx=31:\
su=37:\
sf=37:\
xa=37"

# Aliases
alias ls='eza --icons=always'
alias ll='ls -lg --time-style=long-iso'
alias la='ls -lga --time-style=long-iso'
alias lsg='ls --git-ignore'
alias vi='vim'
alias vs='vim -c "Scratch"'
alias vz='vim $(fzf --tmux)'
alias :q='exit'
alias :wq='exit'
alias grep='rg -S'
alias less='less -r'
alias jq='jq -C'
alias g='git'
alias gg='git grep'
alias py='python3'
alias kc='kubectl'
alias kcg='kubectl get'
alias -g kcgp='kubectl grep pods'  # use -g to pass aliases through to watch
alias -g kcgn='kubectl get nodes'
alias kcd='kubectl describe'
alias kcdp='kubectl describe pod'
alias kcdn='kubectl describe node'
alias kcrm='kubectl delete'
alias kcapp='kubectl apply -f'
alias kcl='kubectl logs'
alias kcex='kubectl exec -it'
alias kcpf='kubectl port-forward'
alias kctx='kubectx'
alias kns='kubens'
alias kon='kubeon'
alias koff='kubeoff'
alias sudo='sudo '  # aliasing sudo to 'sudo ' passes aliases through sudo, e.g., sudo kcgp now works

if [ -f ~/.zshextra ]; then source ~/.zshextra; fi

function goinside() {
    docker exec -it --user=0 $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}

export PATH=~/bin:~/.atuin/bin:~/.cargo/bin:~/.local/bin:~/.krew/bin:/opt/homebrew/bin:$PATH
export FZF_DEFAULT_OPTS="--walker-skip=.git,node_modules,.cargo,.local,.build"

eval "$(atuin init zsh --disable-up-arrow)"
