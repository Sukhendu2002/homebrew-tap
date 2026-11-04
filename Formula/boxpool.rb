class Boxpool < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.0/boxpool-darwin-arm64", using: :nounzip
      sha256 "1a5c54205f8862a1606cbcf246722003b0054c95e1a3a2de8b962f225f34bfb9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.0/boxpool-linux-amd64", using: :nounzip
      sha256 "6f8cdfb86395fe6b14a3142037061eb2bc54464eea28714cc4ed0d002ff9c393"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.0/boxpool-linux-arm64", using: :nounzip
      sha256 "24a04e31c2d04724d723a0479e1f7d870c90e0e9e250984f71fa2209cc10a451"
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
