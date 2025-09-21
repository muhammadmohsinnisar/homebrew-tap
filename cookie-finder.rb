class CookieFinder < Formula
  desc "Find the most active cookies from log files for a specific date"
  homepage "https://github.com/muhammadmohsinnisar/cookieFinder"
  url "https://github.com/muhammadmohsinnisar/cookieFinder/archive/v1.0.0.tar.gz"
  sha256 "41c967ea257f14d88918dc2a581ffde27e9641d2e11db93fc2c6e8720279844d"
  license "MIT"

  depends_on "openjdk@17"

  def install
    # Build the project
    system "./gradlew", "clean", "jar"
    
    # Install the JAR file
    libexec.install "build/libs/cookieFinder-1.0-SNAPSHOT.jar"
    
    # Create a wrapper script
    (bin/"cookieFinder").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@17"].opt_bin}/java" -jar "#{libexec}/cookieFinder-1.0-SNAPSHOT.jar" "$@"
    EOS
  end

  test do
    # Test with sample data
    system "#{bin}/cookieFinder", "-f", "#{libexec}/../src/main/resources/cookie_log_test.csv", "-d", "2018-12-09"
  end
end
