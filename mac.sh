export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

user="wg41"

if ! [ -z $ECOMMONS_ID ]; then
	user=$ECOMMONS_ID
fi

# added by Anaconda3 2.3.0 installer
if [[ -d ~/pyrun && $(uname) = "Darwin" ]]
then
  export PATH="$PATH:~/pyrun:~/pyimport:~/Documents/MATLAB/birds/py"
  export pybirds="/Users/wgillis/Documents/MATLAB/birds/py"
  alias matlab="/Applications/MATLAB_R201[67][ab].app/bin/matlab"
fi

export work="wgillis@cumm024-0b02-dhcp-180.bu.edu"
alias matterm="matlab -nodisplay -nodesktop -nosplash"

#orchestraServer="${user}@transfer.orchestra.med.harvard.edu"
export o2server="${user}@transfer.rc.hms.harvard.edu"
alias mountgroup2="sshfs ${o2server}:/n/groups/datta/ $HOME/groups/"
alias mounto2="sshfs ${o2server}:/home/wg41/ $HOME/neuro/"
alias fumount="umount -f"

function cl {
  cd $1
  echo $(pwd)
  ls -la .
}

alias matgraph="matlab -nodesktop -nosplash"
alias subl='open -a "Sublime Text"'
alias py3='source activate py3'

# make bash use vi keybindings
set -o vi

echo "Welcome Winthrop"
echo "Vi keybindings now loaded!"
