variable "region" {
    default = "us-east-1"
}
variable "web_ingress" {
    type = map(object({
        port = number
        protocol = string
        cidr_blocks = list(string)
    }))
    default = {
        "80" = {
            port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}