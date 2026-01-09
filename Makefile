CC    = gcc
BASE  = lampify
INST  = /usr/local/bin/
CFLAG = -Wall -Ofast

# Use pkg-config for portable include/library paths
NOTIFY_CFLAGS = $(shell pkg-config --cflags libnotify)
NOTIFY_LIBS   = $(shell pkg-config --libs libnotify)

all:
	$(CC) $(CFLAG) $(NOTIFY_CFLAGS) -o $(BASE) $(BASE).c -lbluetooth $(NOTIFY_LIBS)

clean:
	rm -f $(BASE)

install:
	cp $(BASE) $(INST)$(BASE)
	chmod a+x $(INST)$(BASE)
	setcap 'cap_net_raw,cap_net_admin+eip' $(INST)$(BASE)

uninstall:
	rm -f $(INST)$(BASE)
