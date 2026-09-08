# Homebrew formula template for `apple-docs` (stable channel).
#
# Url points at the registry (packages.techprimate.com), NOT at GitHub Release assets,
# so the formula has no dependency on the (possibly private) source repo.
class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.1"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.1/apple-docs-darwin-arm64"
    sha256 "dc6f4c54ffb138d8cb8c3a8db2b729c8a0e3b365e7baa726db9d1e4418d16a8a"
  end

  if Hardware::CPU.intel?
    url "https://packages.techprimate.com/apple-docs/bin/v0.0.1/apple-docs-darwin-amd64"
    sha256 "bd20f9c4181873d394fa2ca9c6981513f3882bb5e1e374877fc987261699746d"
  end

  def install
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-docs --version")
  end
end
