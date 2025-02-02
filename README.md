# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/flag-checkered.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Formula Student Driverless Simulation

![banner](docs/images/banner.png)


## Documentation
For installation and more information about the ROS and python interface, [check the documentation](https://fs-driverless.github.io/Formula-Student-Driverless-Simulator/)

## More information

Some more information about the project can be found [here](https://github.com/EPFL-RT-Driverless/FSDS/tree/master/docs).

# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/regular/circle-play.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Run the simulator

- Download the latest released version according to your OS

- For Windows :
    ```
    .\initialize.cmd
    ```
    - You can then move and rename the folder however you want. Make sure you don't only move the .exe file
    - Start `FDSD.exe`

- For Linux :
    ```
    chmod +x initialize.sh && chmod +x FSDS.sh
    ./initialize.sh
    ```
    - You can then move the folder and rename it however you want but don't modify the subfolders nor the files
    - Run the simulator :

    ```
    ./FSDS.sh
    ```


- For MacOS :
    ```
    chmod +x initialize.sh
    ./initialise.sh
    ```
    - You can then move the `FDSD.app` wherever you want
    - Start `FDSD.app`




# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/brands/windows.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Windows Installation 

### Prerequisites
- [Unreal Engine 4.27](https://www.unrealengine.com/en-US/download)
- [Microsoft Visual Studio 2019](https://visualstudio.microsoft.com/downloads/)
- Make sure that you installed the **.NET desktop development** and **Desktop development with C++** workloads in VS 2019

    ```
    git clone https://github.com/EPFL-RT-Driverless/FSDS.git
    ```
- Make sure to have git-lfs installed and run `git lfs install` and `git lfs pull` in the FSDS folder
- Open the Developer Command Prompt for VS 2019
- Navigate to the FSDS/AirSim folder

    ```
    build.cmd
    ```

- Open UE4Editor 4.27 and open UE4Project/FSOnline.uproject
- It might show an error like 'This project was made with a different version of the Unreal Engine'. In that case select `more options` and `skip conversion`.
- When asked to rebuild the 'Blocks' and 'AirSim' modules, choose 'Yes'. This is the step where the plugin part of AirSim is compiled.
- Enjoy the simulator!

# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/brands/apple.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Mac Installation 
- [Unreal Engine 4.27](https://www.unrealengine.com/en-US/download)

    ```
    git clone https://github.com/EPFL-RT-Driverless/FSDS.git
    cd FSDS
    ```
- Make sure to have git-lfs installed and run `git lfs install` and `git lfs pull` in the FSDS folder

    ```
    cd AirSim
    ./setup.sh && ./build.sh
    ```
- Open UE4Editor 4.27 and open UE4Project/FSOnline.uproject
- It might show an error like 'This project was made with a different version of the Unreal Engine'. In that case select `more options` and `skip conversion`.
- When asked to rebuild the 'Blocks' and 'AirSim' modules, choose 'Yes'. This is the step where the plugin part of AirSim is compiled.
- Enjoy the simulator!

# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/brands/ubuntu.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Ubuntu Installation
- Unfortunatly, the forked repository doesn't build on Linux. If you want to build the executable for Linux, you need to package it with the cross-compilation method. You won't be able to run the UE4Editor on Linux.
- Complete all the steps of the [Windows Installation](https://github.com/EPFL-RT-Driverless/FSDS#Windows-Installation) section.
- Install the cross-compilation toolchain for Windows. You can find the instructions [here](https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/Linux/GettingStarted/). Be sure to download the toolchain for the version 4.27 of Unreal Engine.
- Some libs need to be installed and compiled for linux fortunately, we did it for you. Just run the following commands:
    ```
    cd FSDS/scripts
    cp librpc.a UE4Project/Plugins/AirSim/Source/AirLib/deps/rpclib/lib
    ```
- Right click on FSDS/UE4Project/FSOnline.uproject and select `Generate Visual Studio project files` 
- Open UE4Editor 4.27 and open FSDS/UE4Project/FSOnline.uproject
- You can now build the project for Linux. To do so, go to  `File > Package Project > Build Configuration > Development` and then `File > Package Project > Linux > Linux`.
- Enjoy the simulator!

# <img src="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/quote-left.svg" width=18px style="webkit-filter: invert(0.5); filter: invert(0.5); background-color: transparent;"> Credits

This project is forked from [Formula Student Driverless Simulator](https://github.com/FS-Driverless/Formula-Student-Driverless-Simulator). Based on [AirSim](https://github.com/microsoft/AirSim).