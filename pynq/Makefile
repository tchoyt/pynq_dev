# Top Level makefile for the pynq library
APF = lib/_pynq/_apf/
AUDIO = lib/_pynq/_audio/
XLNK = libsds/xlnkutils/

all: apf audio xlnk
.PHONY : all

# Xilinx APF DMA driver
apf:
	make -C ./${APF}

# Xilinx Audrio driver
audio:
	make -C ./${AUDIO}

# Xilinx XLNK SDS Lib 
xlnk:
	make -C ./${XLNK}

clean:
	make clean -C ./${APF}
	make clean -C ./${AUDIO}
	make clean -C ./${XLNK}

install:
	echo "PYNQ INSTALL"
