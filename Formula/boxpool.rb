class Boxpool < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.1.3"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.3/boxpool-darwin-arm64", using: :nounzip
      sha256 "73941d8f64fe2b7e208e67f33a9003429e385880954708ea4a9cbb112587e220"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.3/boxpool-linux-amd64", using: :nounzip
      sha256 "f8494ed5b6a368a7cd28e7d8876cc9a07d51efa72b4cc8b8121238e4f2f26405"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.3/boxpool-linux-arm64", using: :nounzip
      sha256 "eb26c2b8e61cd8f817684a21768c8b80d0bdf0cb061d059f0348f27abf819ae8"
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
