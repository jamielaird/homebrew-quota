cask "quota" do
  version "1.0.0"
  sha256 "60e0859e25dbe2455ca35d1654a7827033ccb39b605b3aa48bae1b5ea81d726e"

  url "https://github.com/jamielaird/homebrew-quota/releases/download/v#{version}/Quota-#{version}.zip"
  name "Quota"
  desc "Menu-bar monitor for Claude Code usage, plan quota, and AI API spend"
  homepage "https://github.com/jamielaird/quota"

  # Releases that carry the binary live in this tap repo, so check it for
  # newer versions.
  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Quota.app"

  # Quota is ad-hoc signed (not notarized), so strip the download quarantine
  # after install — otherwise macOS Gatekeeper blocks the first launch. This
  # gives `brew install --cask jamielaird/quota/quota` a clean first open.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Quota.app"]
  end

  zap trash: "~/Library/Preferences/app.quota.Quota.plist"
end
