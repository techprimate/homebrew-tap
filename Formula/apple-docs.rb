class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.10"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.10/apple-docs-darwin-arm64"
      sha256 "f085f9e2b7be1d0814ab826334989d2ed2f968cf87cb0cc57cb493a84cc5c21e"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.10/apple-docs-darwin-amd64"
      sha256 "022a0bc964fde2f5ff492f099ea14d06c7c2993ae863181d6285f9255298b311"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.10/apple-docs-linux-arm64"
      sha256 "2624d00d8d81f8f306b2444961b6b89996655de3587bd511e147a323c302a22b"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.10/apple-docs-linux-amd64"
      sha256 "7c81b0dbd41861a49143077c582ffaa55e8d3a1e0ec8ae2c72d3c895bacd7a7e"
    end
  end

  def install
    ENV["TELEMETRY_DISABLED"] = "true"
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
    (bin / "apple-docs").chmod 0755
    generate_completions_from_executable(bin / "apple-docs", "--generate-completion-script")
  end

  test do
    ENV["TELEMETRY_DISABLED"] = "true"
    assert_match version.to_s, shell_output("#{bin}/apple-docs --version")
    assert_match "apple-docs\t", shell_output("#{bin}/apple-docs agent skills list")
    assert_match "name: apple-docs", shell_output("#{bin}/apple-docs agent skills get apple-docs")
    assert_path_exists bash_completion / "apple-docs"
    assert_path_exists zsh_completion / "_apple-docs"
    assert_path_exists fish_completion / "apple-docs.fish"
  end
end
