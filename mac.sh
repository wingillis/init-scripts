export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# added by Anaconda3 2.3.0 installer
if [[ -d ~/pyrun && $(uname) = "Darwin" ]]
then
  export PATH="$PATH:~/pyrun:~/pyimport:~/Documents/MATLAB/birds/py"
  export pybirds="/Users/wgillis/Documents/MATLAB/birds/py"
  alias matlab="/Applications/MATLAB_R201[67][ab].app/bin/matlab"
fi

export work="wgillis@cumm024-0b02-dhcp-180.bu.edu"
alias matterm="matlab -nodesktop -nosplash"

orchestraServer="wg41@transfer.orchestra.med.harvard.edu"
o2server="wg41@transfer.rc.hms.harvard.edu"
export neurobioServer="${orchestraServer}:/files/Neurobio/DattaLab/win/"
export groupsFolder="${orchestraServer}:/groups/datta/win/"
export groups2="${o2server}:/n/groups/datta/"
export groupsDatta="${orchestraServer}:/groups/datta/"
export groupsJeff="${orchestraServer}:/groups/datta/Jeff/"
alias mountneurobio="sshfs ${neurobioServer} neuro/"
alias mountgroup="sshfs ${groupsFolder} neuro/"
alias mountgroup2="sshfs ${groups2} neuro/"
alias mountjeff="sshfs ${groupsJeff} neuro/"
alias mounto2="sshfs $o2server:/home/wg41/ neuro/"
alias fumount="umount -f"

function cl {
  cd $1
  echo $(pwd)
  ls -la .
}

alias matgraph="matlab -nodesktop -nosplash"
alias subl='open -a "Sublime Text"'

# make bash use vi keybindings
set -o vi

echo "Welcome Winthrop"
echo "Vi keybindings now loaded!"
