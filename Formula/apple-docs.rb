class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.1.0"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.1.0/apple-docs-darwin-arm64"
      sha256 "abe04d6bff6b456fcdf41bcf4ef5759114977d4b3e857084f5336f52b231b836"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.1.0/apple-docs-darwin-amd64"
      sha256 "db1fee8e562c17e996043dde2a2c5a3ce366d70374bd59f88696f2bc00e0deb9"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.1.0/apple-docs-linux-arm64"
      sha256 "587c9a21664f789a9e43db862dfd8452c663e202d59fb19c758f7cdde8fca725"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.1.0/apple-docs-linux-amd64"
      sha256 "d006b4069e894b19e9b703828579b26bc2236e4b4ff7815e9815bb9de9f2611f"
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
