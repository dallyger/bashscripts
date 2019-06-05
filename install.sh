FILE="./test.txt"
if [ -w "$FILE" ] || ( [ ! -f "$FILE" ] && [ -w "/bin" ] ); then
	SCRIPTDIR=$PWD
	cd /bin
	#create symbolic links for each command
	ln --symbolic -T $SCRIPTDIR/_ls _ls
	ln --symbolic -T $SCRIPTDIR/_edit _edit
	ln --symbolic -T $SCRIPTDIR/_watchls _watchls
	ln --symbolic -T $SCRIPTDIR/_convert _convert
	ln --symbolic -T $SCRIPTDIR/_create-qcow2 _create-qcow2
elif [ $UID -ne 0 ]; then
	#restart and ask for sudo rigths
	exec sudo $0 $@
else
	echo "Error: Can't create commands, even with root permissions..."
	exit 1
fi
