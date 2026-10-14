class AppleDocs < Formula
  desc "CLI to explore Apple Developer Documentation"
  homepage "https://github.com/techprimate/apple-docs-cli"
  version "0.0.9"
  license "FSL-1.1-MIT"
  revision 1 if version.to_s == "0.0.4"
  revision 2 if version.to_s == "0.0.5"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.9/apple-docs-darwin-arm64"
      sha256 "b00401f85665c3d3d923689c77ced4995f41826df2df08eaf87292bbd5eb0002"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.9/apple-docs-darwin-amd64"
      sha256 "39810828724c3b7826336902991ad87d962a4749a5b0c9cace32c46b376e014e"
    end
  end

  on_linux do
    on_arm do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.9/apple-docs-linux-arm64"
      sha256 "e28d4771ed51e08a6335475cb71992457253a49c5577716962ba6858cf0afeb2"
    end
    on_intel do
      url "https://packages.techprimate.com/apple-docs/bin/v0.0.9/apple-docs-linux-amd64"
      sha256 "bc7220f26fcb3d2c044ba2e423df1817a84909c14f02914787a94608129a6ae9"
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
