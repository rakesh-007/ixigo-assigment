* Use terraform 0.11 Version to Create AWS Infra
* Create a S3 Bucket to Store State file.
* Update the bucket configuration in s3.tf file.
* terraform init :- to install the required plugins
* terraform plan :- to check what infra will be created
* terraform apply :- to make the changes 
base-infra :-
1. Create a VPC of 10.70.0.0/16
2. Create 6 subnets :-
   * 2 Public Subnets
   * 2 Private Subnets
   * 2 DB Subnets
3. Create One Public Load Balancer and One Private Load Balancer

Components :-
1. Jenkins :- Installed Jenkins on ec2 Machine.
2. Kubernetes Cluster :- Launched 3 VM for Kubernetes Cluster.

