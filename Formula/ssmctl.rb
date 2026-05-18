class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "2.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "87055686b79dde87e6f5964d12b1ea728f53ead6fc829f123bfca68083f263be" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "47822bae92b4f1d8f58f7da02f982d1d42e310681031733893c5681001f2efc8" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "be9bb2d36906b7beda239c9bd87808715fe0ad0f246f33ef8479d654a9fd032f" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "33a15475f2e43cc71670bafa2c89625310c9303f0aba3363fcc6036a1263d0cc" # linux-amd64
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
