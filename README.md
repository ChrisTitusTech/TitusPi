## TitusPi - A Raspberry Pi Desktop Distribution that doesn't suck

### Original work by PapyElGringo, he is now developing [material-shell](https://github.com/PapyElGringo/material-shell) for GNOME

An almost desktop environment made with [AwesomeWM](https://awesomewm.org/) following the [Material Design guidelines](https://material.io) with a performant opiniated mouse/keyboard workflow to increase daily productivity and comfort.


| Tiled         | Panel         | Exit screen   |
|:-------------:|:-------------:|:-------------:|
|![](https://i.imgur.com/fELCtep.png)|![](https://i.imgur.com/7IthpQS.png)|![](https://i.imgur.com/rcKOLYQ.png)|

## Before you Start

I am created two different systems for TitusPi. Below you will find two paths... Arch Install or Raspbian OS Install. Choose one and DO NOT run commands for both.

- Raspbian OS Install is what I based my Image off of @ https://portal.christitus.com
- Arch ARM OS Install is what I used for a minimal install. 

*These instructions are not complete as there are components missing to build the base OS install.* (Xorg and other dependencies) If you have ever built arch before you will be familiar with the build process. It is almost identical - https://wiki.archlinux.org/index.php/installation_guide . I will update the project with each build, but it will take a long time before the instructions will be complete due to the complexity of building this. 

Any extra scripts and modifications I made is in the `extras` folder in this project. The script I use for changing to tty1 to run emulationstation or the emulationstation.desktop file are extras I have added. 

Other modifications to the systems:
- modified Polkit to automatically elevate programs (This is a security flaw)
- autologin via tty AND gui - This is needed for the emulationstation script
- RetroPie install - I manually chose the packages and used its setup scripts for screensaver modification and other minor tweaks
- Raspi-config - I recommend installing this package on the install for configurations and tweaks

## Download

- For Raspbian installs - Grab the Lite Image (600MB) @ https://www.raspberrypi.org/downloads/raspberry-pi-os/
- For Arch installs - Grab the ARM image @ https://archlinuxarm.org/about/downloads - _Note: Raspberry Pi Images are on Platforms -> Version -> Broadcom -> Raspberry Pi_


## Arch Base Installation

### Root Pacman Setup

```bash
pacman -S xorg xorg-drivers mesa lightdm lightdm-gtk-greeter base-devel vim nano sudo clang cmake git gcc glibc networkmanager
```
### Yay Install with User (DO NOT USE ROOT)

```bash
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si
```

### Service Setup on Boot

```bash
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm
sudo systemctl enable systemd-timesyncd
```

## Raspberry Pi OS Base Installation 

*Work In Progress* - Look at the Arch install and install those packages (Note: some are a bit different because of the package manager differences)

## Material Awesome Setup

### Raspbian-Based

```
sudo apt install awesome fonts-roboto rofi compton i3lock xclip qt5-style-plugins materia-gtk-theme lxappearance xbacklight flameshot nautilus xfce4-power-manager pnmixer network-manager-gnome polkit-1-gnome terminator chromium gedit nautilus -y
wget -qO- https://git.io/papirus-icon-theme-install | sh
```

*Note: picom replaced with compton in pi because of ARM Architecture*

### Arch-Based

```
yay -S awesome rofi picom i3lock-fancy xclip ttf-roboto polkit-gnome materia-gtk-theme lxappearance flameshot pnmixer network-manager-applet xfce4-power-manager terminator chromium gedit nautilus -y
wget -qO- https://git.io/papirus-icon-theme-install | sh
```

### Program list

- [AwesomeWM](https://awesomewm.org/) as the window manager - universal package install: awesome
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font** - Debian: fonts-roboto Arch: ttf-roboto
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher - universal install: rofi
- Compton - This is depreciated, but the new picom is not supported in ARM yet
- [i3lock](https://github.com/meskarune/i3lock-fancy) the lockscreen application universal install: i3lock-fancy
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard package: xclip
- [gnome-polkit] recommend using the gnome-polkit as it integrates nicely for elevating programs that need root access
- [Materia](https://github.com/nana-4/materia-theme) as GTK theme - Arch Install: materia-theme debian: materia-gtk-theme
- [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme Universal Install: wget -qO- https://git.io/papirus-icon-theme-install | sh
- [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Laptop) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)
- [flameshot](https://flameshot.js.org/#/) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the apps.lua file
- [pnmixer](https://github.com/nicklan/pnmixer) Audio Tray icon that is in debian repositories and is easily installed on arch through AUR.
- [network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) nm-applet is a Network Manager Tray display from GNOME.
- [xfce4-power-manager](https://docs.xfce.org/xfce/xfce4-power-manager/start) XFCE4's power manager is excellent and a great way of dealing with sleep, monitor timeout, and other power management features.

<<<<<<< HEAD
### Clone the configuration
=======
#### Clone the configuration
>>>>>>> f8348a0d64f8de6b03153fe6a43631317e65424e

```
git clone https://github.com/ChrisTitusTech/TitusPi.git ~/.config/awesome
```

### Set the themes

Start `lxappearance` to active the **icon** theme and **GTK** theme
Note: for cursor theme, edit `~/.icons/default/index.theme` and `~/.config/gtk3-0/settings.ini`, for the change to also show up in applications run as root, copy the 2 files over to their respective place in `/root`.

### Same theme for Qt/KDE applications and GTK applications, and fix missing indicators

First install `qt5-style-plugins` (debian) | `qt5-styleplugins` (arch) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.

### Changing the Matrial Awesome Theme

The documentation live within the source code.

The project is split in functional directories and in each of them there is a readme where you can get additional information about the them.

* [Configuration](./configuration) is about all the **settings** available
* [Layout](./layout) hold the **disposition** of all the widgets
* [Module](./module) contain all the **features** available
* [Theme](./theme) hold all the **aesthetic** aspects
* [Widget](./widget) contain all the **widgets** available

## Extra Packages for Quality of Life

```bash
yay -S raspi-config pulseaudio pavucontrol
```

* [My ZSH](https://github.com/ChrisTitusTech/zsh)
* [PowerLevel10k](https://github.com/romkatv/powerlevel10k)
