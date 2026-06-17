# WRoverSoftware_Docker

Docker environment running Ubuntu 22.04 with ROS 2 Humble and Python dependencies.

Used for software development for Wisconsin Robotics.

## Requirements

- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) if on Windows.

  > **IMPORTANT:** All terminal commands should run in the WSL terminal on Windows.

- Install and configure Git, then generate an SSH key for GitHub (see [Git and CI/CD training]()).

- Install [Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/) or [Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/).

- Install make on Windows in a (WSL) terminal:

  ```bash
  sudo apt update && sudo apt install -y make
  ```

  Install make on Mac by installing [Xcode Command Line Tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/).

## Setup

### Workspace setup

- Create a workspace directory.

- Enter the workspace directory, then clone this repository.

  ```bash
  git clone git@github.com:WisconsinRobotics/WRoverSoftware_Docker.git
  ```

### Adding other GitHub repositories

- Make sure the repository is cloned into the workspace.

- Set the repository as a safe directory for Git:
  
  ```bash
  git config --global --add safe.directory /root/workspace/<repo-name>
  ```
  
- For example:
  
  ```bash
  git config --global --add safe.directory /root/workspace/WRoverSoftware_26-27
  ```
  
## Build

- Open a terminal in **this directory** and enter:

  ```bash
  docker build -t wrover .
  ```

## Run

- Once the Docker image has been built, it does not need to be rebuilt every time.
  
  Rebuild only when `Dockerfile` or `requirements.txt` changes.
  
- To run, open a terminal in **this directory** and enter:

  ```bash
  make run
  ```
  
- To exit, enter `exit` in the same terminal.

## Misc

### Visual Studio Code setup

- Download [VS Code](https://code.visualstudio.com/download).
  
- Install the Dev Containers VS Code extension.
  
  ![Dev Containers extension](images/1.png)
  
- Run the container and attach the container through the extension by clicking the right arrow next to the `wrover` container under `Dev Containers`.
  
  ![Attach the container](images/2.png)
  
- To disconnect, click the bottom left corner, click `Close Remote Connection`, then shut down the container.
  
  ![Bottom left corner](images/3.png)
  
  ![Close remote connection](images/4.png)

### Adding python packages

- Add the python package(s) in `requirements.txt`, one package per line.
  
  > For consistency, it's best to specify the package version, for example, `depthai==3.1.0`.
  
- After adding the package(s), rebuild the Docker container:
  
  ```bash
  docker build -t wrover .
  ```
  
- To push changes, create a new branch and open a PR (see [Git and CI/CD training]()).






