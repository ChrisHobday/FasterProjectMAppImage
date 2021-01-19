#!/bin/sh -e
# AddGCAdapterRules.sh

# --- Add Gamecube adapter rules
sudo rm -f /etc/udev/rules.d/51-gcadapter.rules # Remove even if doesn't exist
echo '#GameCube Controller Adapter
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", TAG+="uaccess"

			#Mayflash DolphinBar
			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null # pipe to write-protected file, remove STDOUT
sudo udevadm control --reload-rules
echo "Gamecube adapter rules added!"
# ---