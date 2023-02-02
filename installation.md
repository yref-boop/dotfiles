xclip, wl-clipboard

### wifi
connection is managed by network manager, if i want to connect to a specific network i just
`nmcli device wifi connect SSID password PASSWORD`
#### eduroam
my university provides a script to automatically configure eduroam connection, but requires certain specific python modules:
- distro
- python-networkmanager

### bluetooth
install required bluetooth modules & add user to group `lp`
```
sudo pacman -Sy bluez bluez-utils blueman
sudo systemctl enable --now bluetooth.service
```

### power consumption
when finnishing the install, `powertop` reports around 37 W, emptying the battery in about 1h
`powertop --autotune` solves the power consumption problem, but introduces some input lag on the keyboard
after some digging, the keyboard device is `N-KEY ASUStek`, and toggling it invokes `echo on > /sys/bus/usb/devices/3-3/power/control`

in order to automate this config on each boot, i create a service such as:
/etc/systemd/system/powertop.service
```
[Unit]
Description=powertop tunnings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/bash -c "/usr/bin/powertop --auto-tune && echo on > /sys/bus/usb/devices/3-3/power/control"

[Install]
WantedBy=multi-user.target
```
enabling it to load automatically on boot:
```
sudo systemctl daemon-reload
sudo systemctl enable powertop.service
```

consumption on boot is still really high, but goes down immediately after connecting to any network

### screenshot
grim, slurp

### add fonts & icons

noto cjk, awesome...

### asusctl

### bluetooth

### zathura

### neovim
arguably one of the most important pieces of software oºn my system
