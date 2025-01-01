### Scaling and Resilience

#### Implement Auto-Scaling:
- Define HPA rules to dynamically scale API pods based on resource usage.
- Configure Cluster Autoscaler to adjust the node count to meet demand without over-provisioning.

#### Enable High Availability:
- Deploy at least two replicas of the API pods to ensure redundancy.
- Use an AWS ALB to distribute traffic evenly across healthy pods.
- Enable RDS read replicas for scaling read-heavy operations.