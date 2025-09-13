### Ravenor - TVP based server

#### Compiling

##### Ubuntu 20.04+

Install dependencies using packet manager

`$ sudo apt install git cmake build-essential libluajit-5.1-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libpugixml-dev libcrypto++-dev libfmt-dev libboost-date-time-dev libboost-filesystem-dev libspdlog-dev`

Compile with debug symbols

`$ mkdir build && cd build`

`$ cmake -D CMAKE_BUILD_TYPE=RelWithDebInfo ..`

`$ make -j`nproc`

##### Windows

Install dependencies using vcpkg

`.\vcpkg install --triplet x64-windows boost-iostreams boost-asio boost-system boost-variant boost-lockfree luajit libmariadb pugixml cryptopp fmt spdlog boost-filesystem`

Open the Visual Studio Project, select x64, Release and build