class Ssmctl < Formula
  desc "Lightweight CLI for AWS SSM connections, remote command execution, and file transfers"
  homepage "https://github.com/rhysmcneill/ssmctl"
  version "2.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-arm64"
      sha256 "bde57d4924d09c26717e97d8afa5628575b87f883ac2f69eec6c6c95e1a4141f" # darwin-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-darwin-amd64"
      sha256 "f5bc25078dc59123bd14ed4b8e751fa2147aa872445a529745fa934fe5e347b3" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-arm64"
      sha256 "cec50fed4084a97696883f41d524864796a4a44c2b8d6fd8df9097eff748c2e5" # linux-arm64
    else
      url "https://github.com/rhysmcneill/ssmctl/releases/download/v#{version}/ssmctl-linux-amd64"
      sha256 "5349f1c534c29437f159233347d382d420eb38c725bbb3270f999dab02ca0256" # linux-amd64
    end
  end

  def install
    os   = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "ssmctl-#{os}-#{arch}" => "ssmctl"

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
