## installation
i used to have a long-ass explanation of the manual explanation here, but in all hosnesty, now i just use `archinstall`, given that most of the time i just reinstall the OS without much reason & need it ready quite fast, the installing script comes really handy <3

### characteristics
btrfs & encryption, without any extras (i manually installed the environment after the "core" instalation finished)

### asusctl
to add support for customized fan curves, cpu profiles... do the following:
```
sudo pacman -Sy asusctl supergfxctl
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now supergfxd
```

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

### clipboard
to add an interface for my clipboard i usually just use `xclip`, but for it to interact correctly with wayland i also need `wl-clipboard`

### screenshot
grim, slurp

### add fonts & icons

noto cjk, awesome...

### zathura

### neovim
arguably one of the most important pieces of software on my system

### ocaml
install opam
opam init

### julia
install aur's julia-bin

### haskell
yay -S ghcup-hs-bin
ghcup install
add line to .bashrc
