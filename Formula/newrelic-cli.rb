class NewrelicCli < Formula
  desc "The New Relic Command-line Interface"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.2.3.tar.gz"
  sha256 "f09d7e1705731578da79f0d9c204a6875edbd1d78cc6e69bd9f7d00dd9919986"
  head "https://github.com/newrelic/newrelic-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b0acd5cd0bf0b6149972457c53cef90ca7974b4df6f051a559cf67c0df8bdaaa" => :catalina
    sha256 "e149e6ed90894bd8d74fdfa881861c0e47434cc2c38c29ec1ff1409e6b029ec8" => :mojave
    sha256 "4c87e062f9dab115690e9a333593ed134e4a1981752683232cb074584c6e5bbe" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ENV["PROJECT_VER"] = version
    system "make", "compile-only"
    bin.install "bin/darwin/newrelic"
  end

  test do
    assert_match /pluginDir/, shell_output("#{bin}/newrelic config list")
    assert_match /logLevel/, shell_output("#{bin}/newrelic config list")
    assert_match /sendUsageData/, shell_output("#{bin}/newrelic config list")
    assert_match version.to_s, shell_output("#{bin}/newrelic version 2>&1")
  end
end
