class Hearth < Formula
  desc "Web UI for ACP coding agents"
  homepage "https://github.com/BobStrogg/hearth"
  url "https://registry.npmjs.org/hearth-acp/-/hearth-acp-0.6.0.tgz"
  sha256 "2b3b974b11453cf919523d1f0c67b9426dc8c886a12063a1dde4fee5c5fdb31d"
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
