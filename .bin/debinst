#!/bin/bash
## UNLICENSE file for license information

# Misc checks
if [ $(id -u) -ne 0 ]
then
	echo "This script needs root to work." # It really does. We're installing packages.
	exit 1
fi

depcheck () {
		if ! command -v "$1" >/dev/null 2>&1
		then
			echo "I require \`"$1"\` but it's not installed."
			echo "Install the \`"${@: -1}"\` package."
			# ${@: -1} is bashism for "last argument passed"
			# This is done instead of $2 to avoid writing "depcheck tar tar"
		        # I suck at being evil, I know.	
exit 1 
fi
}

depcheck ar binutils
depcheck tar xz
depcheck basename coreutils

_list_dir="/var/debinst/lists"
if [ ! -d $_list_dir ]; then
	mkdir -p $_list_dir
fi

_log_dir="/var/debinst/logs"
if [ ! -d $_log_dir ]; then
	mkdir -p $_list_dir
fi

_usage(){
	echo 'Usage: debinst [install|remove|list] {PACKAGE.deb}'
}

# Install deb package
_pkg_install(){
	_package=$(basename $1)
	if ! echo $_package | egrep -q "\.deb$"; then
		echo "Not a valid .deb package?"
		exit 1;
	fi
	t=temp-$_package
	if [ -f $_list_dir/$_package.list ]; then
		echo "Package already installed?"
		exit 1
	fi
	echo "$t $_package"
	mkdir -p $t
	cp $1 $t
	cd $t
	ar x $_package
	rm $_package
	tar xf data.tar* 2>/dev/null

	touch $_list_dir/$_package.list
	for d in */ ; do
		find $d -mindepth 2 >> $_list_dir/$_package.list
		cp -r $d / 2> /dev/null
	done
	echo "Package extracted. Now running post-install script"
	tar xf control.tar*
	if [ -f postinst ]
		then
		bash postinst configure > $_list_dir/$_package.postinst.log 2>&1 && echo "Post-install completed succesfully." || echo "Post-install script returned error. The package may or may not work. See postinst.log"
	fi  
	if [[ $(file $_list_dir/$_package.postinst.log) =~ "empty" ]]; then rm -f $_list_dir/$_package.postinst.log; fi
	if [ ! -f postinst ]
		then
		echo "This package does not have a post-install script."
	fi
	echo "Cleaning up.."
	cd ..
	rm -rf $t
	echo "Done! A list of copied files has been created in $n.list for eventual deletion." 
	echo "(Warning! This may include files not safe for deletion. Always check.)"
	exit 0
}

_pkg_remove(){
	_package=$1
	if ls $_list_dir/$1*.list 2> /dev/null > /dev/null; then
		find $_list_dir -type f -name "$1*.list" > /tmp/debinst.remove
		basename $(cat /tmp/debinst.remove) | sed 's/\..*//'
		echo -n "Really remove package(s) [y/n]?: "
		read a;
		case "$a" in
			y) cat /tmp/debinst.remove | xargs cat | sed 's/^\(.\)/\/\1/g' | xargs rm -rf
				cat /tmp/debinst.remove | xargs rm -f
				rm /tmp/debinst.remove;;
			*) exit 1;;
		esac
	else
		echo "No installed .deb packages with specified name."
		rm /tmp/debinst.remove
		exit 1
	fi
}

# Arguments check
_arg_check(){
if [ $# -eq 0 ]
	then
		echo "No arguments supplied."
		_usage
		exit 1
	elif [ $# -ne 1 ]
	then
		echo "Too many arguments supplied"
		_usage
		exit 1
fi
}

# All set! Start working

case "$1" in
	"install") _pkg_install $2;;
	"remove") _pkg_remove $2;;
	"list") if ls $_list_dir/*.list 2> /dev/null > /dev/null; then
	 	find $_list_dir -type f | xargs basename | sed 's/\..*//'
	 else
	 	echo "No installed .deb packages."
	 fi;;
	*) _arg_check;;
esac
