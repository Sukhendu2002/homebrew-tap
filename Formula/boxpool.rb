class Boxpool < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.1.1"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.1/boxpool-darwin-arm64", using: :nounzip
      sha256 "da165c82fa48da2f1cda112571fe75e60f7439d095c371c7d665c4145689bb52"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.1/boxpool-linux-amd64", using: :nounzip
      sha256 "e6d6c9aeb9cff87f18f2da720be4b011d67d47e8ccf347c47556577ec998ec98"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.1/boxpool-linux-arm64", using: :nounzip
      sha256 "3ecfd3b6d71f3adfa898b7e32a38af9aee22134f4aa4cd1dfac9b70dc0e9aae5"
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
