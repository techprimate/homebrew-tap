class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.5"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.5/apple-docs-darwin-arm64"
      sha256 "bc8fd9b40e0c13c46d39fbe874968ff774861f3221f96e853d346c60eb6aae32"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.5/apple-docs-darwin-amd64"
      sha256 "3740b7d2dd73b80734c3f270e9f82e20e80d0c1151d151162ef36fb5a9a4eae9"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.5/apple-docs-linux-arm64"
      sha256 "5267354533ae71e596d55ea7491bb9d3af3adc0957347f6615b105d3b671300e"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.5/apple-docs-linux-amd64"
      sha256 "fc6d3ca50a16180c7cce47bb27f18ac21fb329329ec5b9e12ece4eb36d606f51"
    end
  end

  def install
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
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
