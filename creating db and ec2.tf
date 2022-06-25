provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "proj2" {
  depends_on = [aws_db_instance.default]
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  subnet_id   = "subnet-0fec44469e446977c"
  key_name = "awsall"
  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint,password = aws_db_instance.default.password})
  security_groups = ["sg-08625c34c68a22785"]
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
  vpc_security_group_ids = ["sg-08625c34c68a22785"]
}
