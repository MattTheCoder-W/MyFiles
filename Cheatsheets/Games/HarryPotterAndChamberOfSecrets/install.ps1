#Requires -RunAsAdministrator

Write-Output "[INFO] Script started!"

# Install chocolatey
$testchoco = powershell choco -v;
if (-not($testchoco)) {
    Write-Output "Installing Choco...";
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));
}
else {
    Write-Output "Choco already installed";
}

# Install gnupg
$testgpg = gpg --version;
if (-not($testgpg)) {
    Write-Output "GPG not installed! Installing it...";
    choco install gnupg;
}
else {
    Write-Output "GPG already installed!";
}

# Check if encrypted archive exists
if (Test-Path -Path HarryPotterII.tar.gz.gpg -PathType Leaf){
	Write-Output "[INFO] All files are present!";
}
else {
	Write-Output "[ERROR] Files not found!";
	exit;
}

# Decrypt archive
Write-Output "Decrypting archive -- HarryPotterII.tar.gz.gpg";
gpg --batch --yes --pinentry-mode=loopback --passphrase "HarryPotterII" -d -o HarryPotterII.tar.gz .\HarryPotterII.tar.gz.gpg

# Export archive
Write-Output "Extracting archive -- HarryPotterII.tar.gz";
tar xvf HarryPotterII.tar.gz

# Delete temp files
Write-Output "Deleting temp files";
rm HarryPotterII.tar.gz

# Goodbye
Write-Output "All installed! Now run configuration script.";

Write-Output "Launching Game, do not click anything in it!";
.\HarryPotterII\system\Game.exe;

Write-Output "Waiting to close game...";
for (($i = 8); $i -gt 0; $i--){
    Write-Output "$i";
    Start-Sleep -Seconds 1;
}

Write-Output "Closing game!";
Stop-Process -name Game -Force;

Write-Output "Checking files in $HOME\Documents\Harry Potter II directory"
if ((Test-Path -Path "$HOME\Documents\Harry Potter II\Game.ini","$HOME\Documents\Harry Potter II\User.ini" -PathType Leaf) -notcontains $false) {
    Write-Output "Config files generated!";
}
else {
    Write-Output "No configuration files found!";
    exit;
}
