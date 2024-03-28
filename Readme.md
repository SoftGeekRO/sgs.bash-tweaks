# Bash tweaks commands

Some tweaks that will make work more easy for any bash purist or geeks

An `alias` means as the name suggests, we call something instead of something else.

# Contents :

- [Instalation](#-installation)
- [General purpose aliases](#general_purpose)
- [git cli aliases](#git_cli_aliases)
- [programming snippets](#programming_snippets)
- [Competitive Programming snippets](#CP_snippets)

### 🔧 Installation
The installation is very simple. 
```bash
git clone https://github.com/SoftGeekRO/sgs.bash-tweaks.git
cd sgs.bash-tweaks

sudo ./install.sh install

```
The installation will create a *sgs/sgs.bash-tweaks* folder inside the */user/share/* folder.
The **sgs** folder is used to keep all the SoftGeek applications contain in a single folder.

### general_purpose

```shell
# clear screen in terminal
alias c='clear'
```

```shell
# change directory aliases
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
```

```shell
# shoutdown aliases
alias off="sudo shutdown now"
alias ss="sudo shutdown -r now"
alias sf="sudo shutdown -r -n now"
```
More alias and commands are available inside the lib files.

### 🌍 Contributions

Contributions of all forms are welcome :)

## 🗒 License

This Ansible role is licensed under the GNU General Public License, version 3 (GPLv3).

## 👀 Author

**Zaharia Constantin**

[View my GitHub profile 💡](https://github.com/soulraven)

[SoftGeek Company Profile](https://github.com/SoftGeekRO)
