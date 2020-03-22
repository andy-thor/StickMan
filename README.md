<div align="center">
  <h1>StickMan</h1>
</div>

<br>
<div align="center">
  <a href="https://andy-thor.github.io/StickMan">StickMan</a>
  <strong> is a toon being interacting on your desktop.</strong>
</div>

<div align="center">
  StickMan is a free software developed in Python and GTK for the Linux systems.
</div>

#### ___If you are a Windows user you have the possibility to download the [installer]___

<br><br>

## Prerequirements
*1*. Install the following packages depending on your distro(Linux).
| Ruta                                   | Descripción  |
|----------------------------------------|:-------------|
| ___Ubuntu / Debian___ | _sudo apt install libgirepository1.0-dev gcc libcairo2-dev make pkg-config python3-dev gir1.2-gtk-3.0_ |
| ___Fedora___ | _sudo dnf install gcc gobject-introspection-devel cairo-devel make pkg-config python3-devel gtk3_ |
| ___Arch Linux___ | _sudo pacman -S python cairo pkgconf gobject-introspection gtk3 make_ |
| ___openSUSE___ | _sudo zypper install cairo-devel make pkg-config python3-devel gcc gobject-introspection-devel_ |

*2*. Use the package manager [pip] to install the remaining dependencies(Linux and __macOS__?). This does not work in Windows.
```bash
pip install -r requirements.txt
```
<br><br>
## Installation

You can install the app typing next sentences:

```bash
sudo python setup.py install --prefix=/usr
```
or simply if you have installed _Make_ you can run these sentences:
```bash
sudo make install
```
More information on the installation method is available in the __*INSTALL*__ file.

<br>

## Usage

#### Run without install it:
```bash
python stickman
```
#### If it is installed just type:
```bash
stickman
```

[pip]: https://pip.pypa.io/en/stable/
[installer]: https://github.com/Andy-thor/StickMan/releases/download/v0.3.1/stickman-0.3.1.exe