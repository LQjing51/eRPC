# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/qijing/eRPC

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/qijing/eRPC

# Include any dependencies generated for this target.
include CMakeFiles/erpc_dpdk_daemon.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/erpc_dpdk_daemon.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/erpc_dpdk_daemon.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/erpc_dpdk_daemon.dir/flags.make

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/flags.make
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o: src/transport_impl/dpdk/dpdk_daemon.cc
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o -MF CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o.d -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o -c /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_daemon.cc

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_daemon.cc > CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.i

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_daemon.cc -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.s

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/flags.make
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o: src/transport_impl/dpdk/dpdk_externs.cc
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o -MF CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o.d -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o -c /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_externs.cc

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_externs.cc > CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.i

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_externs.cc -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.s

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/flags.make
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o: src/transport_impl/dpdk/dpdk_init.cc
CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o: CMakeFiles/erpc_dpdk_daemon.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o -MF CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o.d -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o -c /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_init.cc

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_init.cc > CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.i

CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/qijing/eRPC/src/transport_impl/dpdk/dpdk_init.cc -o CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.s

# Object files for target erpc_dpdk_daemon
erpc_dpdk_daemon_OBJECTS = \
"CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o" \
"CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o" \
"CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o"

# External object files for target erpc_dpdk_daemon
erpc_dpdk_daemon_EXTERNAL_OBJECTS =

build/erpc_dpdk_daemon: CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_daemon.cc.o
build/erpc_dpdk_daemon: CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_externs.cc.o
build/erpc_dpdk_daemon: CMakeFiles/erpc_dpdk_daemon.dir/src/transport_impl/dpdk/dpdk_init.cc.o
build/erpc_dpdk_daemon: CMakeFiles/erpc_dpdk_daemon.dir/build.make
build/erpc_dpdk_daemon: third_party/gflags/libgflags_nothreads_debug.a
build/erpc_dpdk_daemon: third_party/HdrHistogram_c/src/libhdr_histogram_static.a
build/erpc_dpdk_daemon: /usr/lib/x86_64-linux-gnu/libz.so
build/erpc_dpdk_daemon: CMakeFiles/erpc_dpdk_daemon.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable build/erpc_dpdk_daemon"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/erpc_dpdk_daemon.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/erpc_dpdk_daemon.dir/build: build/erpc_dpdk_daemon
.PHONY : CMakeFiles/erpc_dpdk_daemon.dir/build

CMakeFiles/erpc_dpdk_daemon.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/erpc_dpdk_daemon.dir/cmake_clean.cmake
.PHONY : CMakeFiles/erpc_dpdk_daemon.dir/clean

CMakeFiles/erpc_dpdk_daemon.dir/depend:
	cd /home/qijing/eRPC && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC/CMakeFiles/erpc_dpdk_daemon.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/erpc_dpdk_daemon.dir/depend

