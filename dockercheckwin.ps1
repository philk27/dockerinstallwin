# Check if virtualization is enabled
$sysinfo = systeminfo
if ($sysinfo -like '*Virtualization Enabled In Firmware: Yes*') {
    Write-Output "Virtualization is enabled"
    # Test that virtualization has been successfully installed on Windows
    $result = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
    if ($result.State -eq "Enabled") {
        Write-Output "Virtual Machine Platform feature is enabled."
    } else {
        Write-Output "Virtual Machine Platform feature is not enabled. Exiting the script."
        Exit 1
    }
} else {
    Write-Output "Virtualization is not enabled"
    # Ask the user if they want to boot to BIOS
    $choice = Read-Host "Do you want to boot to BIOS to enable virtualization? (Y/N)"
    if ($choice -eq "Y") {
        # Print information on how to enable virtualization in BIOS
        Write-Output "To enable virtualization in BIOS, follow these steps:"
        Write-Output "1. Your computer will restart and open the Choose an Option screen."
        Write-Output "2. Navigate to Troubleshoot > Advanced Options > UEFI Firmware Settings, and click Restart."
        Write-Output "3. Your PC will then enter BIOS."
        Write-Output "4. Navigate to the Advanced tab or section and look for an option named Virtualization Technology, Intel Virtualization Technology, Intel VT-x, AMD-V, or something similar."
        Write-Output "5. Enable the option and save the changes."
        Write-Output "6. Exit BIOS and reboot your computer."
        # Boot to BIOS using shutdown command
        shutdown /r /o /f /t 00
    } else {
        # Exit the script
        Write-Output "You need to enable virtualization in BIOS to continue. Exiting the script."
        Exit 1
    }
}

# Use DISM to install WSL2 and set it as the default version
# Describe the first step and wait for confirmation
Write-Output "The first step is to install WSL 2 and set it as the default version using DISM and wsl commands. WSL 2 allows you to run Linux distributions on Windows 10."
$choice = Read-Host "Do you want to proceed? (Y/N)"
if ($choice -eq "Y") {
    # Install the Microsoft-Windows-Subsystem-Linux feature and check for errors
    $result = dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    if ($result -like '*Error*') {
        # Print the error message and exit the script
        Write-Output "An error occurred while installing the Microsoft-Windows-Subsystem-Linux feature. See below for details."
        Write-Output $result
        Exit 1
    } else {
        # Print a success message and continue
        Write-Output "The Microsoft-Windows-Subsystem-Linux feature was installed successfully."
    }
    
    # Install the Virtual Machine Platform feature and check for errors
    $result = dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    if ($result -like '*Error*') {
        # Print the error message and exit the script
        Write-Output "An error occurred while installing the Virtual Machine Platform feature. See below for details."
        Write-Output $result
        Exit 1
    } else {
        # Print a success message and continue
        Write-Output "The Virtual Machine Platform feature was installed successfully."
    }
    
    # Set WSL 2 as the default version and check for errors
    $result = wsl --set-default-version 2
    if ($result -like '*Error*') {
        # Print the error message and exit the script
        Write-Output "An error occurred while setting WSL 2 as the default version. See below for details."
        Write-Output $result
        Exit 1
    } else {
        # Print a success message and continue
        Write-Output "WSL 2 was set as the default version successfully."
    }
    
    # Test that WSL 2 has been installed and runs by checking its version
    $result = wsl --list --verbose | Select-String -Pattern Version | Select-Object -ExpandProperty Line | Out-String | ForEach { $_.Trim() }
    if ($result -like '*Version 2*') {
        # Print a success message and display the output of wsl --list --verbose
        Write-Output "WSL 2 has been installed and runs successfully. Here is the output of wsl --list --verbose:"
        wsl --list --verbose
    } else {
        # Print an error message and exit the script
        Write-Output "WSL 2 has not been installed or runs properly. Exiting the script."
        Exit 1
    }
} else {
    # Exit the script
    Write-Output "You need to install WSL 2 and set it as the default version to continue. Exiting the script."
    Exit 1
}

# Download and run the Docker Desktop installer and check that Docker is working
# Describe the second and final step and wait for confirmation
Write-Output "The second and final step is to download and run the Docker Desktop installer from https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe and check that Docker is working by running `docker info` command. Docker Desktop allows you to build, run, and share containerized applications on Windows 10."
$choice = Read-Host "Do you want to proceed? (Y/N)"
if ($choice -eq "Y") {
    # Open the Docker Desktop install for Windows web page from Docker documentation
    Start-Process -FilePath "https://docs.docker.com/desktop/windows/install/"
    
    # Download the installer and check for errors
    $result = Invoke-WebRequest -Uri https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe -OutFile DockerDesktopInstaller.exe
    if ($result -like '*Error*') {
        # Print the error message and exit the script
        Write-Output "An error occurred while downloading the installer. See below for details."
        Write-Output $result
