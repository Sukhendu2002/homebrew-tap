class BoxpoolBeta < Formula
  desc "Pool spare machines into sandboxes for AI agents"
  homepage "https://boxpool.run"
  version "0.2.0-beta.1"
  license "Apache-2.0"
  keg_only "it is a prerelease of boxpool"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.2.0-beta.1/boxpool-darwin-arm64", using: :nounzip
      sha256 "030e0e11d34b269da576541b19193d9e8102c6400063a36cd6d908161f08ee54"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.2.0-beta.1/boxpool-linux-amd64", using: :nounzip
      sha256 "554b45336623abe7fc62a6586fb9af1d82a2b90c9c8ac3c39594a1863fd82255"
    end
    on_arm do
      url "https://github.com/Sukhendu2002/boxpool/releases/download/v0.2.0-beta.1/boxpool-linux-arm64", using: :nounzip
      sha256 "1715c0f9aaa8b27f1f8d4ecc30abf39a74f0663abad20666f14ee04806d592ea"
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
