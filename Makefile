# Makefile
#
# @author: Rezvee Rahman
# @date:   01/10/2026
#
# @details: This file is the build system for our project.
#

SHELL=/bin/sh

# Quick hacks (not recommended)
#
echo=printf


# The user can decide if thet want to use a different compiler (e.g. clang)
# Example:
#	$ make assemble CXX=clang++-20 CXX_FLAGS="-Wall -Xanalyzer"
#
#
CXX?=g++
CXX_FLAGS?=-Wall -fanalyzer -std=${CXX_STD}
CXX_STD?=c++20

# Directories
#
SRC_DIR:=src
INC_DIR:=include
BUILD_DIR:=build
DEBUG_DIR:=${BUILD_DIR}/debug
OBJ_DIR:=${BUILD_DIR}/.obj
ASM_DIR:=${BUILD_DIR}/.asm

# Source files
#
SRCS:= main.cpp
ASMS:=$(patsubst %.cpp,%.s,${SRCS})
OBJS:=$(patsubst %.cpp,%.o,${SRCS})
INC:=main.h
BIN:=main

VPATH=${SRC_DIR}:${INC_DIR}
.DEFAULT_GOAL : help

# Note that using `echo -e` is not POSIX compliant
#
help:
	@$(echo) "Help menu:\n"
	@$(echo) "\tmake help (default)             - prints help menu\n"
	@$(echo) "\tmake run                        - builds and runs the program\n"
	@$(echo) "\tmake build                      - builds program\n"
	@$(echo) "\tmake assemble                   - builds the assembly files for the program\n"
	@$(echo) "\tmake debug (build is a pre-req) - builds a debug version of the executable\n"
	@$(echo) "\tmake clean                      - cleans artifacts\n"
	@$(echo) "\tmake obj                        - creates object files but does not link\n"
	@$(echo) "\n"
.PHONY: help

run : build
	@${BUILD_DIR}/${BIN}
.PHONY: run

build: ${OBJS}
	@echo "Starting to build (Objects)"
	@if [ ! -d ${OBJ_DIR} ]; then \
		echo "Creating build directory."; \
		mkdir ${OBJ_DIR}; \
	fi;
	@mv *.o ${OBJ_DIR}
	@if [ ! -d ${DEBUG_DIR} ]; then \
		echo "Creating a debug directory." \
		mkdir ${DEBUG_DIR}; \
	fi;
	@pushd ${OBJ_DIR}; \
	$(CXX) $(CXX_FLAGS) ${OBJS} -o ${BIN}; popd; \
	if [ -f ${OBJ_DIR}/${BIN} ]; then \
		mv ${OBJ_DIR}/${BIN} ${BUILD_DIR}/${BIN}; \
	fi;
	@$(echo) "\x1b[38;5;2mSuccess!\x1b[0m\n\n"
.PHONY: build

assemble: ${ASMS}
	@echo "Starting to build (Assembly *.s )"
	@if [ ! -d ${ASM_DIR} ]; then \
		echo "Creating build directory."; \
		mkdir ${ASM_DIR}; \
	fi;
	@mv *.s ${ASM_DIR}
	@echo -e "Assembled files"
.PHONY: assemble

clean:
	@$(echo) "\x1b[38;5;3mCleaning artifacts\x1b[0m\n"
	@rm -rf ${DEBUG_DIR}
	@rm -rf ${OBJ_DIR}
	@rm -rf ${ASM_DIR}
	@rm -rf ${BUILD_DIR}/${BIN}
	@$(echo) "\n"
.PHONY: clean

%.o : %.cpp
	$(CXX) $(CXX_FLAGS) -c $< -o $@ -I${INC_DIR}

%.s : %.cpp
	$(CXX) $(CXX_FLAGS) -S $< -o $@ -I${INC_DIR}