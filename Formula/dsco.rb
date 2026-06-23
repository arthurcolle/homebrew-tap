class Dsco < Formula
  desc "Local-first self-introspecting agentic runtime written in pure C"
  homepage "https://github.com/arthurcolle/dsco"
  url "https://github.com/arthurcolle/dsco/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "efd9dfa352832859effa83fb052ecc6805dd3a26fc00003ede6b5f268d9de984"
  license "MIT"
  head "https://github.com/arthurcolle/dsco.git", branch: "perf/dramatic-20260621"

  depends_on "pkg-config" => :build
  depends_on "hiredis"
  depends_on "libsodium"
  depends_on "libuv"
  depends_on :macos
  depends_on "mbedtls@3"
  depends_on "readline"

  uses_from_macos "curl"
  uses_from_macos "sqlite"

  def install
    system "make", "dsco", "dsco-lite", "dsc", "CC=#{ENV.cc}"
    bin.install "dsco", "dsco-lite", "dsc"
    pkgshare.install "include/tool_embeddings.bin"
  end

  test do
    assert_match "dsco v#{version}", shell_output("#{bin}/dsco --version") unless build.head?
    assert_match "dsco v", shell_output("#{bin}/dsco --version")
    assert_match(/"ok":\s*true/, shell_output("#{bin}/dsco --tool-exec cwd '{}'"))
  end
end
