resource "aws_instance" "web" {
    ami = "ami-0cff7528ff583bf9a"
    instance_type="t2.micro"
    key_name = "trail1"
    for_each = toset(["master", "slave", "ansible_host"])
    tags={
        Name="${each.key}"
    }
    
}

