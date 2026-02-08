class AfmApiRc < Formula
  desc "OpenAI-compatible local server for Apple Foundation Model (release candidate)"
  homepage "https://github.com/tankibaj/apple-foundation-model-api"
  url "https://github.com/tankibaj/apple-foundation-model-api/releases/download/v0.0.0-rc.feature-restructure-swiftpm-layout.d71e3d4/afm-api-macos-arm64.tar.gz"
  version "0.0.0-rc.feature-restructure-swiftpm-layout.d71e3d4"
  sha256 "d14811834131b1d9a900cde77cea890c40f0ffa60384e8c5587d4ebc60a37018"
  license "MIT"

  depends_on :macos

  def install
    if File.exist?("afm-api") && File.exist?("afm-api-server")
      bin.install "afm-api"
      bin.install "afm-api-server"
    else
      bin.install "bin/afm-api"
      pkgshare.install "Package.swift"
      pkgshare.install "Sources"
      inreplace bin/"afm-api", "__AFM_API_VERSION__", version.to_s
    end
  end

  test do
    assert_predicate bin/"afm-api", :exist?
    if (bin/"afm-api-server").exist?
      assert_predicate bin/"afm-api-server", :exist?
    else
      assert_predicate pkgshare/"Package.swift", :exist?
      assert_predicate pkgshare/"Sources/AFMAPI/main.swift", :exist?
    end
  end
end
