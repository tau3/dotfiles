* disable sleep and hibernate on Ubuntu with systemd:
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

* attach monitor
xrandr | less
xrandr --output HDMI-1 --mode 1920x1080 --auto --left-of LVDS-1

* detach
xrandr -s 0

* look at D.Ritchie
curl -sL git.io/unix | less

* configure dns
sudo xbps-install openresolv nscd unbound

* set console font
unzip /usr/share/kbd/consolefonts/ruscii_8x16.psf.gz
setfont ruscii_8x16.psfu

* weather forecast from console
curl wttr.in

* mount usb wothout root
udevil

* add wifi connection 
1. wpa_passphrase <wifi_name> <password>
2. add this to /etc/wpa_suplicant/wpa_supplicant-<interface>.conf
3. maybe set priority for each connection (lower is better)
4. sudo sv restart wpa_supplicant

* ssh tunnel for scp (https://stackoverflow.com/posts/9139670)
ssh -L 1234:<target_address>:22 -p <gateway_port> <gateway_user>@<gateway_address>
scp -P 1234 <target_user>@localhost:file .

* connect to guest with ssh
1. virtualbox menu: file -> host network manager
2. create new network here
3. vm settings -> network 
4. add new adapter (virtual host adapter)
5. specify created network
6. start wm
7. ip a
8. bring new interface up (e.g. modify /etc/netplan/<config>.yaml, and then netplan generate && netplay apply)

