#!/bin/bash

# Install Apache
sudo yum install -y httpd

# Install .NET Core 6.0
sudo yum install -y dotnet-sdk-6.0
# Install EPEL repository
sudo amazon-linux-extras install -y epel
# Update packages
sudo yum update -y
# Install libgdiplus
sudo yum install -y libgdiplus
# Install Microsoft packages repository
sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
# Install mod_ssl
sudo yum install -y mod_ssl.x86_64

# Create directories in /var/www/html/lendingclouds
sudo mkdir -p /var/www/html/lendingclouds/{apis,borrower,branch,crm,crmapi,enswf,looverlay,new-borrower}

# Create systemd services
sudo tee /etc/systemd/system/kestrel-crmapi.service > /dev/null <<'EOF'
[Unit]
Description=CRM API Kestrel Service
[Service]
WorkingDirectory=/var/www/html/lendingclouds/crmapi
ExecStart=/usr/bin/dotnet /var/www/html/lendingclouds/crmapi/CRM.Api.dll --urls "http://localhost:5700" 
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
SyslogIdentifier=dotnet-kestrel
User=root
Environment=ASPNETCORE_ENVIRONMENT=swf-test
[Install]
WantedBy=multi-user.target
EOF

sudo tee /etc/systemd/system/kestrel-lcapp.service > /dev/null <<'EOF'
[Unit]
Description=LC App Kestrel Service
[Service]
WorkingDirectory=/var/www/html/lendingclouds/lcapp
ExecStart=/usr/bin/dotnet /var/www/html/lendingclouds/lcapp/LOOverlay.Api.dll --urls "http://localhost:5600"
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
SyslogIdentifier=dotnet-kestrel
User=root
Environment=ASPNETCORE_ENVIRONMENT=swf-test
[Install]
WantedBy=multi-user.target
EOF

sudo tee /etc/systemd/system/kestrel-swfcorpapi.service > /dev/null <<'EOF'
[Unit]
Description=SWF Corp API Kestrel Service
[Service]
WorkingDirectory=/var/www/html/lendingclouds/swfcorpapi
ExecStart=/usr/bin/dotnet /var/www/html/lendingclouds/swfcorpapi/CorporateWebsite.API.dll --urls "http://localhost:6000" 
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
SyslogIdentifier=dotnet-kestrel
User=root
Environment=ASPNETCORE_ENVIRONMENT=swf-test
[Install]
WantedBy=multi-user.target
EOF

# Create httpd.conf file
# sudo tee /etc/httpd/conf/httpd.conf > /dev/null <<'EOF'
# Your httpd.conf configuration goes here

EOF

# Reload systemd and start services
sudo systemctl daemon-reload
sudo systemctl enable kestrel-crmapi.service
sudo systemctl start kestrel-crmapi.service
sudo systemctl enable kestrel-lcapp.service
sudo systemctl start kestrel-lcapp.service
sudo systemctl enable kestrel-swfcorpapi.service
sudo systemctl start kestrel-swfcorpapi.service

# Restart Apache
sudo systemctl restart httpd
