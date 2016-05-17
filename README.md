# linux
Custom linux configurations and scripting

## arch-linux
Custom installation and configuration for Arch.

### ToDo
- [ ] adduser/passwd at end of installation for default user
- [ ] Map "lock screen" 
- [ ] Load configuration after installation
- [x] create custom mirrorlist and pre-rank for download
- [x] Configure hostname
- [x] Run guake on load of xfce
- [x] Create .xinitrc for slim
- [x] Clone arch-linux git repo into /root/Documents
- [x] Modify below code into a running script (code removed see arch-install.sh)

### Links
- [Arch Wiki - GRUB](https://wiki.archlinux.org/index.php/GRUB)
- [Arch Wiki - Installation Guide](https://wiki.archlinux.org/index.php/installation_guide)
- [Columbia University - Arch Linux VM in VirtualBox](http://www.cs.columbia.edu/~jae/4118-LAST/arch-setup-2015-1.html)

### Install Guide
```bash
## Download latest install script
wget https://raw.githubusercontent.com/n0v1c3/arch-linux/master/arch-install.sh

## Run installation script
bash ./arch-install.sh  # Follow onscreen instructions
