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

# Copy pynq libs and python modules to the pynq deploy path
install:
	cp -v ./${APF}/*.so ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_LIB_PATH}
	cp -v ./${AUDIO}/*.so ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_LIB_PATH}
	cp -v ./${XLNK}/*.so ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_LIB_PATH}
	cp -v ./lib/dma.py ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_LIB_PATH}
	cp -v ./ps.py ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_PATH}
	cp -v ./mmio.py ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_PATH}
	cp -v ./xlnk.py ../boards/${BOARD}/bsp/rootfs_part/home/ubuntu/${PYNQ_PATH}
