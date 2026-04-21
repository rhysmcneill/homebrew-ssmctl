class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "ee4948e661989b518065319d10029850989bd8462929ba8ba4de797b8d2f923e" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "8251173077ce7f37eccf94efb72c4fabba25239158f9a3228a3f38219add5c8d" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "e49782dd6cac52bcfe3bf760c597be57f13906b020d996b8737e95ff3d3c2edd" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "4e18427c104abee07c1a9b248acd8e4e316e63ae45542ceac94eca05af75fb31" # linux-amd64
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
