# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
SCRIPT

$script2 = <<-SCRIPT
New-NetFirewallRule -DisplayName "Allow WinRm HTTP Port 5985" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "Allow WinRm HTTP Port 5986" -Direction Inbound -LocalPort 5986 -Protocol TCP -Action Allow
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define "tfs" do |tfs|
    tfs.vm.box = "Windows_2012_R2_Core"
    tfs.vm.communicator = "winrm"
    tfs.vm.network "private_network", ip: "192.168.50.10"
    
    tfs.vm.provider :virtualbox do |vb|
        vb.name = "tfs-server"
        vb.gui = false
        vb.memory = "2048"
    end
    
    tfs.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: $script
    tfs.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: $script2
    
    #tfs.vm.provision "ansible" do |ansible|
    #    ansible.compatibility_mode = "2.0"
    #    ansible.playbook = "playbooks/tfs.yml"
    #end
    
  end
  
  config.vm.define "db" do |db|
    db.vm.box = "generic/alpine312"
    db.vm.network "private_network", ip: "192.168.50.11"
    
    db.vm.provider :virtualbox do |vb|
        vb.name = "tfs-db"
        vb.gui = false
        vb.memory = "2048"
    end
  end

end
