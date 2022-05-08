# zsh4humans additional config
zstyle ':z4h:ssh:vm*' enable 'yes'

# Exports
export DOTDROP_PROFILE='fell'
export DOTDROP_NOBANNER=
#export BROWSER=$(which brave)
#export CHROME_EXECUTABLE=$(which brave)

# Path
path=(~/bin /usr/local/bin ~/.local/bin ~/.pub-cache/bin $path)

# Aliases
alias l='ls -lAhtr'
alias parus='paru --skipreview'

# Misc
fvm=".fvm/flutter_sdk/bin"
[[ -d $fvm ]] && alias f="$fvm/flutter" || alias f="flutter"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm