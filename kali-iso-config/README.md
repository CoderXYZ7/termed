# Custom Kali ISO — i3 + Gruvbox

A fully-configured Kali Linux ISO with **i3wm**, **Gruvbox** dark theme, **termIDE**, **Zen Browser**, and **Departure Mono Nerd Font**.

## What's Included

| Component         | Details                                      |
|-------------------|----------------------------------------------|
| **WM**            | i3-wm + i3blocks + picom (compositor)        |
| **Launcher**      | Rofi (`Win+D`)                               |
| **Terminal**      | Kitty                                        |
| **Browser**       | Zen Browser (installed to `/opt/zen-browser`) |
| **IDE**           | termIDE (installed to `/usr/local/bin`)       |
| **Font**          | Departure Mono Nerd Font                     |
| **Color Scheme**  | Gruvbox Dark (i3, rofi, kitty, i3bar)        |
| **Base**          | kali-linux-default                           |

## Prerequisites

**Highly Recommended:** A **Kali Linux** machine (VM or native). Building on non-Kali Debian is possible but requires the workarounds below.

### Option A: Building on Kali (Easiest)
1. `sudo apt update && sudo apt install -y live-build cdebootstrap`
2. `cd kali-iso-config`
3. `sudo lb config`
4. `sudo lb build`

### Option B: Building on Debian (requires workarounds)
- **Keyring**: Install `kali-archive-keyring` (see below)
- **IPv6**: Use `wgetrc-ipv4` (see below)
- **Firmware**: Exclude `firmware-nexmon` if it fails


## Troubleshooting

### Build fails on `firmware-nexmon` or `intel-microcode`
These packages sometimes fail to install in chroot. You can exclude them by creating a preference file:

```bash
echo -e "Package: firmware-nexmon\nPin: release *\nPin-Priority: -1\n\nPackage: intel-microcode\nPin: release *\nPin-Priority: -1" | sudo tee config/archives/exclude-problematic.pref.chroot
```

### "No space left on device"
If your VM runs out of space, try switching `config/package-lists/custom.list.chroot` to use `kali-linux-core` instead of `kali-linux-default`.
## How to Build

The easiest way is to use the provided script, which handles dependencies, cleanup, and configuration automatically:

```bash
sudo ./build.sh
```

Alternatively, run manually:

The resulting ISO will appear as `live-image-amd64.hybrid.iso` in the current directory.

> [!NOTE]
> If you encounter GPG errors, ensure you have the Kali keyring installed:
> ```bash
> curl -fsSL https://archive.kali.org/archive-keyring.gpg -o kali-archive-keyring.gpg
> sudo cp kali-archive-keyring.gpg /usr/share/keyrings/kali-archive-keyring.gpg
> ```

## Key Bindings (i3)

| Key                     | Action                |
|-------------------------|-----------------------|
| `Win + Enter`           | Open Kitty terminal   |
| `Win + D`               | Open Rofi launcher    |
| `Win + Shift + Q`       | Kill focused window   |
| `Win + H/J/K/L`         | Focus left/down/up/right |
| `Win + Shift + H/J/K/L` | Move window           |
| `Win + R`               | Resize mode           |
| `Win + F`               | Fullscreen toggle     |
| `Win + Shift + Space`   | Float toggle          |
| `Win + 1-0`             | Switch workspace      |
| `Win + Shift + X`       | Lock screen           |
| `Win + Shift + R`       | Restart i3            |

## Customization

- **i3 config**: `config/includes.chroot/etc/skel/.config/i3/config`
- **Rofi theme**: `config/includes.chroot/etc/skel/.config/rofi/config.rasi`
- **Kitty config**: `config/includes.chroot/etc/skel/.config/kitty/kitty.conf`
- **Packages**: `config/package-lists/custom.list.chroot`
- **Chroot hooks**: `config/hooks/normal/*.chroot`
