class Hearth < Formula
  desc "Web UI for ACP coding agents"
  homepage "https://github.com/BobStrogg/hearth"
  url "https://registry.npmjs.org/hearth-acp/-/hearth-acp-0.5.13.tgz"
  sha256 "e47cead4c4bf217625ab00204f96040fa79c28fd2a617bec9f478388d9a71df9"
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
