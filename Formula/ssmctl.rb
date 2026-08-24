class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "2.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "4a3c879d31f99a1826b82a40987062e193a35a16f4400cbf4afa8bc7b51d6ab9" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "c63d4eb25716ab4685cdc87fe8ed046f603a57b17f6133aadb70d6a6b3f542ab" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "0ea7047b08fe977bc2d24c009326dd0cf6c06e99b6126848a9293418c3a973d8" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "f4b29044df2d5db70a1e56af4d88294128b08cb0a3b295022f6dd161d99818e1" # linux-amd64
    end
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "ssmctl-#{os}-#{arch}" => "ssmctl"
    (bin/"ssmctl").chmod(0755)

    # Shell completions — generated at install time so users get tab completion
    # automatically without any extra setup steps.
    generate_completions_from_executable(bin/"ssmctl", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ssmctl version")
    assert_match "ssmctl", shell_output("#{bin}/ssmctl completion bash")
    assert_match "ssmctl", shell_output("#{bin}/ssmctl completion zsh")
    assert_match "ssmctl", shell_output("#{bin}/ssmctl completion fish")
  end
end
