
# -- SOURCES -------------------------------------------------------------------
# Plugins
  source ~/.oh-my-zsh/plugins/archlinux/archlinux.plugin.zsh
  source ~/.oh-my-zsh/plugins/nmap/nmap.plugin.zsh
  source ~/.oh-my-zsh/plugins/extract/extract.plugin.zsh
# Custom
  source ~/.oh-my-zsh/custom/aliases.zsh
  source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ~/.oh-my-zsh/custom/youtube.zsh
# --  General ------------------------------------------------------------------
  ZSH_THEME="agnoster"
# Enable Vim mode on Commmand line
  bindkey -v
# Edit Commands with Vim Editor for usage hit Esc+v
  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd v edit-command-line
# Enable Backspace and Delete in command line
  bindkey    "^[[3~"          delete-char
  bindkey    "^[3;5~"         delete-char

  autoload -U zmv
  setopt extendedglob
  unsetopt caseglob

# History
  setopt APPEND_HISTORY
  setopt EXTENDED_HISTORY
  setopt HIST_FIND_NO_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_NO_STORE
  setopt HIST_REDUCE_BLANKS
  setopt HIST_SAVE_NO_DUPS
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_FIND_NO_DUPS
  setopt HIST_VERIFY
  setopt SHARE_HISTORY
  setopt INTERACTIVE_COMMENTS        # pound sign in interactive prompt
  HISTFILE=~/.zsh_history            # where to save zsh history
  HISTSIZE=10000
  SAVEHIST=10000

  # make sure that if a program wants you to edit
  # text, that Vim is going to be there for you
    export EDITOR="nvim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
    export GREP_COLORS='0;35'

  # aliases for Tmux
    alias tmux='tmux -2'
    alias ta='tmux attach -t'
    alias tnew='tmux new -s'
    alias tls='tmux ls'
    alias tkill='tmux kill-server'

  # convenience aliases for editing configs
    alias ev='vim ~/.vimrc'
    alias et='vim ~/.tmux.conf'
    alias ez='vim ~/.zshrc'

    export TERM="xterm-256color"
    export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# EXTRA
# want your terminal to support 256 color schemes? I do ...


# if you do a 'rm *', Zsh will give you a sanity check!
  setopt RM_STAR_WAIT

# allows you to type Bash style comments on your command line
# good 'ol Bash
  setopt interactivecomments

# Zsh has a spelling corrector
  setopt CORRECT



#NEW CONFIGURATION


# I like color. Easier to read
  autoload colors && colors

# I know VI more than Emacs
  set -o vi # I apparently needed some emacs bindings :-P

  # Don't clobber files
  set -o noclobber

# -- Tmux ----------------------------------------------------------------------
#Auto Start Tmux Session
  if [[ -z "$TMUX" ]] ;then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
fi

#Multiple Screen Sessions in Tmux
  if [ -z "$TMUX" ] && [ -z "$DISPLAY" ] && [ -z "$TERM_PROGRAM" ]; then
    base_session="${USER}_session"
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session

    client_cnt=$(tmux list-clients | wc -l)
    # Are there any clients connected already?
    if [ $client_cnt -ge 1 ]; then
        client_id=0
        session_name=$base_session"-"$client_id
        while [ $(tmux has-session -t $session_name 2>& /dev/null; echo $?) -ne 1 ]; do
            client_id=$((client_id+1))
            session_name=$base_session"-"$client_id
        done
        tmux new-session -d -t $base_session -s $session_name
        tmux -2 attach-session -t $session_name \; set-option destroy-unattached
    else
        tmux -2 attach-session -t $base_session
    fi
fi
