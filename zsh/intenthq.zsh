# eval "$(direnv hook zsh)"
#PATHS
export PATH="$HOME/git/hello/local-env/bin:$HOME/git/infrastructure/scripts/:$PATH"
export PATH="/usr/local/opt/python@3.9/bin:$PATH"
export JEP_PATH="/usr/local/lib/python3.9/site-packages/jep/"
export PATH="/Users/driosalido/git/config-validations:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

#GITHUB TOKEN
export GITHUB_TOKEN=`security find-generic-password -s github-token-intenthq -a driosalido -w`
#export GITHUB_TOKEN="$(op read op://Private/github-token-intenthq/credential)"

#AWS PROFILE
# export AWS_PROFILE=$(cat ~/.aws/active_profile)
export AWS_PROFILE=opal
export AWS_DEFAULT_PROFILE=opal

#TERRAFORM
export TF_PLUGIN_CACHE_DIR="/Users/driosalido/.terraform.d/plugin-cache"

