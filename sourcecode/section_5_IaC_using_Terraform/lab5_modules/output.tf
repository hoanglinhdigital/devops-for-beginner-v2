output "instance_public_ip" {
  value = module.compute.instance_public_ip
}

output "instance_private_ip" {
  value = module.compute.instance_private_ip
}

output "public_security_group_id" {
  value = module.security.public_security_group_id
}

output "private_security_group_id" {
  value = module.security.private_security_group_id
}
