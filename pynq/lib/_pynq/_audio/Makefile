OBJSC = audio.o 
INC = -I ../inc/

all:	
	# $(CROSS_COMPILE)gcc -fPIC $(INC) -c -g3 -gstabs audio.cpp
	$(CROSS_COMPILE)gcc -fPIC $(INC) -c -g3 audio.cpp
	$(CROSS_COMPILE)g++ -g3 -gstabs -shared -fPIC -rdynamic $(OBJSC)  -Wl,--start-group $(LIBS) -Wl,--end-group -o libaudio.so
	rm *.o

clean:
	rm -f *.so
