<p align="center">
 <img src="/static/img/influx.png" width="550">
</p>

# InfluxDB Role

This role installs and securely configures InfluxDB v2 with the following:

- Creates a default admin user.
- Sets up an organization and a bucket with a retention policy.

## Variables

- `influxdb_version`: Version of InfluxDB to install.
- `influxdb_bucket`: Name of the bucket to create.
- `influxdb_org`: Name of the organization to create.
- `influxdb_admin_user`: Admin username.
- `influxdb_admin_password`: Admin password.
- `influxdb_retention_period`: Retention period for the bucket.

## Usage

Include the role in your playbook:

```yaml
- hosts: all
  roles:
    - influxdb
