# Connecting to the simulator with ROS / ROS2 on MacOS

You can use the ROS bridge to connect the simulator to ROS1 and ROS2.
The ROS bridge will publish the sensordata from the simulator into ROS topics.
Your autonomous system will be able to publish car-control messages which the ROS bridge will send to the simulator.

Tested ROS distros: Galactic and Humble.

## Requirements

The ROS bridge requires [ROS Galactic or Humble](software-install-instructions.md) as well as 
[LLVM](https://formulae.brew.sh/formula/llvm#default) to be installed.
```bash
brew install llvm
```
In the following make sure you have activated the conda environment for ROS 
Galactic or Humble and that you have the correct ENV variables that are set:
```bash
printenv | grep "ros*" # should at least return ROS_DISTRO, ROS_LOCALHOST, ROS_VERSION, ROS_PYTHON_VERSION
```


## Cloning the repository

**Before you clone, make sure you have git lfs installed!**

Ready? Lets clone the repo into your home directory:
```bash
git clone git@github.com:FS-Driverless/Formula-Student-Driverless-Simulator.git --filter=blob:none --recurse-submodules
```

If you haven't setup your ssh keys, you can clone using https by running the following command:
```bash
git clone https://github.com/FS-Driverless/Formula-Student-Driverless-Simulator.git --filter=blob:none --recurse-submodules
```

**THE REPO HAS TO BE CLONED IN THE HOME DIRECTORY!**. So the repo location should be `$HOME/Formula-Student-Driverless-Simulator`.
Why you ask? Because we couldn't get relative paths in the C++ code to work so now we have hard-coded some paths to the home directory.
I know yes it is ugly but it works. If you are bothered by it I would welcome you to open a pr with a fix.

If this folder already exists as a result of any previous step, move the existing folder out of the way and merge the content afterwards.

If you are on Windows and cloned this repository in a Windows directory, go into the cloned repo and run `git config core.fileMode false` to ignore file mode changes. 
If you want to share the the cloned directory with the Ubuntu WSL system, create a symlink within WSL like so:
```bash
ln -s /mnt/c/Users/developer/Formula-Student-Driverless-Simulator ~/Formula-Student-Driverless-Simulator
```

Now, checkout the version equal to the simulator. 
If you are running for example simulator packaged version v2.1.0, run `git checkout tags/v2.1.0` to get the ROS brige to the same version

## Preparing AirLib

AirLib is the shared code between the ROS wrapper and the AirSim Unreal Engine plugin.
We need to stage the source before we can compile it together with the wrapper.

In a terminal run:
```bash
cd ~/Formula-Student-Driverless-Simulator/AirSim
zsh setup_macos.sh
```

This will download the nessesary libraries required to compile AirLib.
You will only need to run this once.

Everything setup.sh does is also included in build.cmd.

## Building the workspace

```bash
cd ~/Formula-Student-Driverless-Simulator/ros2
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
```

## Launching the ros bridge

The ROS bridge consists of a few nodes to achieve the highest performance and keep the codebase clean.
Everything can be launched using the `fsds_ros_bridge.launch` launchfile.
```bash
cd ros2
source install/setup.bash
ros2 launch fsds_ros_bridge fsds_ros_bridge.launch.py
```

The ROS bridge will read the settings from `~/Formula-Student-Driverless-Simulator/settings.json`.
Make sure this is the same configuration file as the simulator uses.

[Read all about configuring the ROS bridge here.](ros-bridge.md)

## Connecting your autonomous system

The ROS bridge of this simulator had to make use of several custom msgs (for control commands, the groundtruth track, etc). 
These messages are defined in a ROS package called `fs_msgs` which is located in a separate, light [repository](https://github.com/FS-Driverless/fs_msgs). 
To implement publishers and subscibers for these messages types in your autonomous pipeline, you will have to add the `fs_msgs` repository as a submodule in your codebase (inside de `src` directory of an existing **catkin workspace** as done in this repository) or clone it and build it somewhere else in your system.

Now, all that is left to do is subscribe to the following topics to receive sensordata

- `/fsds/gps`
- `/fsds/imu`
- `/fsds/camera/CAMERA_NAME`
- `/fsds/camera/CAMERA_NAME/camera_info`
- `/fsds/lidar/LIDAR_NAME`
- `/fsds/testing_only/odom`
- `/fsds/testing_only/track`
- `/fsds/testing_only/extra_info`

and publish to the following topic `/fsds/control_command` to publish the vehicle control setpoints.

## Multiple computers
If you have 2 computer, you can run the simulator and your autonomous system each on their own computer.
But where does the ROS-bridge run? You have 2 options:

1. Run the ROS bridge on the same computer as your autonomous system.
   The ROS bridge will connect to the simulator using a TCP connection to send control commands and receive sensor data.
   The ROS bridge will use local ROS topics to communicate with the autonomous system.
   Use the `host` argument in the `fsds_ros_bridge.launch` file to tell the ROS bridge where the simulator is at.
   Ensure firewall rules allow the ROS bridge to connect to the simulator on port 41451.

2. Run the ROS bridge on the same computer as the simulator.
   Your autonomous system would use ROS multi-computer networking to publish/subscribe to FSDS topics.
   Follow [this tutorial](http://wiki.ros.org/ROS/NetworkSetup) and [this one](http://wiki.ros.org/ROS/Tutorials/ MultipleMachines) on the ROS Wiki to learn how to do this.

If you have never worked with a multi-computer ROS networking before, option 1 is probably the way to go.

If you are running the simulator on Windows, option 1 is the easiest as well.
You can run the ROS bridge within WSL and use option 2 but there are some constraints, see below.

