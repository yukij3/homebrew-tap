cask "atmos-control-driver" do
  version "0.1.0"
  sha256 "9454e4dff4a2bb7a89028f5b2725a130187f997ac5e0e3f9d10579f5ccddb572"

  url "https://github.com/yukij3/atmos-control/releases/download/v#{version}/atmos-control-driver-#{version}.zip"
  name "atmos-control driver"
  desc "Loopback audio driver for atmos-control's Surround 7.1.4 and Stereo modes"
  homepage "https://github.com/yukij3/atmos-control"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  artifact "atmos-control-driver-#{version}/atmos-control.driver",
           target: "/Library/Audio/Plug-Ins/HAL/atmos-control.driver"

  # coreaudiod only loads HAL drivers at startup. It is a KeepAlive daemon, so launchd
  # restarts it right away; `launchctl kickstart` is refused with SIP on, killall is not.
  postflight_steps do
    run "/usr/sbin/chown", args: ["-R", "root:wheel", "/Library/Audio/Plug-Ins/HAL/atmos-control.driver"], sudo: true
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Library/Audio/Plug-Ins/HAL/atmos-control.driver"],
                          sudo: true
    run "/usr/bin/killall", args: ["coreaudiod"], sudo: true
  end

  uninstall_postflight_steps do
    run "/usr/bin/killall", args: ["coreaudiod"], sudo: true, must_succeed: false
  end

  caveats <<~EOS
    Installing and removing the driver restarts coreaudiod: audio drops out for
    about a second. An output device named "atmos-control" then appears in
    System Settings > Sound.

    The driver has only been tested with System Integrity Protection disabled.
  EOS
end
