class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.8"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.8/apple-docs-darwin-arm64"
      sha256 "e68898b4451b76214f58f063a341cb89313d0f975f8c51473cac998354889604"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.8/apple-docs-darwin-amd64"
      sha256 "bebb54b45590b76594f2b0d97b1d1294d9a325273ecbc5b3b5ced52840e3a9fb"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.8/apple-docs-linux-arm64"
      sha256 "fd995fdd2133bbe373154169a782830ce4dd196645bf15d92e38dec8f235abf0"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.8/apple-docs-linux-amd64"
      sha256 "b7c3b3d965df20cddbbb7a96a1424cde7c963e829e352780f9df27a9255536fd"
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
