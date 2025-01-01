# Cloud-Native Infrastructure Design and Implementation @ Veeva

## High-Level Components and Responsibilities
### Web Frontend:
- Framework: React.js
[Why React.js?](docs/react_js.md)

### Hosting: 
- CloudFront for distribution, S3 for static asset storage
[Why CloudFront and S3?](docs/cloudfront_s3.md)

## RESTful API Backend:
- Framework: Flask/Django (Python)
[Why Python Flask?](docs/python_flask.md)

### Hosting: EKS
[Why EKS?](docs/eks.md)

### Security
#### IAM
   * **Least Privilege Access**:
     * Assign minimal permissions required for each role or service.
   * **IAM Roles for Service Accounts (IRSA)**:
     * In EKS, map Kubernetes service accounts to IAM roles for secure AWS resource access.
   * **Multi-Factor Authentication (MFA)**:
     * Enforce MFA for user accounts with administrative privileges.
   * **Strong Password Policies**:
     * Enforce complex passwords and regular rotation.
#### Network Security:
   * **Private Subnets**:
     * Place sensitive services, such as databases and EKS worker nodes, in private subnets.
   * **Securiy Groups**:
     * Use restrictive rules to allow traffic only from trusted sources.
   * **Network Policies**:
     * In Kubernetes, define network policies to control traffic between pods and namespaces.
   * **VPC Flow Logs**:
     * Monitor and analyze VPC traffic for anomalies.
#### **Data Security**
   * **Encryption at Rest**:
     * Encrypt all sensitive data in storage, including EBS volumes, S3 buckets, and RDS databases, using AWS KMS ([Encryption at Rest](docs/eks_encryption_at_rest.md)).
   * **Encryption in Transit**:
     * Use SSL/TLS for secure data transmission between services and with external clients.
   * **Secrets Management**:
     * Store sensitive credentials in AWS Secrets Manager or Kubernetes Secrets, encrypted using KMS.
#### **Application Security**
   * **Input Validation**:
     * Sanitize and validate all user inputs to prevent injection attacks like SQL injection or XSS.
   * **API Gateway Protection**:
     * Use AWS API Gateway with throttling, rate limiting, and WAF rules to protect APIs.
   * **Secure Defaults**:
     * Disable unnecessary services, ports, and endpoints.
#### **Runtime Security**
   * **Falco**:
     * Use Falco to monitor and detect malicious or suspicious activity in Kubernetes at runtime.
   * **Pod Security Standards (PSS)**:
     * Apply Kubernetes security policies to restrict pod privileges and capabilities.
   * **Container Hardening**:
     * Use minimal base images, scan for vulnerabilities, and apply patches regularly.
   * **Read-Only File Systems**:
     * Configure containers with read-only file systems to prevent unauthorized changes.
#### **Monitoring and Logging**
   * **Centralized Logging**:
     * Aggregate logs from all services using tools like CloudWatch, ELK Stack, or Prometheus/Grafana.
   * **Real-Time Alerts**:
     * Set up alerts for critical security events like unauthorized access attempts or resource anomalies.
   * **Audit Logs**:
     * Enable and review AWS CloudTrail logs for API activity and AWS Config for resource changes.
#### **Web Application Firewall (WAF)**
   * Deploy AWS WAF to block common attack patterns such as SQL injection, cross-site scripting, and brute force attacks.
#### **Security Testing**
   * **Vulnerability Scanning**:
     * Use tools like Trivy, Clair, or Aqua Security to scan container images and dependencies.
   * **Penetration Testing**:
     * Conduct regular penetration tests to identify and fix vulnerabilities.
   * **CI/CD Pipeline Security**:
     * Integrate security checks in your CI/CD pipeline to catch issues early.
#### **Regular Updates and Patching**
   * **Patch Management**:
     * Regularly update Kubernetes versions, container images, and dependencies.
   * **Security Bulletins**:
     * Monitor and apply updates from AWS security bulletins and Kubernetes advisories.
#### **Secure User Authentication**
   * **AWS Cognito**:
     * Use AWS [Cognito](docs/cognito.md) for secure user authentication and management.
   * **Token-Based Access**:
     * Implement JWTs for API authentication and validate them on the server side.


## Configurations:
- [EKS Configuration](config/eks.md)
- [EKS Integration with RDS Database](config/eks_rds.md)
- [Monitoring and Logging](config/monitoring_logging.md)
- [Scaling and Resilience](config/scaling.md)

## Infrastructure as Code - Terraform
[Terraform suggested design](config/terraform_structure.md)


### Future Enhancements

#### Plan for Future Enhancements:
- Introduce **service mesh** (e.g., Istio) for advanced service-to-service communication, observability, and traffic control.
- Add support for **GraphQL** alongside REST for more flexible API consumption.
- Explore **multi-region EKS deployments** for disaster recovery and improved latency for global users.