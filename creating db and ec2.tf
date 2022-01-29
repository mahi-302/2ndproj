provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "proj2" {
  depends_on = [aws_db_instance.default]
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  subnet_id   = "subnet-08f3fd927977dc180"
  key_name = "Ec2all"
  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint,password = aws_db_instance.default.password})
  iam_instance_profile = "role_all"
  security_groups = ["sg-03723ff32a5606bda"]
  tags = {
    Name = "cpms"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "cpms"
  identifier           = "myrdb"
  username             = "admin"
  password             = "mahesh8842"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = ["sg-03723ff32a5606bda"]
}
