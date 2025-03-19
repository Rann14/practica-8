Vagrant.configure("2") do |config|
  # Definir la máquina virtual y el sistema operativo
  config.vm.box = "ubuntu/bionic64"  # Usa Ubuntu 18.04 LTS
  
  # Configurar la IP estática
  config.vm.network "private_network", ip: "192.168.56.10"

  # Compartir la carpeta local con el servidor Apache
  config.vm.synced_folder "./html", "/var/www/html"

  # Configuración de la máquina virtual
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
    vb.cpus = 1
  end

  # Configurar la provisión para instalar Apache
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl enable apache2
    sudo systemctl restart apache2
  SHELL
end
