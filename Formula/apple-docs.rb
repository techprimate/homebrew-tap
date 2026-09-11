class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.4"

  on_macos do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.4/apple-docs-darwin-arm64"
      sha256 "0eb9f990fc778dce8cbacadc64d52e6e6258d6043d826bab9a884b4b80bff5b3"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.4/apple-docs-darwin-amd64"
      sha256 "21470ca6f4dbad47f44012115f310ea0ba2b170d4ffd13a1d8d24a44aa205613"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.4/apple-docs-linux-arm64"
      sha256 "9e36731745ce673782428ffd52e2f67eea55eb6bb3c1ae0f4fcea99b96b866ef"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.4/apple-docs-linux-amd64"
      sha256 "e6b53b423927a6b71a3cf12abd99978b87d2a8732b7ab32fa38e78f013b589aa"
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
