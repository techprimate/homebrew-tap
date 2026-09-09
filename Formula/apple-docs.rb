class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.2"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.2/apple-docs-darwin-arm64"
    sha256 "a5669672f897904314aac53fa592b0be3656bfeb353160d15db88bb0268b70cb"
  end

  if Hardware::CPU.intel?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.2/apple-docs-darwin-amd64"
    sha256 "5407760cb3b50763e3cbcfcb792f8167dc104b4e93c9d3e133b67bebac49f959"
  end

  def install
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-docs --version")
  end
end
