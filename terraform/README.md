# Structure
I decided to split the terraform provisioning in two parts.

* [cluster-infra](infra/) for everything leading to a functioning k8s API
* [[*optional] oracle mail delivery](infra/modules/email-delivery) to enable Email Delivery
    - Configures SMTP credentials and relay host for the postfix container
