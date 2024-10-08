set -e
set -u
set -o pipefail

# https://github.com/reitermarkus/dotfiles/blob/master/.github/workflows/ci.yml

# Uninstall gems
for gem in $(/usr/bin/gem list --no-versions | grep -v \
                                                    -e 'bigdecimal' \
                                                    -e 'CFPropertyList' \
                                                    -e 'cmath' \
                                                    -e 'csv' \
                                                    -e 'date' \
                                                    -e 'dbm' \
                                                    -e 'did_you_mean' \
                                                    -e 'e2mmap' \
                                                    -e 'etc' \
                                                    -e 'fcntl' \
                                                    -e 'fiddle' \
                                                    -e 'fileutils' \
                                                    -e 'forwardable' \
                                                    -e 'io-console' \
                                                    -e 'ipaddr' \
                                                    -e 'irb' \
                                                    -e 'json' \
                                                    -e 'libxml-ruby' \
                                                    -e 'logger' \
                                                    -e 'matrix' \
                                                    -e 'minitest' \
                                                    -e 'mutex_m' \
                                                    -e 'net-telnet' \
                                                    -e 'nokogiri' \
                                                    -e 'openssl' \
                                                    -e 'ostruct' \
                                                    -e 'power_assert' \
                                                    -e 'prime' \
                                                    -e 'psych' \
                                                    -e 'rake' \
                                                    -e 'rexml' \
                                                    -e 'rdoc' \
                                                    -e 'rss' \
                                                    -e 'scanf' \
                                                    -e 'shell' \
                                                    -e 'sqlite3' \
                                                    -e 'stringio' \
                                                    -e 'strscan' \
                                                    -e 'sync' \
                                                    -e 'test-unit' \
                                                    -e 'thwait' \
                                                    -e 'tracer' \
                                                    -e 'webrick' \
                                                    -e 'xmlrpc' \
                                                    -e 'zlib' \
); do
  sudo /usr/bin/gem uninstall --force --all --ignore-dependencies --executables "$gem"
done

# Uninstall Homebrew
brew update
sudo rm -rf /usr/local/miniconda &
rm -rf /usr/local/lib/node_modules &
rm -f /usr/local/bin/terminal-notifier
rm -f /usr/local/bin/change_hostname.sh
rm -f /usr/local/bin/azcopy

if which brew &>/dev/null; then
  # eval "$(brew list --formula | xargs -I% echo 'brew uninstall --formula --force --ignore-dependencies "%" &')"
  # eval "$(brew list --cask | xargs -I% echo '{ brew uninstall --cask --force "%"; brew uninstall --cask --zap --force "%"; } &')"
  brew uninstall --cask --zap --force adoptopenjdk/openjdk/adoptopenjdk8 &
  brew uninstall --cask --zap --force dotnet &
  brew uninstall --cask --zap --force firefox &
  brew uninstall --cask --zap --force julia &
  brew uninstall --cask --zap --force mono-mdk &
  brew uninstall --cask --zap --force xamarin-android &
  brew uninstall --cask --zap --force xamarin-ios &
  brew uninstall --cask --zap --force xamarin-mac &
  brew uninstall --cask --zap --force visual-studio &
  wait
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" -- --force
fi

# Delete broken symlinks
for exe in /usr/local/bin/*; do
  if [[ -L "$exe" ]] && ! [[ -e "$exe" ]]; then
    rm "$exe"
  fi
done

# Delete leftover applications
sudo rm -rf '/Applications/Google Chrome for Testing.app' &
sudo rm -rf '/Applications/Python 2.7' &
sudo rm -rf '/Applications/Python 3.11' &
sudo rm -rf '/Applications/Visual Studio 2019.app' &
wait

ls -al /Applications /Applications/Utilities

# Clean user directory
for trash in ~/.DS_Store \
            ~/.Trash/* \
            ~/.aliyun \
            ~/.android \
            ~/.azcopy \
            ~/.azure \
            ~/.bash_history \
            ~/.bash_profile \
            ~/.bash_sessions \
            ~/.bashrc \
            ~/.cabal \
            ~/.cache \
            ~/.cargo \
            ~/.cocoapods \
            ~/.composer \
            ~/.conda \
            ~/.config \
            ~/.dotnet \
            ~/.fastlane \
            ~/.gem \
            ~/.ghcup \
            ~/.gitconfig \
            ~/.gradle \
            ~/.local \
            ~/.m2 \
            ~/.mono \
            ~/.npm \
            ~/.npmrc \
            ~/.nvm \
            ~/.oracle_jre_usage \
            ~/.packer.d \
            ~/.rustup \
            ~/.sh_history \
            ~/.ssh \
            ~/.subversion \
            ~/.sqlite_history \
            ~/.vcpkg \
            ~/.viminfo \
            ~/.wget-hsts \
            ~/.yarn \
            ~/Library/Caches/Homebrew \
            ~/Microsoft \
            ~/hostedtoolcache \
            ~/*.txt; do
  if [[ -e "$trash" ]]; then
    mv "$trash" /tmp/trash/
  fi
done
