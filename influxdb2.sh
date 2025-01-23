#!/bin/bash

# Exit on error
set -e

# Variables
INFLUXDB_USER="admin"
INFLUXDB_PASSWORD="Hdl%ljse#6K"
INFLUXDB_ORG="adz"
INFLUXDB_BUCKET="adz_test"

echo "Step 1: Adding the InfluxDB GPG key."
curl -fsSL https://repos.influxdata.com/influxdata-archive_compat.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg

echo "Step 2: Adding the InfluxDB repository."
echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main" | tee /etc/apt/sources.list.d/influxdb.list

echo "Step 3: Updating the package."
apt update

echo "Step 4: Installing InfluxDB and Python pip."
apt install -y influxdb2 python3-pip

echo "Step 5: Enabling and starting the InfluxDB service."
systemctl enable --now influxdb

echo "Step 6: Configuring InfluxDB for the first time"
if [ ! -f /etc/influxdb/.setup ]; then
  influx setup --username "$INFLUXDB_USER" --password "$INFLUXDB_PASSWORD" --org "$INFLUXDB_ORG" --bucket "$INFLUXDB_BUCKET" --force
  touch /etc/influxdb/.setup
  echo "InfluxDB setup completed successfully."
else
  echo "InfluxDB is already configured. Skipping setup."
fi

echo "Step 7: Verifying the InfluxDB installation..."
if influx ping; then
  echo "InfluxDB is installed and running!"
else
  echo "Error: Unable to connect to InfluxDB!"
  exit 1
fi
