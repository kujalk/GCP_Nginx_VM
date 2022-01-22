#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y nginx-light jq

NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<style>
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
      }

      th:nth-child(even),td:nth-child(even) {
        background-color: #D6EEEE;
      }

      table.center {
        margin-left: auto; 
        margin-right: auto;
      }
</style>
<body>

<h2 style="background-color:DodgerBlue;text-align: center">Hello!, I have been created from your GCP Modules</h2>

<table style="width:50%" class="center">
  <tr>
    <th>Server Name</th>
    <th>Private IP Address</th>
  </tr>
  <tr>
    <td>$NAME</td>
    <td>$IP</td>
  </tr>
</table>

</body>
</html>
EOF