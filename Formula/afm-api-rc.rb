class AfmApiRc < Formula
  desc "OpenAI-compatible local server for Apple Foundation Model (release candidate)"
  homepage "https://github.com/tankibaj/apple-foundation-model-api"
  url "https://github.com/tankibaj/apple-foundation-model-api/releases/download/v0.0.0-rc.feature-restructure-swiftpm-layout.r10.d66460a/afm-api-macos-arm64.tar.gz"
  version "0.0.0-rc.feature-restructure-swiftpm-layout.r10.d66460a"
  sha256 "4eeacdabe950dd33535faba2d6f5f086f1dca278cafdb1283391b095c258259f"
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
      launcher = bin/"afm-api"
      if launcher.read.include?("__AFM_API_VERSION__")
        inreplace launcher, "__AFM_API_VERSION__", version.to_s
      end
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
