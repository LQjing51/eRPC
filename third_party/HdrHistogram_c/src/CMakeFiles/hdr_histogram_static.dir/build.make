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
include third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.make

# Include the progress variables for this target.
include third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/progress.make

# Include the compile flags for this target's objects.
include third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o: third_party/HdrHistogram_c/src/hdr_encoding.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_encoding.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_encoding.c > CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_encoding.c -o CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o: third_party/HdrHistogram_c/src/hdr_histogram.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram.c > CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram.c -o CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o: third_party/HdrHistogram_c/src/hdr_histogram_log.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram_log.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram_log.c > CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_histogram_log.c -o CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o: third_party/HdrHistogram_c/src/hdr_interval_recorder.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_interval_recorder.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_interval_recorder.c > CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_interval_recorder.c -o CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o: third_party/HdrHistogram_c/src/hdr_thread.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_thread.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_thread.c > CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_thread.c -o CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o: third_party/HdrHistogram_c/src/hdr_time.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_time.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_time.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_time.c > CMakeFiles/hdr_histogram_static.dir/hdr_time.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_time.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_time.c -o CMakeFiles/hdr_histogram_static.dir/hdr_time.c.s

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/flags.make
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o: third_party/HdrHistogram_c/src/hdr_writer_reader_phaser.c
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o -MF CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o.d -o CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o -c /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_writer_reader_phaser.c

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.i"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_writer_reader_phaser.c > CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.i

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.s"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/qijing/eRPC/third_party/HdrHistogram_c/src/hdr_writer_reader_phaser.c -o CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.s

# Object files for target hdr_histogram_static
hdr_histogram_static_OBJECTS = \
"CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o" \
"CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o"

# External object files for target hdr_histogram_static
hdr_histogram_static_EXTERNAL_OBJECTS =

third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_encoding.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_histogram_log.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_interval_recorder.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_thread.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_time.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/hdr_writer_reader_phaser.c.o
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/build.make
third_party/HdrHistogram_c/src/libhdr_histogram_static.a: third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/qijing/eRPC/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking C static library libhdr_histogram_static.a"
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && $(CMAKE_COMMAND) -P CMakeFiles/hdr_histogram_static.dir/cmake_clean_target.cmake
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hdr_histogram_static.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/build: third_party/HdrHistogram_c/src/libhdr_histogram_static.a
.PHONY : third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/build

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/clean:
	cd /home/qijing/eRPC/third_party/HdrHistogram_c/src && $(CMAKE_COMMAND) -P CMakeFiles/hdr_histogram_static.dir/cmake_clean.cmake
.PHONY : third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/clean

third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/depend:
	cd /home/qijing/eRPC && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/qijing/eRPC /home/qijing/eRPC/third_party/HdrHistogram_c/src /home/qijing/eRPC /home/qijing/eRPC/third_party/HdrHistogram_c/src /home/qijing/eRPC/third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : third_party/HdrHistogram_c/src/CMakeFiles/hdr_histogram_static.dir/depend
