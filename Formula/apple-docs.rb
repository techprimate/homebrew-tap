class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.3"

  on_macos do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-darwin-arm64"
      sha256 "89cb3c3b0e7d0fc06a8cf6583077e0b2e86a50cafc8f027450563bc9f7be8d36"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-darwin-amd64"
      sha256 "b825003de65e87ae08959c127eacdb7d19676633fc70f5d1fec4dbbbb16323bd"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-linux-arm64"
      sha256 "51d7a85ee4af62f1cc35d5583066ae7ffe122efa13ac53f994bf2a523d793a5e"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.3/apple-docs-linux-amd64"
      sha256 "138779a95207b7db8459cf3818e3e27272ca376127d3815babfbc67694ba9fbe"
    end
  end

  def install
    binary = Dir["apple-docs-*"].first
    bin.install binary => "apple-docs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-docs --version")
  end
end
