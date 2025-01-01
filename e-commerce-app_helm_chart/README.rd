# e-commerce-app Helm Chart

This Helm chart deploys the e-commerce application along with its required components, such as a database, persistent storage, and configuration secrets.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PersistentVolume provisioner support in the underlying infrastructure

## Chart Details

This chart deploys the following components:

- Application deployment
- Database deployment
- Secrets and ConfigMaps for environment variables and credentials
- PersistentVolume and PersistentVolumeClaim for database storage
- Kubernetes services for application and database

## Installing the Chart

To install the chart with the release name `ecomapp` in the namespace `app`:

```bash
helm install ecomapp ./e-commerce-app --namespace app --create-namespace
```

### Customizing Values

You can customize the chart by overriding the default values in `values.yaml`. For example:

```bash
helm install ecomapp ./e-commerce-app \
  --namespace app \
  --create-namespace \
  --set app.replicaCount=3 \
  --set app.image.tag="2.0"
```

Alternatively, you can use a custom `values.yaml` file:

```bash
helm install ecomapp ./e-commerce-app --namespace app --create-namespace -f custom-values.yaml
```

## Uninstalling the Chart

To uninstall the chart:

```bash
helm uninstall ecomapp --namespace app
```

This will remove all the resources created by the chart. Note that the namespace will not be deleted.

## Configuration

The following table lists the configurable parameters of the chart and their default values:

| Parameter                              | Description                                | Default                   |
|----------------------------------------|--------------------------------------------|---------------------------|
| `namespace.create`                     | Whether to create the namespace           | `false`                   |
| `app.name`                             | Name of the application                   | `app`                     |
| `app.replicaCount`                     | Number of application replicas            | `1`                       |
| `app.image.repository`                 | Application container image repository    | `camelel/e-commerce-app`  |
| `app.image.tag`                        | Application container image tag           | `latest`                  |
| `app.image.pullPolicy`                 | Application container image pull policy   | `Always`                  |
| `app.containerPort`                    | Application container port                | `8080`                    |
| `app.resources.requests.cpu`           | CPU request for application pod           | `100m`                    |
| `app.resources.requests.memory`        | Memory request for application pod        | `256Mi`                   |
| `app.resources.limits.cpu`             | CPU limit for application pod             | `200m`                    |
| `app.resources.limits.memory`          | Memory limit for application pod          | `512Mi`                   |
| `db.name`                              | Name of the database deployment           | `db`                      |
| `db.replicaCount`                      | Number of database replicas               | `1`                       |
| `db.image.repository`                  | Database container image repository       | `camelel/e-commerce-db`   |
| `db.image.tag`                         | Database container image tag              | `latest`                  |
| `db.containerPort`                     | Database container port                   | `3306`                    |
| `pv.name`                              | Name of the PersistentVolume              | `mysql-pv`                |
| `pv.capacity`                          | Storage capacity of the PersistentVolume  | `1Gi`                     |
| `pvc.name`                             | Name of the PersistentVolumeClaim         | `mysql-pvc`               |
| `pvc.storage`                          | Requested storage size                    | `1Gi`                     |
| `appSecret.name`                       | Name of the application secret            | `db-appuser-creds`        |
| `rootSecret.name`                      | Name of the root database secret          | `db-root-creds`           |

## Accessing the Application

Once deployed, the application can be accessed via the Kubernetes service created:

- **Type:** ClusterIP
- **Port:** 8080

If you want external access, you need to modify the service type to `NodePort` or `LoadBalancer` in `values.yaml`.

## Icon

The chart includes an icon that visually represents the e-commerce application:

![e-commerce Icon](https://i.postimg.cc/t4mjFV29/ecommerce-icon-64x64.png)

## Notes

Ensure that all required secrets, such as database credentials, are configured before deploying the chart.

