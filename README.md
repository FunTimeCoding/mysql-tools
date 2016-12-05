# MysqlTools

## Usage

This section explains how to use this project.

Run the main entry point program.

```sh
bin/mt
```

```sh
touch ~/.mysql-tools.conf
chmod 600 ~/.mysql-tools.conf
echo "ROOT_PASSWORD=root" > ~/.mysql-tools.conf
```


## Development

This section explains how to use scripts that are intended to ease the development of this project.

Install development tools.

```sh
sudo apt-get install shellcheck
```

Run style check and show all concerns.

```sh
./run-style-check.sh
```

Build the project like Jenkins.

```sh
./build.sh
```
