# juno
This repository contains all the files which makes a docker image for development purposes.
![Docker Image CI](https://github.com/prateek2408/juno/workflows/Docker%20Image%20CI/badge.svg?branch=master)

# Dockerfile
The file builds the docker image.
1. Based on ubuntu focal.
2. Vim version 8.1
3. Git installed
4. Default vim plugins-
     a. vim-go -- This plugin makes the development of Go in vim simpler.
     b. pathogen -- Smartly loads all plugins from specified paths.
     c. sensible -- A common set of standards for vim editor.
     d. vim-plug -- Plugin manager for vim.
     e. vundle -- Another vim plugin mangager.

