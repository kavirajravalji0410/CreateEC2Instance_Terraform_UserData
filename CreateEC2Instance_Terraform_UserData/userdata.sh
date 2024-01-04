#!/bin/bash

# Install Apache
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>EC2 Instance with UserData using Terraform </h1>" | sudo tee /var/www/html/dotnetproject/index.html

# Install .NET Core 6.0
sudo yum install -y dotnet-sdk-6.0
# Update packages
sudo yum update -y

# Install mod_ssl
sudo yum install -y mod_ssl.x86_64

# Create directories in /var/www/html/dotnetproject
sudo mkdir -p /var/www/html/dotnetproject/{apis,angular,data}

# Create systemd services
sudo tee /etc/systemd/system/kestrel-api.service > /dev/null <<'EOF'
[Unit]
Description=API Kestrel Service
[Service]
WorkingDirectory=/var/www/html/dotnetproject/api
ExecStart=/usr/bin/dotnet  /var/www/html/dotnetproject/api/apiname.Api.dll --urls "http://localhost:5700" 
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
SyslogIdentifier=dotnet-kestrel
User=root
Environment=ASPNETCORE_ENVIRONMENT=test
[Install]
WantedBy=multi-user.target
EOF

# Create httpd.conf file
# sudo tee /etc/httpd/conf/httpd.conf > /dev/null <<'EOF'
# Your httpd.conf configuration goes here

EOF

# Reload systemd and start services
sudo systemctl daemon-reload
sudo systemctl enable kestrel-api.service
sudo systemctl start kestrel-api.service


# Restart Apache
sudo systemctl restart httpd
