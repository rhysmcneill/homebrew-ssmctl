class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "6a72c65c45d5cb4fb89e9045c3d423469a6513eb340ff163bbfc0f57423841cd" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "688223cc091a0aa5bc0e89e13c0574d92d0e01e55bb5159169619503603b03d3" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "372df6d68ca53ae03152e4a100d8b8150d382e39d8dbeb665b0d3f39444b3607" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "f86721c2dfab5b2d4468eb4a8da2fefd3215bf251589ef58e11d50d58feecaf9" # linux-amd64
    end
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "ssmctl-#{os}-#{arch}" => "ssmctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ssmctl version")
  end
end
