# MysqlTools

## Setup

Write a configuration file.

```sh
touch ~/.mysql-tools.conf
chmod 600 ~/.mysql-tools.conf
echo "ROOT_PASSWORD=root" > ~/.mysql-tools.conf
```


## Usage

This section explains how to use this project.

Run the main program.

```sh
bin/mt
```


## Development

This section explains how to use scripts that are intended to ease the development of this project.

Run style check.

```sh
script/check.sh
```

Build the project like Jenkins.

```sh
script/build.sh
```
