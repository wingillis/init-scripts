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
export neurobioServer="${orchestraServer}:/files/Neurobio/DattaLab/win/"
export groupsFolder="${orchestraServer}:/groups/datta/win/"
export groupsDatta="${orchestraServer}:/groups/datta/"
export groupsJeff="${orchestraServer}:/groups/datta/Jeff/"
alias mountneurobio="sshfs ${neurobioServer} neuro/"
alias mountgroup="sshfs ${groupsFolder} neuro/"
alias mountjeff="sshfs ${groupsJeff} neuro/"
alias fumount="umount -f"

function cl {
  cd $1
  echo $(pwd)
  ls -la .
}

# make bash use vi keybindings
set -o vi

echo "Welcome Winthrop"
echo "Vi keybindings now loaded!"
