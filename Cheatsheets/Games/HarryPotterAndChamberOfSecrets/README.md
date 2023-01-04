# Harry Potter II Tricks

These are some tricks for making Harry Potter II game look and perform better on modern machines.

## Pre-Installation

Its recommended to open `PowerShell` window inside working directory and run this command:

```bat
Set-ExecutionPolicy Bypass -Scope Process -Force;
```

Do not close `PowerShell` window until whole installation process is finished!

## Automatic Installation (recommended)

Download [installation script]().

To automatically install game run:

```bat
.\install.ps1
```

Make sure the encrypted archive is in the same directory as install script.

## Manual Installation

You can get game files from [here](https://mega.nz/file/imwwHY5B#Tan6NDBkHcpJObKU8uA36BwpYhu51rFFbhRPqu946D4).

### Dependencies

 - GnuPG
 - Chocolatey

#### Chocolatey installation:

```bat
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### GnuPG installation

```bat
choco install gnupg
```

### Decrypt archive:

```bat
gpg -d --cipher-algo AES256 --no-symkey-cache HarryPotterII.tar.gz.gpg > HarryPotterII.tar.gz
```

### Extract archive:

```bat
tar xvf HarryPotterII.tar.gz
```

### Clean up files:

```bat
rm HarryPotterII.tar.gz.gpg; rm HarryPotterII.tar.gz
```

### Post installation

Now you can put extracted folder `HarryPotterII` into desired location and create desktop shortcut for game file inside this folder.

## Configuration

By default game is in shitty resolution with lots of bugs. These steps will fix that.

You need to edit two files:

File name | File path
--- | ---
`Game.ini` | `Documents/Harry Potter II/Game.ini`
`User.ini` | `Documents/Harry Potter II/User.ini`

### Game.ini

#### Resolution

In `[WinDrv.WindowsClient]` section change:

 - FullscreenViewportX=1920
 - FullscreenViewportY=1080
 - FullscreenColorBits=32

#### Frame Rate

In `[WinDrv.WindowsClient]` section change:

 - MinDesiredFrameRate=60

#### Textures fix

In `[D3DDrv.D3DRenderDevice]` section change:

 - UsePrecache=True

### User.ini

Nothing to change :)

# Author

Author of this cheatsheet is MattTheCoder-W.

Scripts included here were also created by MattTheCoder-W.