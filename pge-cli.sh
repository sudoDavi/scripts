#!/bin/bash
if [ "$1" == "help" -o "$1" == "-h" -o -z "$1" ]; then
	printf "pge COMMAND <arguments>
List of Commands:
	new: creates a new project
	USAGE: pge new <project_name> <use_extensions>
	ARGUMENTS:
		project_name: if left empty will create a new project
		in a new folder called pgeProject.
		use_extensions: BOOL to determine if you want to use
		the pge extensions, defaults to FALSE.

	help, -h: shows this message and exit.\n";
	exit 0;
elif [ "$1" == "new" ]; then
	USE_EXTENSIONS=false;
	SECOND_PARAMETER_IS_BOOL=false;
	if [ "$2" == "true" -o "$2" == "TRUE" ]; then
		USE_EXTENSIONS=true;
		SECOND_PARAMETER_IS_BOOL=true;
	elif [ "$3" == "true" -o "$3" == "TRUE" ]; then
		USE_EXTENSIONS=true;
	fi;

	if [ -z "$2" -o $SECOND_PARAMETER_IS_BOOL == true ]; then
		git clone https://github.com/OneLoneCoder/olcPixelGameEngine.git pgeProject;
		cd pgeProject;
		echo "Created new project";
		echo "Removing unnecessary files";
		if [ $SECOND_PARAMETER_IS_BOOL == true ]; then
			echo "Keeping Extensions folder";
			rm -rf Contibutions/ README.md Videos/ WikiPics/;
		else
			rm -rf Contibutions/ README.md Videos/ WikiPics/ Extensions/;
		fi;
		echo "Done, you can start editing now";
		exit 0;
	fi;
	git clone https://github.com/OneLoneCoder/olcPixelGameEngine.git $2;
	cd $2;
	echo "Created new project";
	echo "Removing unnecessary files";
	if [ $USE_EXTENSIONS == true ]; then
		echo "Keeping Extensions folder";
		rm -rf Contibutions/ README.md Videos/ WikiPics/;
	else
		rm -rf Contibutions/ README.md Videos/ WikiPics/ Extensions/;
	fi;
	echo "Done, you can now start editing";
	exit 0;
fi;
