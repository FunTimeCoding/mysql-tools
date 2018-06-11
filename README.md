# MysqlTools

## Setup

Install project dependencies.

```sh
script/setup.sh
```

Create configuration.

```sh
touch ~/.mysql-tools.conf
chmod 600 ~/.mysql-tools.conf
echo "ROOT_PASSWORD=root" > ~/.mysql-tools.conf
```


## Usage

This section explains how to use the project.

Run the main program.

```sh
bin/mt
```


## Development

This section explains how to improve the project.

Configure Git on Windows before cloning. This avoids problems with Vagrant and VirtualBox.

```sh
git config --global core.autocrlf input
```

Create the development virtual machine on Linux and Darwin.

```sh
script/vagrant/create.sh
```

Create the development virtual machine on Windows.

```bat
script\vagrant\create.bat
```

Run tests.

```sh
script/test.sh [--help]
```

Run style check.

```sh
script/check.sh [--help]
```

Build project.

```sh
script/build.sh
```
