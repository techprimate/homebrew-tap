class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.3"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-darwin-arm64"
    sha256 "89cb3c3b0e7d0fc06a8cf6583077e0b2e86a50cafc8f027450563bc9f7be8d36"
  end

  if Hardware::CPU.intel?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-darwin-amd64"
    sha256 "b825003de65e87ae08959c127eacdb7d19676633fc70f5d1fec4dbbbb16323bd"
  end

  def install
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-docs --version")
  end
end
