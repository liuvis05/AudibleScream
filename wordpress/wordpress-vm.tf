locals {
wordpress_custom_data = <<CUSTOM_DATA
#!/bin/sh
# Stop Firewall #and Disable it
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# PHP Install
sudo dnf install -y php-mysqlnd php-fpm mariadb-server httpd tar curl php-json
sudo systemctl enable httpd
sudo systemctl start httpd

# Wordpress Install
cd /var/www && sudo wget https://wordpress.org/latest.tar.gz
cd /var/www && sudo tar xvzf latest.tar.gz
cd /var/www && sudo rm -v latest.tar.gz
cd /var/www && sudo chown -Rf apache:apache ./wordpress/
cd /var/www && sudo chmod -Rf 775 ./wordpress/
cd /var/www && sudo semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/wordpress(/.*)?"
cd /var/www && sudo restorecon -Rv /var/www/wordpress

sudo echo "<VirtualHost *:80>" > /etc/httpd/conf.d/wordpress.conf
sudo echo "ServerAdmin root@localhost" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "DocumentRoot /var/www/wordpress" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "<Directory "/var/www/wordpress">" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "Options Indexes FollowSymLinks" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "AllowOverride all" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "Require all granted" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "</Directory>" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "ErrorLog /var/log/httpd/wordpress_error.log" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "CustomLog /var/log/httpd/wordpress_access.log common" >> /etc/httpd/conf.d/wordpress.conf
sudo echo "</VirtualHost>" >> /etc/httpd/conf.d/wordpress.conf


sudo systemctl restart httpd
CUSTOM_DATA  
}

resource "azurerm_network_interface" "wordpress_host_linuxvm_nic" {
  name                = "wordpress-host-linuxvm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "wordpress-host-ip-1"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Resource-3: Azure Linux Virtual Machine - wordpress Host
resource "azurerm_linux_virtual_machine" "wordpress_host_linuxvm" {
  name = "wordpress-linuxvm"
  #computer_name = "wordpresslinux-vm"  # Hostname of the VM (Optional)
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = "Standard_DS1_v2"
  admin_username = "azureuser"
  network_interface_ids = [ azurerm_network_interface.wordpress_host_linuxvm_nic.id ]
  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }
   custom_data = base64encode(local.webvm_custom_data) 
}

#resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "load_balancer_association" {
#  depends_on = [ azurerm_application_gateway.web_ag ] 
#  network_interface_id    = azurerm_network_interface.wordpress_host_linuxvm_nic.id
#  ip_configuration_name   = azurerm_network_interface.wordpress_host_linuxvm_nic.name
#  backend_address_pool_id = azurerm_application_gateway.web_ag.
#}