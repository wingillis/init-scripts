
# when I'm home (based on wifi), change energy saving parameters

wifiName=$(airport -I | egrep " +SSID" | awk '{print $2}')

if [[ $wifiName == "DeepMansion" || $wifiName == "DeepMansion_5" ]]; then
	pmset -a displaysleep 10
	pmset -b sleep 15
else
	pmset -a displaysleep 4
	pmset -b sleep 7
fi
