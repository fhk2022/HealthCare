resource "aws_instance" "test-server" {
  ami           = "ami-0f5ee92e2d63afc18" 
  instance_type = "t2.medium" 
  key_name = "Project2"
  vpc_security_group_ids= ["sg-05f8ed67f2716ebff"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./Project2.pem")
    host     = self.public_ip
  }
  provisioner "local-exec" {
    command = "sleep 60 && echo 'Instance ready'"
  }
  tags = {
    Name = "prod-server"
  }
  provisioner "local-exec" {
    command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/HealthCare-Project/prod-server/kuberenetes-playbook.yml"
  } 
}
