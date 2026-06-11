# WRoverSoftware_Docker
Docker environment running Ubuntu 22.04 with ROS 2 Humble and Python dependencies.

## Requirements

### All systems
- Docker Engine
- make
- Git

### Windows
- WSL2
- Docker Desktop (WSL2 backend)
- make (inside WSL)

### macOS
- Docker Desktop
- make (via Xcode tools or Homebrew)

## Setup

### Git config and SSH setup

### Docker setup

### WRoverSoftware repo setup

```
git config --global --add safe.directory /root/WRoverSoftware_26-27
```

### Visual Studio Code setup

## Build

```
docker build -t wrover .
```

## Run

```
make run
```

## Misc

### Updating python packages
