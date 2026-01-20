
# All in One - Infrastructure as Code (IaC) and GitOps Setup in `Dockerfile`

## get all `.credentials` files ready before starting

    - [Place your OCI config file in `credentials/.oci/config`](./credentials/README.md#create-an-api-key)
    - TODO: ...

## Start

    - `docker compose up -d`
    - `docker compose exec aio /bin/bash`
        - `/workspace#  cd oci-infra/`
        - `/workspace#  terraform init`
            - For a `terraform` debug session without a `backend`
                - [To skip backend configuration, use `-backend=false` ...](https://developer.hashicorp.com/terraform/cli/commands/init#:~:text=To%20skip%20backend%20configuration%2C%20use%20%2Dbackend%3Dfalse)
        - `/workspace#  terraform apply`

---
## Misc

ssh key I generate on for this specially in the `.credentials/.ssh`-folder `ssh-keygen -t rsa -f ./credentials/.ssh/id_rsa`

### Commands in the OCI & Kubectl server

- point to a custom KUBECONFIG location: `KUBECONFIG=~/.kube/config kubectl get nodes`
- get kubeconfig manually: `oci ce cluster create-kubeconfig --cluster-id <cluster_id>`

---
## TODO: Deploy Services

### Deploy sealed-secrets

  - inside the **one container** `kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.32.2/controller.yaml`
  - `kubectl get pods -n kube-system` ✅
    - .. a lot of pods + `sealed-secrets-controller-xyz` Running


## Destroy on OCI

Sometimes you need to detach some ressource from an instance for exacmple VINC via the CLI
- https://docs.oracle.com/en-us/iaas/Content/Rover/Network/VNIC/detach_vnic.htm