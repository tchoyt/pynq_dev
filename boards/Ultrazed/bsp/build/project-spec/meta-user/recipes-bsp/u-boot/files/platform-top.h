
#include <configs/platform-auto.h>
#define CONFIG_SYS_BOOTM_LEN 0xF000000

/*Required for uartless designs */
#ifndef CONFIG_BAUDRATE
#define CONFIG_BAUDRATE 115200
#ifdef CONFIG_DEBUG_UART
#undef CONFIG_DEBUG_UART
#endif
#endif

/* Override default preboot settings */
#define CONFIG_PREBOOT	"echo; echo U-BOOT for Pynq; echo"

/* Extra U-Boot Env settings */
#define CONFIG_EXTRA_ENV_SETTINGS \
	SERIAL_MULTI \ 
	CONSOLE_ARG \ 
	PSSERIAL0 \ 
	"sd_dev=1\0" \
	"sd_part=1\0" \
	"fpga_dev=0\0" \
	"root_dev=/dev/mmcblk1p2\0" \
	"boot_env=uEnv.txt\0" \
	"fpga_addr=0x15800000\0" \
	"boot_env_addr=0x13800000\0" \
	"dtb_addr=0x11800000\0" \
	"kernel_addr=0x10000000\0" \
	"loadbootenv=fatload mmc $sd_dev:$sd_part ${boot_env_addr} ${boot_env}\0" \ 
	"importbootenv=env import -t ${boot_env_addr} $filesize\0" \ 
	"fpga_img=pynq.bit\0" \
	"dtb_img=system.dtb\0" \
	"kernel_img=Image\0" \
	"setup_mmc=mmc dev $sd_dev:$sd_part\0" \
	"cp_fpga2ram=fatload mmc $sd_dev:$sd_part ${fpga_addr} ${fpga_img}\0" \
	"load_fpga=fpga loadb ${fpga_dev} ${fpga_addr} $filesize\0" \
	"cp_dtb2ram=fatload mmc $sd_dev:$sd_part ${dtb_addr} ${dtb_img}\0" \
	"cp_kernel2ram=fatload mmc $sd_dev:$sd_part ${kernel_addr} ${kernel_img}\0" \
	"set_root_dev=env set root_dev /dev/mmcblk${sd_dev}p2\0" \
	"set_bootargs=env set bootargs console=ttyPS0,115200 root=${root_dev} rw earlyprintk rootfstype=ext4 rootwait clk_ignore_unused\0" \
	"bootcmd=run setup_mmc; run set_root_dev; run set_bootargs; run cp_fpga2ram; run load_fpga; run cp_dtb2ram; run cp_kernel2ram; booti ${kernel_addr} - ${dtb_addr}\0" \
	"mmc_boot=env set sd_dev 0; run bootcmd\0" \
""
