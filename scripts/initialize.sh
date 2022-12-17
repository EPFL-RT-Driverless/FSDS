#! /bin/bash

set +x

dir=~/Formula-Student-Driverless-Simulator
file=~/Formula-Student-Driverless-Simulator/settings.json

if [ -d $dir ];
then
    echo "Folder $dir already exists"
else
    echo "Creating $dir "
    mkdir $dir
fi

if [ -f $file ];
then
    _prompt="Settings file already exists, do you want to override it [y/n] ?"

    # Loop forever until the user enters a valid response (Y/N or Yes/No).
    while true; do
        read -r -p "$_prompt " _response
        case "$_response" in
            [Yy][Ee][Ss]|[Yy]) # Yes or Y (case-insensitive).
            curl -O https://raw.githubusercontent.com/EPFL-RT-Driverless/FSDS/master/settings.json
            echo "Creating settings files"
            mv settings.json $dir
            break
            ;;
            [Nn][Oo]|[Nn])  # No or N.
            echo "Previous settings file kept, setup finished !"
            exit 0
            ;;
            *) # Anything else (including a blank) is invalid.
            ;;
        esac
    done
else
    echo "Creating settings files"
    curl -O https://raw.githubusercontent.com/EPFL-RT-Driverless/FSDS/master/settings.json
    echo "Creating settings files"
    mv settings.json $dir
fi

echo "Setup finished !"