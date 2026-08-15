resource "null_resource" "ansible_provisioner" {
  for_each = module.vmlinux.linux_vm_ids

  depends_on = [
    module.network,
    module.common,
    module.vmlinux,
    module.vmwindows,
    module.datadisk,
    module.loadbalancer,
    module.database
  ]

  triggers = {
    linux_vm_id = each.value
  }

  provisioner "local-exec" {
    working_dir = path.root

    command = <<-EOT
      if [ "${each.key}" = "linux1" ]; then

        echo "Generating Ansible inventory from Terraform outputs..."

        cat > ansible/inventory.ini <<INVENTORY
[linux]
vm1 ansible_host=${module.vmlinux.linux_fqdns["linux1"]} vm_number=1 node_fqdn=${module.vmlinux.linux_fqdns["linux1"]}
vm2 ansible_host=${module.vmlinux.linux_fqdns["linux2"]} vm_number=2 node_fqdn=${module.vmlinux.linux_fqdns["linux2"]}
vm3 ansible_host=${module.vmlinux.linux_fqdns["linux3"]} vm_number=3 node_fqdn=${module.vmlinux.linux_fqdns["linux3"]}

[linux:vars]
ansible_user=${var.admin_username}
ansible_ssh_private_key_file=${var.ssh_private_key_path}
ansible_connection=ssh
INVENTORY

        echo "Waiting for Linux virtual machines to become reachable..."

        for host in \
          "${module.vmlinux.linux_fqdns["linux1"]}" \
          "${module.vmlinux.linux_fqdns["linux2"]}" \
          "${module.vmlinux.linux_fqdns["linux3"]}"
        do
          echo "Checking SSH connectivity to $${host}..."

          until ssh \
            -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            -o ConnectTimeout=10 \
            -i "${var.ssh_private_key_path}" \
            "${var.admin_username}@$${host}" \
            "echo SSH ready"
          do
            echo "Waiting for $${host}..."
            sleep 10
          done
        done

        echo "All Linux hosts are reachable."
        echo "Starting Ansible configuration..."

        cd ansible
        ansible-playbook n01276909-playbook.yml

      else
        echo "Ansible execution handled by linux1 provisioner instance."
      fi
    EOT
  }
}
