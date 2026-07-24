class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "2.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "e63691063ce52a609329ae96d4de0ea817167b35e3384565f58529908bb38501" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "de8e865e6bb38be750ab0f70ef4143100dbaf4195f4c81703ae752332993dde5" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "2e6080ffb59ed10df89e07351d21e0c74ac94c66f7cf41da460dd9eb3970c5df" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "7c81931575e122cfc77d8842c95efd65735f8520843ebbebad36141dff567d40" # linux-amd64
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
