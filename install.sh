FILE="./test.txt"
if [ -w "$FILE" ] || ( [ ! -f "$FILE" ] && [ -w "/bin" ] ); then
	SCRIPTDIR=$PWD
	cd /bin
	#create symbolic links for each command beginning with '_'
	for entry in `ls $SCRIPTDIR/_*`; do
		chmod a+x $entry
		ln --symbolic -T $entry "${entry##*/}" >/dev/null 2>&1 && echo "added ${entry##*/}"
	done
elif [ $UID -ne 0 ]; then
	#restart and ask for sudo rigths
	exec sudo $0 $@
else
	echo "Error: Can't create commands, even with root permissions..."
	exit 1
fi
