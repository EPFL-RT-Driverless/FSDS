# Required software installation instructions

This page helps you install software required for running and developing the simulator.
You probably only need parts of it.
The other guides in this documentation will tell you what you need.

## Install Unreal Engine (Windows)
Ensure your windows user has no special characters! 
If it contains special characters there will be a conflict with your Win10 user folder name, and mess up unreal engine reading the directory path.

Go to [unrealengine.com](https://www.unrealengine.com/) and download the epic installer.
You need an account for this.
Install the epic installer.

Launch the epic installer and install Unreal Engine 4.27

## Install Unreal Engine (Ubuntu)
This project uses Unreal Engine 4.27.
Before you can use unreal engine on Ubuntu, you must register at [unrealengine.com](https://www.unrealengine.com/) and get access to the UnrealEngine github repo.

After you get access, clone the repo and build it:
```
git clone --depth=1 -b 4.27 https://github.com/EpicGames/UnrealEngine.git
cd UnrealEngine	
./Setup.sh && ./GenerateProjectFiles.sh && make	
```

Run it by executing `./Engine/Binaries/Linux/UE4Editor`.
The Unreal Editor should now open without errors. 

## Install visual studio 2019 (Windows)
[Download visual studio 2019 (community edition)](https://visualstudio.microsoft.com/vs/)

During installation, choose the following components:

* Desktop development with C++
* Game development with C++
* Linux development with C++

At 'Invidual Components select:

* C++ CMake tools for Windows
* Windows 10 SDK 10.0.18.362.0
* .NET Framework 4.7 SDK

## Windows Subsystem for Linux (WSL)

In case you want to run the ros bridge on Windows, you will need Windows Subsystem for Linux

1. [Enable Windows Subsystem for Linux 1 (WSL1)](https://docs.microsoft.com/en-us/windows/wsl/install-win10). No need to update to version 2.
2. Install ubuntu 18.04 LTS.
3. If you are on windows server, enable windows susbsystem for linux in the server manager and [install ubuntu](https://docs.microsoft.com/en-us/windows/wsl/install-on-server#download-a-linux-distribution).


## Install ROS Melodic/Noetic/Galactic (Ubuntu / WSL)

Follow [the guide on their website](http://wiki.ros.org/ROS/Installation) 

And add the following line to end of your `~/.bashrc` file:
```
source /opt/ros/melodic/setup.bash
source ~/Formula-Student-Driverless-Simulator/ros/devel/setup.bash
```

Be sure to replace `melodic` with your specific version

## Install ROS Galactic/Humble (MacOS)

You can install it with conda (via miniforge) and [robostack](https://robostack.github.io).
```
# if you don't have miniforge yet, install it first with brew
brew install miniforge
conda init zsh 
# restart your shell

# choose your distro: galactic or humble
export DISTRO="galactic"

# if you don't have mamba yet, install it first:
conda install mamba -c conda-forge

# now create a new environment
mamba create -n ros_$DISTRO ros-$DISTRO-desktop python=3.9 -c robostack-experimental -c conda-forge --no-channel-priority --override-channels
conda activate ros_$DISTRO

# optionally, install some compiler packages if you want to e.g. build packages in a colcon_ws:
mamba install compilers cmake pkg-config make ninja colcon-common-extensions

# reload environment to activate required scripts before running anything
conda deactivate
conda activate ros_galactic

# if you want to use rosdep, also do:
mamba install rosdep
rosdep init  # note: do not use sudo!
rosdep update
```

## Gui applications from WSL (Xming)
By default, if you are running Windows Subsystem for Linux with Ubuntu, you can't run gui applications.
This is super annoying if you want to use rqt applicatoins like rviz or rqt_plot.
It is easy to get this working though!
Just install [Xming](https://sourceforge.net/projects/xming/) on windows, and run it.
Next, go into the Ubuntu terminal and run `export DISPLAY=:0`.
Now you can run any all them gui apps!
You can even add `export DISPLAY=:0` to your `~/.bashrc` to always be able to use gui apps without having to manually run export.
