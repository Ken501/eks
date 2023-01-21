<!-- Logos -->
<!-- ![Tomcat image](/.attachments/tomcat-logo.png =250x200) -->
![Monkey Typing](/.attachments/monkey.gif)

<!-- Intro -->
# Introduction
Repository for aws elastic kubernetes service project. Infrastructure terraform configuration files present. This project is still a work-in-progress

<!-- Dir Summary -->
# Directory Guide
* .attachments
  * Contains images and other miscellaneous for project
* Infrastructure
    * Stores Terraform configuration files
* test_manifests
  * Local yaml manifest files with starter deployments and services for testig cluster.
* yaml
    * Stores Microsoft Azure Devops Services CI/CD pipeline configuration files in yaml format

# Before Proceeding make sure to install the following:
* Install **latest** version of AWS eksctl
  * Instructions: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
* Install kubectl version **1.23.5**
  * Instructions: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
* Intall latest version of aws cli
  * https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# AWS IAM and Cluster Auth Instructions:
* Links:
  * https://docs.aws.amazon.com/eks/latest/userguide/view-kubernetes-resources.html#view-kubernetes-resources-permissions
  * https://kubernetes.io/docs/reference/access-authn-authz/rbac/
# Example commands to enable/authenticate IAM Role with eksctl to interact with cluster and view resources on AWS Console:
```
eksctl create iamidentitymapping \
--cluster <cluster-name> \
--region us-east-1 \
--profile <aws-profile> \
--arn arn:aws:iam::123456789012:role/<role-name> \
--group system:masters \
--username k8s-admin
```
* Within "**--profile**" this refers to locally configured aws cli profile to interact with correct AWS account. This name is subject to change depending on your local aws cli config profile.
## To retrieve identity mappings:
```
eksctl get iamidentitymapping \
--cluster <cluster-name> \
--region us-east-1 \
--profile <aws-profile>
```

<!-- kubeconfig commands -->
# KubeConfig
* To interact with a cluster configure the local kubeconfig by running the following command:
```
aws eks update-kubeconfig --region <region> --name <cluster-name> --profile <local aws profile>
```
* The above command will update the kubeconfig within ~$HOME/.kube

# Example:
```
aws eks update-kubeconfig \
--region=us-east-1 \
--name=<cluster-name> \
--profile=<aws-profile>
```

# kubectl autocomplete
```
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
```
#kubectl shorthand
```
alias k=kubectl
complete -o default -F __start_kubectl k
```
* To learn how to configure local aws profiles visit: 
   *  https://awscli.amazonaws.com/v2/documentation/api/latest/reference/configure/index.html
* For a full list of AWS ALB annotations visit: 
   * https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/ingress/annotations/#annotations
* Official AWS Ingress Conroller GitHub and documentation: 
   * https://github.com/kubernetes-sigs/aws-load-balancer-controller
   * How ingress controller works: https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/how-it-works/
* For all documentation regarding helm:
  * https://helm.sh/
  * https://bitnami.com/stacks/helm
  * https://github.com/bitnami/charts
  * https://helm.sh/docs/intro/install/

# Cheat Sheet
* Describe cluster resource
```
kubectl describe <api-resource>
```
* Get cluster resource
```
kubectl get <api-resource> -o wide
or
kubectl get <api-resource> -o yaml
```
* Create and delete pods
```
kubectl run nginx --image=nginx

kubectl delete pod nginx
```
* Create and delete deployments
```
kubectl create deployment nginx-deploy --image=nginx --replicas=2

kubectl delete deployment nginx-deploy
```
* Expose a deployment or pod cluster object
```
kubectl expose <api-resource> --name=http-svc --port=80 --type=NodePort
```

<!-- Dir Tree Structure -->
# Directory Tree Structure

```
│   .gitignore
│   README.md
│
├───.attachments
│       monkey.gif
│
├───infrastructure
│   │   backend.tf
│   │   cluster.tf
│   │   data.tf
│   │   deployment.tf
│   │   global-vars.tf
│   │   iam-test.tf
│   │   iam.tf
│   │   ingress-controller.tf
│   │   ingress.tf
│   │   locals.tf
│   │   netpol.tf
│   │   oidc.tf
│   │   output.tf
│   │   provider.tf
│   │   variables.tf
│   │
│   ├───policies
│   │       AWSLoadBalancerController.json
│   │
│   └───scripts
│           user-data.sh
│
└───yaml
    │   infrastructure-ci.yaml
    │
    └───templates
            infrastructure-cd.yml
```

# Terraform Resources
* EKS
* ALB