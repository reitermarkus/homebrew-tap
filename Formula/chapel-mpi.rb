class ChapelMpi < Formula
  desc "Emerging programming language designed for parallel computing"
  homepage "https://chapel-lang.org/"
  url "https://github.com/chapel-lang/chapel/releases/download/1.20.0/chapel-1.20.0.tar.gz"
  sha256 "08bc86df13e4ad56d0447f52628b0f8e36b0476db4e19a90eeb2bd5f260baece"
  revision 1 unless OS.mac?

  bottle do
    sha256 "057e5c71d41f2ff71434f446ffd8f9aa932b553612313729d4651fdc58233650" => :catalina
    sha256 "8fcaebe6a3c465a29a66e691581b88b2fc9960726e1f94b3f21aa0f53c424044" => :mojave
    sha256 "4aee5a0ddf8a44897a2f03c458a8e7e70d76b07f04024119ed482fbc06cf330c" => :high_sierra
    sha256 "34a5eac538de8fb6ac632109a0154e1d14ff8551bc8f4fec8df8359568697338" => :sierra
  end

  depends_on "python@2" unless OS.mac?
  depends_on "open-mpi"

  def install
    prefix.install_metafiles

    libexec.install_symlink prefix/"LICENSE"
    libexec.install_symlink prefix/"COPYRIGHT"

    libexec.install Dir["*"]
    # Chapel uses this ENV to work out where to install.
    ENV["CHPL_HOME"] = libexec
    # This is for mason
    ENV["CHPL_REGEXP"] = "re2"

    # Must be built from within CHPL_HOME to prevent build bugs.
    # https://github.com/Homebrew/legacy-homebrew/pull/35166
    cd libexec do
      system "make"
      with_env(
        "CHPL_LAUNCHER"       => "gasnetrun_mpi",
        "CHPL_COMM"           => "gasnet",
        "CHPL_COMM_SUBSTRATE" => "mpi",
      ) do
        system "make"
      end
      system "make", "chpldoc"
      system "make", "test-venv"
      system "make", "mason"
      system "make", "cleanall"
    end

    # Install chpl and other binaries (e.g. chpldoc) into bin/ as exec scripts.
    platform = if OS.mac?
      "darwin-x86_64"
    else
      Hardware::CPU.is_64_bit? ? "linux64-x86_64" : "linux-x86_64"
    end
    bin.install Dir[libexec/"bin/#{platform}/*"]
    bin.env_script_all_files libexec/"bin/#{platform}/", CHPL_HOME: ENV["CHPL_HOME"]
    man1.install_symlink Dir["#{libexec}/man/man1/*.1"]
  end

  test do
    # Fix [Fail] chpl not found. Make sure it available in the current PATH.
    # Makefile:203: recipe for target 'check' failed
    ENV.prepend_path "PATH", bin unless OS.mac?

    ENV["CHPL_HOME"] = libexec
    cd libexec do
      system "make", "check"
    end
  end
end
