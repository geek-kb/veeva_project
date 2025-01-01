#### EKS Configuration
- Use managed node groups for worker nodes (mixed on-demand and spot instances for cost optimization).
- Enable auto-scaling for both nodes and pods:
  - **Cluster Autoscaler**: Automatically adjusts the number of nodes in a cluster based on resource demands.
  - **Horizontal Pod Autoscaler (HPA)**: Scales API pods based on CPU, memory usage, or custom metrics.

#### Define Kubernetes Resources:
- **Deployment**:
  - Replica count: Minimum 2 pods for high availability.
  - Resources: Define CPU and memory limits for efficient resource usage.
- **Service**:
  - Type: LoadBalancer for external access via AWS ALB.
  - Internal: ClusterIP for internal microservice communication.
- **ConfigMaps and Secrets**:
  - ConfigMaps: Store application configurations.
  - Secrets: Secure sensitive information (e.g., database credentials, API keys).
- **Ingress Controller**:
  - Use AWS ALB Ingress Controller for managing API routes.
  - Configure SSL/TLS for secure communication.

#### Configure Networking:
- Use private subnets for EKS nodes to restrict external access.
- Associate the EKS cluster with a VPC for secure communication.
- Define **Network Policies** to restrict inter-service communication as needed.

#### Enforce Security:
- Use Kubernetes **Role-Based Access Control (RBAC)** to manage API access permissions.
- Configure **Pod Security Policies** to restrict container privileges and ensure security best practices.
- Use IAM **Roles for Service Accounts (IRSA)** to grant pods fine-grained access to AWS services.
- Enable auditing and install [Falco](https://falco.org/) to enrich event data with contextual metadata to deliver real-time alerts.
- Enable [Encryption at rest](docs/eks_encryption_at_rest.md).