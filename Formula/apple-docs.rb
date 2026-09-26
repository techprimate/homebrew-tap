class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.7"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.7/apple-docs-darwin-arm64"
      sha256 "41d542af0a57df70ddb7decb015bd00b9b957eb297996039172e7c4a559c4017"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.7/apple-docs-darwin-amd64"
      sha256 "acdb5f2bdb22a477d37cb972a632c32230c74cdee718836e8d90411c31185884"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.7/apple-docs-linux-arm64"
      sha256 "37954d2e69a2fbf3c02ff10e188658fcaa9980c8386e0e30cea8bdcfc1b5b679"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.7/apple-docs-linux-amd64"
      sha256 "3e25ded3288f13171ec49189e3bfaf412747881c0c4cad25ec15b58d2ad1d948"
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
