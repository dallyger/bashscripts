FILE="./test.txt"
if [ -w "$FILE" ] || ( [ ! -f "$FILE" ] && [ -w "/bin" ] ); then
	#remove symbolic links for each command beginning with '_'
	for command in `ls ./_*`; do
		rm "/bin/${command##*/}"
	done
elif [ $UID -ne 0 ]; then
	#restart and ask for sudo rigths
	exec sudo $0 $@
else
	echo "Error: Can't create commands, even with root permissions..."
	exit 1
fi
