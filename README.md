# WRoverSoftware_Docker

Multi-service Docker Compose environment running Ubuntu 22.04 with ROS 2 Humble, Python, and Node.js dependencies.

Used for software development across main rover autonomy, simulation, and web GUI systems for Wisconsin Robotics.

## Requirements

- Install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) if on Windows.

  > **IMPORTANT:** All terminal commands should run in the WSL terminal on Windows.

- Install and configure Git, then generate an SSH key for GitHub (see [Git and CI/CD training](https://docs.google.com/document/d/1nh3XB0kvj7EMDJ3YU6YeAWiVRyPPHRfj/edit?usp=sharing&ouid=105569728221765568022&rtpof=true&sd=true)). Ensure `ssh-agent` is running on your host machine to allow Git operations inside containers.

- Install [Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/) or [Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/).

- Install `make` and `vcstool` in a (WSL) terminal:

  ```bash
  sudo apt update
  sudo apt install make
  sudo apt install python3-pip -y
  pip install vcstool --break-system-packages
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

  > **NOTE:** You only need to rebuild when a `Dockerfile` or dependency file changes.

- If running into permission issues on Linux/WSL, see [this post](https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied).

## Run

- Start all container services in the background:

  ```bash
  make up
  ```

- Attach an interactive terminal shell to a specific running service:

  ```bash
  make shell-main   # Main ROS 2 autonomy stack
  make shell-sim    # Simulation environment
  make shell-gui    # Web GUI stack
  ```

- Stop all running containers and exit:

  ```bash
  make down
  ```

## Repository & Branch Management

The child repositories inside `./workspace/` are bind-mounted live into their respective containers. Each repository operates independently.

- **Check out a different branch for a single repository:**

  ```bash
  cd workspace/WRoverSoftwareSim
  git checkout main
  ```

- **Switch all workspace repositories simultaneously using `vcstool`:**

  ```bash
  vcs custom workspace --args checkout dev
  ```
  Note: Do not do this without consulting the software leads
  
- **Check workspace status across all repositories:**

  ```bash
  vcs status workspace
  ```

## Visual Studio Code Setup

- Download [VS Code](https://code.visualstudio.com/download).

- Install the **Dev Containers** extension in VS Code.

  ![Dev Containers extension](images/1.png)

- Open the `WRoverSoftware_Docker` folder in VS Code:

  ```bash
  code .
  ```

- Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and select **Dev Containers: Open Folder in Container...** (or attach to a running container via the Remote Explorer panel).

  ![Attach the container](images/2.png)

- Choose the `.devcontainer` configuration for the target service:
  - `.devcontainer/main`
  - `.devcontainer/sim`
  - `.devcontainer/gui`

- To disconnect, click the bottom-left corner of VS Code, select **Close Remote Connection**, and stop the stack using `make down`.

  ![Bottom left corner](images/3.png)

  ![Close remote connection](images/4.png)

## Adding Dependencies & Packages

- **ROS 2 & System Dependencies:** Add apt packages to the respective service `Dockerfile` in `Dockerfiles/`, then rebuild:

  ```bash
  make build
  ```

- **Python Packages:** Add package requirement(s) in `requirements.txt`, one package per line.

  > For consistency, it's best to specify the package version, for example, `depthai==3.1.0`.

  After adding packages, rebuild the Docker containers using `make build`.

- **Node.js Packages (GUI):** Install packages directly inside `WRoverSoftwareGUI` using `npm install <package-name>` or update `package.json`.

- To push dependency or infrastructure changes, open a PR (see [Git and CI/CD training](https://docs.google.com/document/d/1nh3XB0kvj7EMDJ3YU6YeAWiVRyPPHRfj/edit?usp=sharing&ouid=105569728221765568022&rtpof=true&sd=true)).\




