
# Create an API Key

Inside the Identity Area of the Oracle Cloud Console, follow these steps:

- https://cloud.oracle.com/identity/domains/my-profile/auth-tokens
    - Click `Add API key`
    - Select any Option: For simpicity we pick "Generate API key pair"
        - Click "Download private key" -> copy it to `./credentials/.oci/oci_api_key.pem`
        - Click "Download public key" -> copy it to `./credentials/.oci/oci_api_key_public.pem`
    - Click add & copy the `config`-File -> `./credentials/.oci/config`
        - replace the public key in the #TODO placeholder

# Setup OCI CLI

Mostly the OCI CLI will complain about 

> WARNING: Permissions on /root/.oci/config are too open. 
> To fix this please try executing the following command: 
> oci setup repair-file-permissions --file /root/.oci/config 
> Alternatively to hide this warning, you may set the environment variable, > OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING:
> `export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True`

[You can also enable this setting in the docker-compose.yaml file by uncommenting the environment variable](./compose.yaml#L24)

## Test it:

`oci iam user list --all`

should return the current User information in JSON format of your initial user.

## [Back to get k8s Up](../README.md#setup-k8s-cluster)
