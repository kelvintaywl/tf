# tf
Learning Terraform


**Note**: I have aliased `terraform` to `tf`.

```console

# Set up

$ tf init

$ tf fmt
$ tf validate

# Run

$ tf plan -var "postgresdb_container_mount_source=dummy"

$ tf apply -var "postgresdb_container_mount_source=$(pwd)/postgres/init" -auto-approve

# Test

$ docker container run --network learntf \
            -v $(pwd)/postman_collections:/etc/newman -t postman/newman run /etc/newman/Postgrest.json

# Teardown

$ tf destroy apply -var "postgresdb_container_mount_source=dummy" -auto-approve
```
