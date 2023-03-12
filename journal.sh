EDITOR=vim
journal() {
    mkdir -p ~/journal/`date +%Y`
    $EDITOR ~/journal/`date +%Y`/`date +%m-%d`
}
alias j=journal
