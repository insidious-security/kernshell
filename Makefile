obj-m = kernshell.o

MODULE_NAME = kernshell
KVERSION = $(shell uname -r)

all:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) clean

install:
	@echo ""
	@echo "__                              .__           .__  .__   "
	@echo "|  | __ ___________  ____   _____|  |__   ____ |  | |  |  "
	@echo "|  |/ // __ \_  __ \/    \ /  ___/  |  \_/ __ \|  | |  |  "
	@echo "|    <\  ___/|  | \/   |  \\___ \|   Y  \  ___/|  |_|  |__"
	@echo "|__|_ \\___  >__|  |___|  /____  >___|  /\___  >____/____/"
	@echo "     \/    \/           \/     \/     \/     \/            "
	@echo "					Author: int0x80"
	@echo "[+] Installing the module."
	sudo cp $(MODULE_NAME).ko /lib/modules/$(KVERSION)
	sudo depmod -a
	sudo modprobe $(MODULE_NAME)
	sudo cp ./kernshell-handler.service /etc/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl enable --now kernshell-handler.service	

remove:
	@echo "[+] Removing the kernel module."
	sudo rm /lib/modules/$(KVERSION)/$(MODULE_NAME).ko
	sudo rm /etc/systemd/system/kernshell-handler.service
