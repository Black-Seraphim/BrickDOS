# BrickDOS Installation

This document summarizes the setup used for the finished BrickDOS system.

It is **not** intended to be a one-click installer. The repository documents the configuration of the finished build and provides the relevant configuration files separately, instead of embedding their contents in this document.

> **Important:** Game files, commercial software, disk images and game-specific configurations are not part of this repository.

## 1. Base system

Prepare the microSD card with **Raspberry Pi OS (64-bit)** using Raspberry Pi Imager.

After the first boot, complete the normal Raspberry Pi setup and make sure the system has network access.

BrickDOS uses **X11**, Openbox and xterm for its visible frontend. If the system currently uses Wayland, switch it to X11:

```bash
sudo raspi-config
```

Then select:

```text
Advanced Options
└── Wayland
    └── X11
```

Reboot when requested.

## 2. System update

Update the base system before installing the BrickDOS software stack:

```bash
sudo apt update
sudo apt upgrade -y
```

## 3. Required packages

Install the packages used by BrickDOS:

```bash
sudo apt install cifs-utils xterm dosbox-x openbox obconf scummvm fluidsynth fluid-soundfont-gm dos2unix -y
```

The main runtime components are:

- **Openbox** – minimal window manager
- **xterm** – fullscreen text interface
- **DOSBox-X** – DOS game execution
- **ScummVM** – supported adventure games
- **FluidSynth** – MIDI synthesis
- **dos2unix** – conversion of shell scripts copied from Windows systems

## 4. CPU performance mode

The finished system uses the Raspberry Pi CPU governor in `performance` mode.

Use the supplied udev rule:

[`config/system/99-cpufreq-governor.rules`](../config/system/99-cpufreq-governor.rules)

Install it as:

```text
/etc/udev/rules.d/99-cpufreq-governor.rules
```

Then reload the udev rules and reboot.

The active governor can be checked with:

