class SshAskpass < Formula
    url "https://github.com/fwrs/ssh-askpass.git", branch: "main"
    version "0.1"
    depends_on xcode: :build

    def install
        xcodebuild
        bin.install "build/Release/ssh-askpass"
        prefix.install "ssh-askpass.plist" => "#{plist_name}.plist"
    end

    def caveats
        <<~EOS
            Run the following commands and then restart your machine:
                sudo mkdir -p /private/var/select/X11/bin
                sudo ln -sf #{opt_bin}/ssh-askpass /private/var/select/X11/bin/ssh-askpass
                brew services start #{name}
        EOS
    end

    service do
        name macos: "io.fwrs.ssh-askpass"
    end
end
