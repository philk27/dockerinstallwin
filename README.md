# dockerinstallwin

# PowerShell Script to Install WSL 2 and Docker Desktop on Windows 10

This PowerShell script checks if virtualization is enabled on your computer, installs WSL 2 and sets it as the default version, downloads and runs the Docker Desktop installer, and checks that Docker is working by running `docker info` command.

## Prerequisites

- Windows 10 Enterprise, Pro, or Education
- 64-bit Processor with Second Level Address Translation (SLAT)
- CPU support for VM Monitor Mode Extension (VT-c on Intel CPUs)
- Minimum of 4 GB memory
- Internet connection

## Usage

1. Download or copy the script to your computer and save it as `dockerinstallwin.ps1`.
2. Open a PowerShell console as Administrator and navigate to the directory where you saved the script.
3. Run the script by typing `.\dockerinstallwin.ps1`.
4. Follow the prompts and confirmations on the screen. The script will ask you if you want to proceed with each step and will display informative messages and error messages if any.
5. The script will reboot your computer if virtualization is not enabled in BIOS. You will need to enter BIOS and enable virtualization manually. The script will print the instructions on how to do that before rebooting.
6. The script will open the Docker Desktop install for Windows web page from Docker documentation for your reference.
7. The script will exit when it finishes all the steps or encounters an error that prevents it from continuing.

## Further info
Enabling virtualisation in BIOS https://pureinfotech.com/enable-virtualization-uefi-bios-windows-11/
Installing WSL https://learn.microsoft.com/en-us/windows/wsl/install
Installing docker Desktop https://docs.docker.com/desktop/install/windows-install/

wsl intro https://learn.microsoft.com/en-us/windows/wsl/setup/environment
docker intro  https://docs.docker.com/get-started/hands-on-overview/

wsl documentation https://learn.microsoft.com/en-us/windows/wsl/
docker documentation https://docs.docker.com/get-started/overview/

## Free text editors for windows 
VScode: (It's not just for visual studio) https://code.visualstudio.com/   
notapad++ (This should be Windows default IMHO).  https://notepad-plus-plus.org/ 

## Disclaimer

This script is provided "as is" without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. The entire risk as to the quality and performance of the script is with you. Should the script prove defective, you assume the cost of all necessary servicing, repair or correction.
