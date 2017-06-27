export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# added by Anaconda3 2.3.0 installer
if [ -d ~/pyrun ]
then
	export PATH="$PATH:~/pyrun:~/pyimport:~/Documents/MATLAB/birds/py"
fi

export work="wgillis@cumm024-0b02-dhcp-180.bu.edu"
export pybirds="/Users/wgillis/Documents/MATLAB/birds/py"
alias matlab="/Applications/MATLAB_R201[67][ab].app/bin/matlab"
alias matterm="matlab -nodesktop -nosplash"

echo "Welcome Winthrop"

export neurobioServer="wg41@transfer.orchestra.med.harvard.edu:/files/Neurobio/DattaLab/win/"
export groupsFolder="wg41@transfer.orchestra.med.harvard.edu:/groups/datta/win/"
export groupsDatta="wg41@transfer.orchestra.med.harvard.edu:/groups/datta/"
export groupsJeff="wg41@transfer.orchestra.med.harvard.edu:/groups/datta/Jeff/"
alias mountneurobio="sshfs ${neurobioServer} neuro/"
alias mountgroup="sshfs ${groupsFolder} neuro/"
alias mountjeff="sshfs ${groupsJeff} neuro/"
# make bash use vi keybindings
set -o vi

echo "Vi keybindings now loaded!"
