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
include CMakeFiles/small_msg_test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/small_msg_test.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/small_msg_test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/small_msg_test.dir/flags.make

CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o: CMakeFiles/small_msg_test.dir/flags.make
CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o: tests/client_tests/small_msg_test.cc
CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o: CMakeFiles/small_msg_test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o -MF CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o.d -o CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o -c /home/qijing/eRPC/tests/client_tests/small_msg_test.cc

CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/qijing/eRPC/tests/client_tests/small_msg_test.cc > CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.i

CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/qijing/eRPC/tests/client_tests/small_msg_test.cc -o CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.s

# Object files for target small_msg_test
small_msg_test_OBJECTS = \
"CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o"

# External object files for target small_msg_test
small_msg_test_EXTERNAL_OBJECTS =

build/small_msg_test: CMakeFiles/small_msg_test.dir/tests/client_tests/small_msg_test.cc.o
build/small_msg_test: CMakeFiles/small_msg_test.dir/build.make
build/small_msg_test: build/liberpc.a
build/small_msg_test: third_party/gflags/libgflags_nothreads_debug.a
build/small_msg_test: third_party/HdrHistogram_c/src/libhdr_histogram_static.a
build/small_msg_test: lib/libgtestd.a
build/small_msg_test: /usr/lib/x86_64-linux-gnu/libz.so
build/small_msg_test: CMakeFiles/small_msg_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable build/small_msg_test"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/small_msg_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/small_msg_test.dir/build: build/small_msg_test
.PHONY : CMakeFiles/small_msg_test.dir/build

CMakeFiles/small_msg_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/small_msg_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/small_msg_test.dir/clean

CMakeFiles/small_msg_test.dir/depend:
	cd /home/qijing/eRPC && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC /home/qijing/eRPC/CMakeFiles/small_msg_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/small_msg_test.dir/depend
