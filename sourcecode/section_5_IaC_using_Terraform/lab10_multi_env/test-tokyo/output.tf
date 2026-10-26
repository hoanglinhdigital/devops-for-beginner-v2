output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "instance_public_ip" {
  value = module.compute.instance_public_ip
}

output "instance_private_ip" {
  value = module.compute.instance_private_ip
}
