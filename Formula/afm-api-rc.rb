class AfmApiRc < Formula
  desc "OpenAI-compatible local server for Apple Foundation Model (release candidate)"
  homepage "https://github.com/tankibaj/apple-foundation-model-api"
  url "https://github.com/tankibaj/apple-foundation-model-api/releases/download/v0.0.0-rc.feature-restructure-swiftpm-layout.r8.9462a41/afm-api-macos-arm64.tar.gz"
  version "0.0.0-rc.feature-restructure-swiftpm-layout.r8.9462a41"
  sha256 "461bd9157e05710f6a8bc99e6c16f4f3593465381119fa357051db3dc4ebcaa2"
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
