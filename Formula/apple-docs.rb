class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.6"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.6/apple-docs-darwin-arm64"
      sha256 "703ecfddeee4e2ca872d6a605201a6753440f6ef13209c49dc92841da383bc5e"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.6/apple-docs-darwin-amd64"
      sha256 "d46ce7e10c35add41bab2598dffc21ede85333f1696b6a6d71271142a63226fd"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.6/apple-docs-linux-arm64"
      sha256 "471f9a098786926fef4218f04e7312f62474392b333b5aa920a388866d2c573b"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.6/apple-docs-linux-amd64"
      sha256 "2d83e1e2aae9625ab176e19615c3cae45558b052ad1fa1fff9bfcd011139acc3"
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
