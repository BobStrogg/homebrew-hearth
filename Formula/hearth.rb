class Hearth < Formula
  desc "Web UI for ACP coding agents"
  homepage "https://github.com/BobStrogg/hearth"
  url "https://registry.npmjs.org/hearth-acp/-/hearth-acp-0.4.0.tgz"
  sha256 "b4cdb429d5b0368ab5c97c86415b64aebb8343681db16a50fc3504ecbe775556"
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
