sh "$(curl -sfFA https://raw.githubusercontent.com/ohmyzsh/master/install.sh)"

echo "\n\n" >> ~/.zshrc
cat ./aliases.zsh >> ~/.zshrc
