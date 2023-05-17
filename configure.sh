#!/bin/bash
set -eou pipefail

source ./script/prompt

brewInstall () {
    # Install brew
    if test ! $(which brew); then
    # Install the correct homebrew for each OS type
        if test "$(uname)" = "Darwin"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
            success 'brew installed'
        elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
            success 'brew installed'
        fi
    else
        info 'brew is already installed'
    fi
}

brewUpdate () {
    brew update
    success 'brew updated'
}

gitInstall() {
    #Install git
    if test $(which git); then
        info "git already installed"
    else 
        brew install git
        success 'git installed'
    fi
}

zshInstall () {
    # zsh install
    # todo add in check for macOS 10.15 since zsh is default
    if test $(which zsh); then
        info "zsh already installed..."
    else
        brew install zsh zsh-completions
        success 'zsh and zsh-completions installed'
    fi
}

ohmyzshInstall () {
    # oh-my-zsh install
    if [ -d ~/.oh-my-zsh/ ] ; then
    info 'oh-my-zsh is already installed...'
    read -p "Would you like to update oh-my-zsh now? y/n " -n 1 -r
    echo ''
        if [[ $REPLY =~ ^[Yy]$ ]] ; then
        cd ~/.oh-my-zsh && git pull
            if [[ $? -eq 0 ]]
            then
                success "Update complete..." && cd
            else
                fail "Update not complete..." >&2 cd
            fi
        fi
    else
    echo "oh-my-zsh not found, now installing oh-my-zsh..."
    echo ''
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    success 'oh-my-zsh installed'
    fi
}

ohmyzshPluginInstall () {
    # oh-my-zsh plugin install
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
        info 'zsh-completions already installed'
    else
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && success 'zsh-completions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        info 'zsh-autosuggestions already installed'
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && success 'zsh-autosuggestions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        info 'zsh-syntax-highlighting already installed'
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && success 'zsh-syntax-highlighting installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/fzf-zsh-plugin" ]; then
        info 'fzf-zsh-plugin already installed'
    else
        git clone https://github.com/unixorn/fzf-zsh-plugin.git ~/.oh-my-zsh/custom/plugins/fzf-zsh-plugins && success 'fzf-zsh-plugin installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-z" ]; then
        info "zsh-z already exists..."
    else
        git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z
        success 'zsh-z installed'
    fi    
}

pl10kInstall () {
    # powerlevel10k install
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        info 'powerlevel10k already installed'
    else
        echo "Now installing powerlevel10k..."
        git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && success 'powerlevel10k installed'
    fi
}

configureGitCompletion () {
    GIT_VERSION=`git --version | awk '{print $3}'`
    URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
    success "git-completion for $GIT_VERSION downloaded"
    if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
        echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
        fail 'git completion download failed'
    fi
}

# brew setup
brewInstall
brewUpdate
gitInstall

# zsh setup
zshInstall
configureGitCompletion


# oh my zsh setup
ohmyzshInstall
ohmyzshPluginInstall
pl10kInstall

echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
    echo ''
    if [[ $? -eq 0 ]];then
        echo "Successfully configured your environment dotfiles..."
    else
        echo "dotfiles were not applied successfully..." >&2
    fi
echo ''
