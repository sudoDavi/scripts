#!/bin/bash
if [ "$1" == "new" ]; then
    if [ -z $2 ]; then
      printf "Missing project name\nType clockwork help for commands";
      exit 22;
    fi;
    if [[ -n $3 && -n $4 ]]; then
      dotnet new sln -o $4;
      wait; dotnet new mgnetstandard -n $2 -o $4;
      wait; dotnet sln add $4/$2/$2.csproj;
      exit 0;
    fi;
    mkdir $2 && cd $2;
    dotnet new sln;
    wait; dotnet new mgnetstandard -n $2;
    wait; dotnet sln add $2/$2.csproj;
    wait; dotnet restore;
    exit 0;
elif [ -z $1 ]; then
  echo -e "No commands, type clockwork help for help"
  exit 0;
elif [ "$1" == "help" -o "$1" == "-h" ]; then
  printf "\nclockwork COMMAND <arguments> [OPTION]\n";
  printf "List of commands:\n
  new : creates a new project withouth a target platform\n
    USAGE: clockwork new 'PROJECT_NAME' [OPTION]\n
    OPTIONS:
      -o : creates project in the indicated path\n
  target, -t : adds  a target platform to the project\n
    USAGE: clockwork target 'TARGET_TEMPLATE' 'FOLDER_NAME'\n
    TARGET_TEMPLATE's are available at the MonoGame docs\n
  help, -h : shows this message\n";
  exit 0;
elif [ "$1" == "target" -o "$1" == "-t" ]; then
    if [[ -z $2 || -z $3 ]]; then
      printf "\nMissing target template or folder name\nType clockwork help for commands\n";
      exit 22;
    fi;
  dotnet new $2 -n $3;
  wait; dotnet sln add $3/$3.csproj || printf "\n\n*****Did you execute this in the same folder as the Project?*****\n\n";
  wait; cd $3; printf "\nEnter the name of the project, to add a reference to the target .csproj file:\n";
  read PROJNAME;
  dotnet add reference ../$PROJNAME/$PROJNAME.csproj || printf "\n\n*****Did you execute this in the same folder as the Project?*****\n\n"
  rm -rf Content;
  rm Game1.cs;
  printf "All you need to do now is change the 'Content\\Content.mgcb' with ..\\$PROJNAME\\Content\\Content.mgcb in $3.csproj"
  exit 0;
fi
