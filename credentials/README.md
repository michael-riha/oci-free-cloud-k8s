
# Credentials & Secrets

This directory contains sensitive information and credentials required for various services and tools used in the project. Please ensure that all files in this directory are kept secure and are not committed to version control.

Primarily we need to access:

- Oracle Cloud Infrastructure (OCI)
  - needed for:
        - `Terraform`
        - `kubectl`
- GitHub
  - needed for:
        - `gitOps` (ArgoCD)

## Oracle Cloud Infrastructure (OCI)

To access Oracle Cloud Infrastructure (OCI), you need to:

1. Create an OCI config file with your account details

2. Place the OCI config file in `credentials/.oci/config`

3. Ensure the file has the correct permissions (readable only by the owner)

### Create an API Key

Inside the Identity Area of the Oracle Cloud Console, follow these steps:

- https://cloud.oracle.com/identity/domains/my-profile/auth-tokens
    - Click `Add API key`
    - Select any Option: For simpicity we pick "Generate API key pair"
        - Click "Download private key" -> copy it to `./credentials/.oci/oci_api_key.pem`
        - Click "Download public key" -> copy it to `./credentials/.oci/oci_api_key_public.pem`
    - Click add & copy the `config`-File -> `./credentials/.oci/config`
        - replace the public key in the #TODO placeholder

### Setup OCI CLI

Mostly the OCI CLI will complain about 

> WARNING: Permissions on /root/.oci/config are too open. 
> To fix this please try executing the following command: 
> oci setup repair-file-permissions --file /root/.oci/config 
> Alternatively to hide this warning, you may set the environment variable, > OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING:
> `export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True`

[You can also enable this setting in the docker-compose.yaml file by uncommenting the environment variable](./compose.yaml#L23)

#### Test it:

`oci iam user list --all`

should return the current User information in JSON format of your initial user.

#### Possible already create a Bucket

`oci os bucket create --name terraform-states --versioning Enabled --compartment-id <from ./.oci/config -> tenancy value>`

##### Delete right away as it is part in the main README.md

`oci os bucket delete --name terraform-states`

### Educate yourself:

The official Command Reference https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/index.html

# [Back to get k8s Up 🚀](../README.md#:~:text=create%20a%20bucket-,initially,-%3A)

## GitHub

TODO: describe how to generate ssh-key for github access to be used by Argo!

