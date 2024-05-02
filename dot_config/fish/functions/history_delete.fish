# Source: https://jordanelver.co.uk/blog/2020/05/29/history-deleting-helper-for-fish-shell/
function history_delete --description 'Fuzzily delete entries from your history'
  history | fzf | read -l item; and history delete --prefix "$item"
end
