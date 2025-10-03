output "ec2_public_ip" {
  value = [for inst in aws_instance.instance : inst.public_ip]
}

output "ec2_public_dns" {
  value = [for inst in aws_instance.instance : inst.public_dns]
}