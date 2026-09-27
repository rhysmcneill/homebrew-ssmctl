class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "2.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "62d1615f1705be3dda04e963c4c3389173dfcdaa105175c0f3f844909d832625" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "6e562dbcb889abe7994d01ff6ebe677ff076a151cbc9d1ba73155a5b433e6d59" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "3805c6150363f69196e3ca5094464f6b89e52533bcdafd22d473c7e86e72ef32" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "1da98269c61d26b62c7b4c73ce17a107b5a0d9d188378569ae89e55a749e260d" # linux-amd64
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
