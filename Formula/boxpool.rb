class Boxpool < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.4/boxpool-darwin-arm64", using: :nounzip
      sha256 "3139534645dc1c7ee4823763a97a3dc7d895ab7d505c7381312a5d5c304e3d14"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.4/boxpool-linux-amd64", using: :nounzip
      sha256 "ae94afd945b7e9b667f3ae5d70959c467dfcff87cd052c1f48a6596dc800ccdb"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.1.4/boxpool-linux-arm64", using: :nounzip
      sha256 "841768b00edd55915be9dbd89a315edd005bcc730ddf7e06970ff7ae71c3dacc"
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
