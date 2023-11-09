#alias lc='colorls -la'
#alias ls="colorls --sd -A"
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias acki='ack --ignore-directory=.terragrunt-cache --ignore-directory=build'
alias cat='bat --style=plain'
alias j=z
alias ap='opal aws:identity | jq ".Arn" 2>/dev/null | cut -d ":" -f 5,6'
