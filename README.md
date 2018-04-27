# Provisioning AWS Spot Instances for Deep Learning

This is a demo repository containing terraform module for provisioning EC2-based Spot Instances on AWS, specifically for Deep Learning workloads on Amazon's GPU-based instances.

## Table of Contents
* [Requirements](#requirements)
* [Configurations](#configuration)
* [Quick Start](#quick-start)
* [Future Work](#future-work)
* [Other Resources](#other-resources)

## Requirements
* [terraform](https://www.terraform.io/)
* [aws-cli](https://aws.amazon.com/cli/)

## Configuration
This demo terraform script creates makes a Spot Instance request for a ```p2.xlarge``` in AWS and allows you to connect to a Jupyter notebook running on the server. This script could be more generic, but for now its only been tested on my own AWS setup, so I'm open to more contribution to the repo :)

In the ```variables.tf``` some of the variables you can set are:
    * myRegion          (default = us-east-1)
    * myKeyPair         (default = my-test)
    * instanceType      (default = p2.xlarge)
    * spotPrice         (default = 0.30)
    * ebsVolume         (default = 1)

**Note: The minimum spotPrice should follow the [AWS EC2 Spot Instances Pricing](https://aws.amazon.com/ec2/spot/pricing/), otherwise your request will not be fulfilled because the price is too low.**

## Quick Start
1. Check to see if Terraform is installed properly:
```
terraform
```
2. Initalize the working directory containing the Terraform configuration files:
```sh
terraform init
```

3. Create the terraform execution plan, which is an easy way to check what actions are needed to be taken to get the desired state:
```sh
terraform plan
```
    ** Note: This allows your to view the output configurations in the terminal, but you can also save the execution plan for debugging purposes as follows**

    ```sh
    terraform plan -refresh=true -input=False -lock=true -out=./proposed-changes.plan
    ```

    View the output from the ```.plan``` file in human-readable format:

    ```sh
    terraform show proposed-changes.plan
    ```

4. Provision the instance(s) by applying the changes to get the desired state based on the plan:
```
terraform apply
```

5. Login to your EC2 Management Console and you should see your [Spot Instance Request](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html) as shown below. You should also see all of the instances and  volumes that were provisioned.

## Future Work
TODO

## Other resources
TODO