```bash
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

## 5. BrickDOS directory

The runtime installation is located below:

```text
/opt/brickdos/
```

The directory layout is documented separately:

[`FolderStructure.md`](FolderStructure.md)

Create the required directories and copy the repository data or your prepared BrickDOS files into `/opt/brickdos/`.

The menu system expects its scripts and text files below:

```text
/opt/brickdos/menu/
```

DOSBox-X and ScummVM launchers use their corresponding directories below `/opt/brickdos/`.

## 6. File ownership and permissions

The complete installation notes use the account `seraphim`, while an older permissions note uses `pi`.

Use the account that actually runs BrickDOS and keep ownership consistent across `/opt/brickdos/`.

Example:

```bash
sudo chown -R <USER>:<USER> /opt/brickdos
chmod -R 755 /opt/brickdos
```

If shell scripts were prepared or edited on Windows, convert them before use:

```bash
dos2unix *.sh
```

Apply the conversion to the affected script directories as required.

## 7. Optional network transfer directory

The finished setup used a CIFS/SMB share as a convenient transfer location between another computer and the Raspberry Pi.

Mount point:

```text
/mnt/austausch
```

The repository keeps the required examples separately:

- [`config/samba/fstab.entry`](../config/samba/fstab.entry)
- [`config/samba/smbcredentials.example`](../config/samba/smbcredentials.example)

Do **not** commit real SMB credentials to the repository.

The local credentials file used by the installation is:

```text
/root/.smbcredentials
```

After configuring the share, test it with:

```bash
sudo mount -a
ls /mnt/austausch
```

The network share is only a transfer mechanism and is not required for BrickDOS during normal operation.

## 8. Copying the BrickDOS runtime data

The original installation copied the prepared BrickDOS directory from the network share into `/opt/brickdos/`.

A typical transfer can be performed with:

```bash
sudo rsync -avh --progress /mnt/austausch/brickdos/ /opt/brickdos/
```

After copying, restore the correct ownership and permissions for the BrickDOS user.

## 9. ScummVM configuration

BrickDOS uses a prepared ScummVM configuration.

Repository reference:

[`config/scummvm/scummvm.ini`](../config/scummvm/scummvm.ini)

Install it in the configuration directory of the user that runs BrickDOS:

```text
~/.config/scummvm/scummvm.ini
```

Game data itself is not included in the repository.

## 10. MIDI / FluidSynth

FluidSynth is used as the MIDI synthesizer for DOSBox-X.

The systemd unit is stored separately:

[`config/system/fluidsynth.service`](../config/system/fluidsynth.service)

Install it as:

```text
/etc/systemd/system/fluidsynth.service
```

Then reload systemd, enable the service and start it.

The finished setup uses an SC-55-compatible SoundFont at:

```text
/usr/share/sounds/sf2/SC-55.sf2
```

The SoundFont itself is not included in this repository. Provide a suitable SoundFont separately and adjust the service configuration if its filename or location differs.

Available MIDI devices can be checked with:

```bash
aplaymidi -l
```

The detected MIDI port can then be used in the DOSBox-X configuration.

## 11. VGA-style font

The BrickDOS menu uses an IBM VGA-style font for the fullscreen xterm interface.

Install the font for the BrickDOS user below:

```text
~/.local/share/fonts/
```

After copying the font, rebuild the user font cache:

```bash
fc-cache -fv ~/.local/share/fonts
```

The Openbox autostart configuration expects the font name used by the finished BrickDOS setup.

## 12. Display resolution and rotation

The finished BrickDOS display runs at:

```text
1024 × 768 @ 60 Hz
```

This matches the native XGA resolution of the AUO G064XAN01.0 panel.

The display configuration is split between the boot configuration and X11.

Use the supplied files:

- [`config/boot/cmdline.txt.append`](../config/boot/cmdline.txt.append)
- [`config/x11/10-monitor.conf`](../config/x11/10-monitor.conf)

The boot parameter is appended to:

```text
/boot/firmware/cmdline.txt
```

The X11 monitor configuration is installed as:

```text
/etc/X11/xorg.conf.d/10-monitor.conf
```

BrickDOS also rotates the display from the Openbox autostart configuration.

## 13. LightDM and Openbox

BrickDOS automatically logs into a minimal Openbox session and starts the fullscreen xterm frontend.

The relevant configuration files are kept separately:

- [`config/lightdm/lightdm.conf`](../config/lightdm/lightdm.conf)
- [`config/openbox/autostart`](../config/openbox/autostart)

Install them at:

```text
/etc/lightdm/lightdm.conf
~/.config/openbox/autostart
```

The autostart launches the BrickDOS fake boot sequence:

[`menu/fake_boot.sh`](../menu/fake_boot.sh)

From there, control is handed over to the ASCII menu system.

## 14. Boot logo

The Raspberry Pi boot splash is replaced by the BrickDOS logo.

Logo:

[`assets/BrickDOS.png`](../assets/BrickDOS.png)

The image is copied over the splash image of the currently active Plymouth theme, followed by an initramfs update.

Because Plymouth theme names can differ between installations, verify the currently active theme before replacing its splash image.

## 15. Reboot and test

After the configuration is complete:

```bash
sudo reboot
```

A normal BrickDOS boot should result in the following sequence:

```text
BrickDOS splash
    ↓
Raspberry Pi OS
    ↓
LightDM autologin
    ↓
Openbox
    ↓
BrickDOS fake boot
    ↓
ASCII menu
    ↓
game launcher
    ├── DOSBox-X
    └── ScummVM
```

The Linux desktop is intentionally hidden during normal use.

## 16. Menu and launcher examples

The repository contains the complete BrickDOS menu structure and a small number of launcher examples.

- [`menu/`](../menu/) – menu text files and menu shell scripts
- [`examples/`](../examples/) – example DOSBox-X and ScummVM launchers

These examples document the launch chain without distributing game data.

The game-to-launcher mapping used by the finished system is available here:

[`GameMapping.csv`](GameMapping.csv)

## Notes

This installation guide reflects the configuration of the finished BrickDOS build. It is primarily a technical reference for reproducing or adapting the setup.

Hardware details are documented separately in:

[`BoM.md`](BoM.md)

For the complete project presentation, photographs and build background, visit:

**https://brickdos.net**
