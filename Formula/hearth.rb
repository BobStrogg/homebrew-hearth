class Hearth < Formula
  desc "Web UI for ACP coding agents"
  homepage "https://github.com/BobStrogg/hearth"
  url "https://registry.npmjs.org/hearth-acp/-/hearth-acp-0.5.10.tgz"
  sha256 "614944131469181659f18a136495d8c9c642a2f5cabfa5d84fec66fb4527f14a"
  license "MIT"
  depends_on "node"
  def install
    system "npm", "install", "-g", "--prefix=#{libexec}", cached_download
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
  service do
    run [opt_bin/"hearth", "serve"]
    keep_alive true
    working_dir HOMEBREW_PREFIX
    log_path var/"log/hearth.log"
    error_log_path var/"log/hearth.log"
    environment_variables PATH: std_service_path_env, HEARTH_SERVICE: "brew"
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/hearth --version")
  end
end
