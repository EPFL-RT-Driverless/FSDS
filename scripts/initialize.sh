#! /bin/bash

set +x

dir=~/Formula-Student-Driverless-Simulator
file=~/Formula-Student-Driverless-Simulator/settings.json

if [ -d $dir ];
then
    echo "Folder already exists"
else
    echo "Creating folder"
    mkdir ~/Formula-Student-Driverless-Simulator
fi

if [ -f $file ];
then
    echo "Settings file already exists"
else
    echo "Creating settings files"
    cp ./settings.json ~/Formula-Student-Driverless-Simulator
fi

echo "Setup finished !"