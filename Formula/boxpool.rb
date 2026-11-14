class Boxpool < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.2/boxpool-darwin-arm64", using: :nounzip
      sha256 "fc035e5f1f0f47df66ad66727636064177f0a9d8512aa7b51ba4a2dfa936a084"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.2/boxpool-linux-amd64", using: :nounzip
      sha256 "72f4830dcc1d14acc888ef9709373743c2fdf60db8c37076127fc27d3f84b03c"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.2/boxpool-linux-arm64", using: :nounzip
      sha256 "333d5ae1d836be55c5d22d2a6306793ea5a4d6c7f452e2f6fb2e1fdc928d8692"
    end
  end

  def install
    bin.install Dir["boxpool-*"].first => "boxpool"
    chmod 0755, bin/"boxpool"
  end

  def caveats
    <<~EOS
      Run boxpool doctor to check this host, then boxpool up on macOS
      or sudo boxpool up on Linux to install and start the daemon.
      The macOS binary is ad-hoc signed, not notarized:
      https://github.com/Sukhendu2002/boxpool/blob/main/docs/development.md#releases
    EOS
  end

  test do
    assert_match "boxpool v#{version}", shell_output("#{bin}/boxpool version")
  end
end
