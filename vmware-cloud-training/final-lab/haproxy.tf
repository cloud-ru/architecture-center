# haproxy

resource "null_resource" "haproxy" {
  depends_on = [vcd_vapp_vm.flab-vm-app]

  connection {
    host = data.vcd_nsxt_edgegateway.nsxt-edge.primary_ip
    user = var.ssh_user
    password = var.ssh_password
  }

  provisioner "remote-exec" {
    inline = [
      "tdnf install haproxy -y -q || true",
      "chmod 777 /etc/haproxy/haproxy.cfg",
      "echo -e 'global \n daemon \n maxconn 256 \n defaults \n mode http \n timeout client 30s \n timeout server 30s \n timeout connect 30s \n  listen stats \n bind ${var.flab_app_ip-01}:80 \n stats enable \n option httpclose \n stats uri / \n stats refresh 2s \n stats show-legends \n frontend web \n bind 0.0.0.0:80 \n default_backend backend \n backend backend \n balance roundrobin \n server web1 ${var.flab_web_ip-02}:80 check \n server web2 ${var.flab_web_ip-02}:80 check' > /etc/haproxy/haproxy.cfg",
      "systemctl start haproxy",
      "mkdir /tmp/node && cd /tmp/node",
      "echo '<style> body { background-color: green; } </style> <h1 align='center'> flab web server 1 </h1>' > index-01.html",
      "echo '<style> body { background-color: yellow; } </style> <h1 align='center'> flab web server 2 </h1>' > index-02.html",
      "tdnf install sshpass -y -q || true",
      "sshpass -p ${var.ssh_password} scp -o StrictHostKeyChecking=no /tmp/node/index-01.html ${var.ssh_user}@${var.flab_web_ip-01}:/tmp/node/index.html",
      "sshpass -p ${var.ssh_password} scp -o StrictHostKeyChecking=no /tmp/node/index-02.html ${var.ssh_user}@${var.flab_web_ip-02}:/tmp/node/index.html",
    ]
  }
}