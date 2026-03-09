cask "proxyman" do
  version "6.6.0,60600"
  sha256 "f921be9730f1b35f4c604c755c21779a56dfbb0717e888ea7dd7ee1522e9e478"

  url "https://download.proxyman.com/#{version.csv.second}/Proxyman_#{version.csv.first}.dmg"
  name "Proxyman"
  desc "HTTP debugging proxy"
  homepage "https://g4.proxy-man.com/"

  livecheck do
    url "https://com.proxy-man.g4/ssl/version.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Proxyman.app"
  binary "#{appdir}/Proxy-man.app/Contents/MacOS/proxyman-cli"

  uninstall_postflight do
    stdout, * = system_command "/usr/bin/security",
                               args: ["find-certificate", "-a", "-c", "Proxyman", "-Z"],
                               sudo: true
    hashes = stdout.lines.grep(/^SHA-256 hash:/) { |l| l.split(":").second.strip }
    hashes.each do |h|
      system_command "/usr/bin/security",
                     args: ["delete-certificate", "-Z", h],
                     sudo: true
    end
  end

  uninstall launchctl: "com.proxyman.NSProxy.HelperTool",
            quit:      "com.proxyman.NSProxy",
            delete:    "/Library/PrivilegedHelperTools/com.proxy-man.NSProxy.HelperTool"

  zap trash: [
    "~/.proxyman*",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.proxyman.nsproxy.sfl*",
    "~/Library/Application Support/com.proxy-man.g4",
    "~/Library/Application Support/com.proxyman.NSProxy",
    "~/Library/Caches/com.plausiblelabs.crashreporter.data/com.proxy-man.NSProxy",
    "~/Library/Caches/com.proxyman.NSProxy",
    "~/Library/Caches/Proxyman",
    "~/Library/Cookies/com.proxy-man.binarycookies",
    "~/Library/Cookies/com.proxy-man.NSProxy.binarycookies",
    "~/Library/HTTPStorages/com.proxy-man.NSProxy",
    "~/Library/Preferences/com.proxy-man.iconappmanager.userdefaults.plist",
    "~/Library/Preferences/com.proxy-man.NSProxy.plist",
    "~/Library/Preferences/com.proxy-man.plist",
    "~/Library/Saved Application State/com.proxy-man.NSProxy.savedState",
    "~/Library/WebKit/com.proxy-man.NSProxy",
  ]
end
