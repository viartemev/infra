data "template_file" "inventory" {
  template = <<EOF
${join("\n", formatlist("%s ansible_host=%s ext_ip=%s int_ip=%s", hcloud_server.vm.name, hcloud_server.vm.ipv4_address, hcloud_server.vm.ipv4_address, hcloud_server_network.network.ip  ))}

[nhl]
${join("\n", formatlist("%s", hcloud_server.vm.name))}
EOF
}

output "inventory" {
  value = data.template_file.inventory.rendered
}
