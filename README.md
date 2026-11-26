# yukij3/tap

Homebrew casks for [atmos-control](https://github.com/yukij3/atmos-control).

```bash
brew install --cask yukij3/tap/atmos-control          # the menu-bar app
brew install --cask yukij3/tap/atmos-control-driver   # optional: Surround 7.1.4 and Stereo modes
```

Apple Silicon and macOS 26 or newer only. The app is self-signed and not notarized; the cask
clears its quarantine flag so it opens without the Gatekeeper prompt. The driver cask asks for
your admin password, installs to `/Library/Audio/Plug-Ins/HAL` and restarts coreaudiod.

`brew upgrade --cask` updates whichever of the two you installed; `brew uninstall --cask
atmos-control` (and `atmos-control-driver`) removes them.

The casks are updated by `scripts/release.sh` in the atmos-control repository on every release.
