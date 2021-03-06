require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-2.11.26.tgz"
  sha256 "1aea15977411f85c9d20e7345c9d2a1e43bee9f8c55f7b4b0033c24f0a010b61"
  head "https://github.com/netlify/cli.git"

  bottle do
    sha256 "94a25e576dcac7456eca48359c6260e2d60d254112ca49ddd6f067aeb82aad94" => :mojave
    sha256 "5cfb2341339979de3d4e45291d267df90d4fc2b32498ab94903d1c9c21d6bcf4" => :high_sierra
    sha256 "26c93dd5d1648df61dbb5119470776837eeda5c89a391e5b5b5bc76ecfea1dd1" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
