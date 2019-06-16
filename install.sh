FILE="./test.txt"
if [ -w "$FILE" ] || ( [ ! -f "$FILE" ] && [ -w "/bin" ] ); then
	#create symbolic links for each command beginning with '_'
	for command in `ls $PWD/_*`; do
		chmod a+x $command
		ln --symbolic -T $command "/bin/${command##*/}" >/dev/null 2>&1 && echo "added ${command##*/}"
	done
elif [ $UID -ne 0 ]; then
	#restart and ask for sudo rigths
	exec sudo $0 $@
else
	echo "Error: Can't create commands, even with root permissions..."
	exit 1
fi
