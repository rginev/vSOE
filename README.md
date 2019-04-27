# vSOE: Development SOE configuration

**Table of Contents**

<!-- toc -->

- [About](#about)
- [Limitations](#limitations)
- [Usage](#usage)
  * [Installing required utilities](#install-required-utilities)
  * [Lint ansible code](#lint-ansible-code)
  * [Dryrun](#dryrun-mode)
  * [Configure the environment](#configure-the-environment)
  * [Manage Vim packages](#manage-vim-packages)
- [Further reading](#further-reading)

<!-- tocstop -->

## About

This is an automated configuration of development environemnt, physical or virtual.
It manages following:

* OS packages
* PiP packages
* dotfiles
* Vim plugins

### Vim plugins

Third party plugin helpers like Pathogen and Vundle are not used.
Vim 8 has a native way of loading third-party plugins by simply droping them in a specific directory.
This repository offers a simple tool which adds, removes or updates Vim plugins as git submodules.
Automation then will copy them under ~/.vim, which makes plugins avaialable to Vim at next start.

## Limitations

Only Ubuntu/Debian compatible OS-es are supported

## Usage

### Install required utilities

```bash
$ make init
```
 
### Lint ansible code

```bash
$ make validate

OR simply

$ make
```
 
### Dry run mode

```bash
$ make dryrun
```
 
### Configure the environment

```bash
$ make play
```
 
### Manage Vim packages

```bash
$ ./vim_plugin_manager.sh {add|remove} Plugin1 [Plugin2 ...]
./vim_plugin_manager.sh update
```
 
## Further reading

* [Vim: So long Pathogen, hello native package loading](https://shapeshed.com/vim-packages/)
* [:help packages](http://vimhelp.appspot.com/repeat.txt.html#packages)
* [Ansible](https://docs.ansible.com/ansible/latest/index.html)

