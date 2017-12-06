#!/usr/bin/python

# Adapted from Xilnx Pynq pip-install setup.py script
# This should probably be a make file with defconfig instead...

import shutil
import subprocess
import sys
import os
import warnings

# Pynq Family Constants - Check to see if the $ARCH is supported
ZYNQ_ARCH = os.environ['ARCH']
CPU_ARCH = ['arm','arm64']
CPU_ARCH_IS_SUPPORTED = ZYNQ_ARCH in CPU_ARCH

# Board selection, Pynq-Z1, Microzed, Ultrazed
BOARD = os.environ['BOARD']

# Deploy Path
DEPLOY_DIR = './boards/' + BOARD + '/bsp/rootfs_part/home/ubuntu/'

# Pynq Path
PYNQ_DIR = './pynq/'
PYNQ_LIB = PYNQ_DIR + 'lib/'

# Supported pynq modules
pynq_modules = \
    [PYNQ_DIR + 'ps.py',
     PYNQ_DIR + 'mmio.py',
     PYNQ_DIR + 'xlnk.py']

# Supported pynq/lib modules
pynq_lib_modules = \
    [PYNQ_LIB + 'dma.py']

# Run Makefiles here
def run_make(src_path, dst_path, output_lib):
	status = subprocess.check_call(["make", "-C", src_path])
	if status is not 0:
		print("Error while running make for", output_lib, "Exiting..")
		sys.exit(1)
	else:
		shutil.copyfile(src_path + output_lib, dst_path + output_lib)

# Copy pynq files from src to dest
def cp_pynq(src_path,dst_path):
	for i in range(0,len(src_path)):
		shutil.copyfile(src_path[i], dst_path + src_path[i])

def main():
	if BOARD is None:
		print("Please set the BOARD environment variable (e.g. Pynq-Z1).")
		sys.exit(1)

	# Build Pynq Libraries, copy to DEPLOY_DIR
	if CPU_ARCH_IS_SUPPORTED:
		run_make("pynq/lib/_pynq/_apf/", DEPLOY_DIR + 'pynq/lib/', "libdma.so")
		run_make("pynq/lib/_pynq/_audio/", DEPLOY_DIR + 'pynq/lib/', "libaudio.so")
		run_make("pynq/libsds/xlnkutils/", DEPLOY_DIR + 'pynq/lib/', "libsds_lib.so")
	else:
		warnings.warn("Pynq does not support the CPU Architecture: {}".format(CPU_ARCH), ResourceWarning)

	# Copy Supported pynq modules to DEPLOY_DIR
	cp_pynq(pynq_modules,DEPLOY_DIR)
	
	# Copy Supported pynq libs to DEPLOY_DIR
	cp_pynq(pynq_lib_modules,DEPLOY_DIR)

if __name__ == "__main__":
    main()