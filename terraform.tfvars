project_name = "youapp"

private_subnets = {
  us-central1 : { sub0 : "10.2.0.0/24", sub2 : "10.2.1.0/24" },
  us-east1 : { sub2 : "10.2.2.0/24", sub3 : "10.2.3.0/24" }
}

private_ip_address = [
  {
    name : "private-mysql"
    prefix_length : 24
    address : "192.168.21.0"
  },
  {
    name : "private-redis"
    prefix_length : 24
    address : "192.168.20.0"
  }
]

dbs = {
  db1 = {
    region                          = "us-central1"
    database_version                = "MYSQL_8_0"
    db_instance_tier                = "db-f1-micro"
    availability_type               = "REGIONAL"
    disk_type                       = "PD_SSD"
    disk_size                       = 20
    public_access                   = false
    private_service_connection_name = "private-mysql"
    deletion_protection             = false
    binary_log_enabled              = true
    backup_enable                   = true
    database                        = ["ss", "sss"]
    user                            = ["user1", "user2"]
  },
  db2 = {
    region                          = "us-central1"
    database_version                = "MYSQL_8_0"
    db_instance_tier                = "db-f1-micro"
    availability_type               = "REGIONAL"
    disk_type                       = "PD_SSD"
    disk_size                       = 20
    public_access                   = false
    private_service_connection_name = "private-mysql"
    deletion_protection             = false
    binary_log_enabled              = true
    backup_enable                   = true
    database                        = ["xx", "xxx"]
    user                            = ["user3", "user4"]
  }
}
