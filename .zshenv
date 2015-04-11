####################################
# 環境変数
####################################
# 重複パスを登録しない
typeset -U path cdpath fpath manpath

# homebrewのベースパス
BREWPREFIX=$(brew --prefix)

path=(
	$HOME/.rbenv/bin(N-/)
	$HOME/.nodebrew/current/bin(N-/)
	/Applications/android/android-sdk-macosx/platform-tools(N-/)
	$path
)

fpath=(
	$BREWPREFIX/share/zsh-completions(N-/)
	$fpath
)

# rbenv用
if builtin command -v rbenv > /dev/null; then
  eval "$(rbenv init - zsh)"
fi