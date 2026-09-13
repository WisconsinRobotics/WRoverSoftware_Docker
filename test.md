# WRoverSoftware_Docker

Multi-service Docker Compose environment running Ubuntu 22.04 with ROS 2 Humble and Node.js dependencies.

Used for software development across main rover autonomy, simulation, and web GUI systems for Wisconsin Robotics.

## Requirements

- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) if on Windows.

  > **IMPORTANT:** All terminal commands should run in the WSL terminal on Windows.

- Install and configure Git, then generate an SSH key for GitHub (see [Git and CI/CD training](https://docs.google.com/document/d/1nh3XB0kvj7EMDJ3YU6YeAWiVRyPPHRfj/edit#heading=h.nrnjvwt1hpnv)). Ensure `ssh-agent` is running on your host machine to allow Git operations inside containers.

- Install [Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/) or [Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/).

- Install `make` and `vcstool` in a (WSL) terminal:

  ```bash
  sudo apt update && sudo apt install -y make python3-vcstool
  ```

  Install `make` on Mac by installing [Xcode Command Line Tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/) and `vcstool` via `pip3 install vcstool`.

## Setup

- Clone this repository:

  ```bash
  git clone git@github.com:WisconsinRobotics/WRoverSoftware_Docker.git
  cd WRoverSoftware_Docker
  ```

- Import child repositories (`WRoverSoftware`, `WRoverSoftwareSim`, `WRoverSoftwareGUI`) into the `./workspace` directory:

  ```bash
  make setup
  ```

- Set safe directory permissions for Git if prompted:

  ```bash
  git config --global --add safe.directory "*"
  ```

## Build

- Ensure Docker Engine / Docker Desktop is running.

- Build all container images (`main`, `sim`, `gui`):

  ```bash
  make build
  ```

  > **NOTE:** You only need to rebuild when a `Dockerfile` changes.

## Run

- Start all services in the background:

  ```bash
  make up
  ```

- Attach an interactive shell to a specific running service:

  ```bash
  make shell-main   # Main ROS 2 autonomy stack
  make shell-sim    # Simulation environment
  make shell-gui    # Web GUI stack
  ```

- Stop all running containers:

  ```bash
  make down
  ```

## Repository & Branch Management

The workspace repositories are bind-mounted into the containers live from `./workspace/`. Each repository operates independently.

- **Check out a different branch for a single repository:**

  ```bash
  cd workspace/WRoverSoftwareSim
  git checkout main
  ```

- **Switch all workspace repositories simultaneously using `vcstool`:**

  ```bash
  vcs custom workspace --args checkout dev
  ```

- **Check workspace status across all repositories:**

  ```bash
  vcs status workspace
  ```

## Visual Studio Code Setup

- Install [VS Code](https://code.visualstudio.com/download).

- Install the **Dev Containers** extension in VS Code.

- Open the `WRoverSoftware_Docker` folder in VS Code:

  ```bash
  code .
  ```

- Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and select **Dev Containers: Open Folder in Container...**.

- Choose the `.devcontainer` configuration for the service you want to develop in:
  - `.devcontainer/main`
  - `.devcontainer/sim`
  - `.devcontainer/gui`

- To disconnect, click the bottom-left corner of VS Code, select **Close Remote Connection**, and stop the stack using `make down`.

## Adding Dependencies

- **Python & ROS Dependencies:** Add ROS 2 or system dependencies to the respective service `Dockerfile` in `Dockerfiles/`, then rebuild the container:

  ```bash
  make build
  ```

- **Node.js Packages (GUI):** Install packages directly inside `WRoverSoftwareGUI` using `npm install <package-name>` or update `package.json`.