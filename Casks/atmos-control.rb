cask "atmos-control" do
  version "0.1.0"
  sha256 "3ca51f76d7f342e591f31d91966b7b025d93bcfd15f4afe6f5c4d9c5402df64d"

  url "https://github.com/yukij3/atmos-control/releases/download/v#{version}/atmos-control-#{version}-macos-arm64.zip"
  name "atmos-control"
  desc "Plays all system audio through Apple's spatial audio renderer"
  homepage "https://github.com/yukij3/atmos-control"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "atmos-control.app"

  # The app is self-signed and not notarized; without this Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/atmos-control.app"]
  end

  uninstall quit: "dev.atmoscontrol.app"

  caveats <<~EOS
    atmos-control lives in the menu bar. The first time you turn it on, macOS asks
    for permission to capture audio: allow it.

    Turn off Spatial Audio for your AirPods in Control Center > Sound, or the audio
    is spatialized twice.

    The Surround 7.1.4 and Stereo modes need the driver:
      brew install --cask yukij3/tap/atmos-control-driver
  EOS
end
