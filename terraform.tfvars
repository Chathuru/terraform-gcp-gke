project_name = "youapp"

private_subnets = {
  us-central1 : {sub0 : "10.2.0.0/24", sub2 : "10.2.1.0/24"},
  us-east1 : {sub2 : "10.2.2.0/24", sub3 : "10.2.3.0/24"}
}
private_ip_address = [
    {
      name: "private-mysql"
      prefix_length: 24
    },
    {
      name: "private-redis"
      prefix_length: 24
      address: "192.168.20.0"
    }
  ]
