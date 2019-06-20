# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ -f /etc/zshrc ]; then
  . /etc/zshrc
fi

if [ -f /home/wg41/code/init-scripts/mac.sh ]; then
  . /home/wg41/code/init-scripts/mac.sh
fi

# Path to your oh-my-zsh installation.
export ZSH=/home/wg41/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cloud"

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
# plugins=(git vi-mode zsh-autosuggestions)
plugins=(git vi-mode history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export neurobio='/files/Neurobio/DattaLab/win'
export code='/home/wg41/code'
export inscopix='/n/groups/datta/win/inscopix'
export PATH="$PATH:/home/wg41/code/bash"
export PATH="/home/wg41/code/bash/bin:$PATH"
export PATH="$PATH:/home/wg41/code/"
export PATH="$PATH:/home/wg41/code/batch-jobs"
export PATH="/home/wg41/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/lib:$HOME/code/bash/lib"

module load matlab/2017b
module load git/2.9.5

alias tmux="TERM=screen-256color tmux"
alias matterm="matlab -nodesktop -nodisplay -nosplash"
alias ta='tmux a -t win'
alias tn='tmux new -s win'
export neurobio='/files/Neurobio/DattaLab/win'
export code='/home/wg41/code'
export inscopix='/n/groups/datta/win/inscopix'
alias wq="squeue -u wg41"
alias wql="wq -o \"%.18i %.18j %.2t %.10M\""

export jworkspace="/n/groups/datta/Jeff/workspace/"
export grin="/n/groups/datta/win/1pimaging_dls_moseq2"
export PATH="$PATH:/home/wg41/code/kinect-extraction/bash/"

export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=$HOME/bin/go/go
export PATH="$PATH:$GOROOT/bin"

export MATLABPATH="$HOME/code/matlab"
export PATH="$PATH:$HOME/miniconda2/bin"

export JUPYTER_RUNTIME_DIR="~/.jupyter-runtime"
export JUPYTER_CONFIG_DIR="~/.jupyter_config"

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
export KEYTIMEOUT=5
alias mo2="source activate mo2"
alias py3="source activate py3"
alias fairshare="sshare -u $USER -U"

ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=cyan,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/wg41/bin/google-cloud-sdk/path.zsh.inc' ]; then source '/home/wg41/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/wg41/bin/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/wg41/bin/google-cloud-sdk/completion.zsh.inc'; fi

export NXF_WORK='/n/scratch2/wg41/nextflow'
export NXF_HOME='$HOME/.nextflow'

export MKL_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wg41/miniconda2/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wg41/miniconda2/etc/profile.d/conda.sh" ]; then
        . "/home/wg41/miniconda2/etc/profile.d/conda.sh"
    else
        export PATH="/home/wg41/miniconda2/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

