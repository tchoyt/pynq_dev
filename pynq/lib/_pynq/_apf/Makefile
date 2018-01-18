all:
	make -C ./axidma_v9_1
	make -C standalone_v5_4
	$(CROSS_COMPILE)gcc -fPIC -shared -rdynamic  xil_io.o xaxidma.o -o  libdma.so

clean:
	rm -f *.o
	rm -f *.so
