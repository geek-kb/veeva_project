### How Encryption at Rest Works in EKS

#### **Kubernetes Secrets Encryption**
- **Kubernetes Secrets**:
  - Kubernetes secrets are encrypted at rest when stored in the etcd database.
- **AWS Key Management Service (KMS)**:
  - EKS integrates with AWS KMS to provide an additional layer of security by encrypting secrets using a KMS Customer Master Key (CMK).
  - Encryption is enabled by specifying a KMS key during EKS cluster creation or configuration.

#### **Persistent Volume Encryption**
- **Amazon EBS Volumes**:
  - EBS volumes backing Kubernetes persistent volumes can be encrypted at rest.
  - EBS encryption uses AWS KMS keys to secure data and supports seamless integration without requiring application-level changes.
- **Amazon Elastic File System (EFS)**:
  - EFS volumes can also be encrypted at rest using AWS KMS.

#### **Amazon S3 Encryption**
- For applications that use S3 buckets in conjunction with EKS, server-side encryption (SSE) can be applied to ensure data stored in S3 is encrypted at rest.

#### **Other Managed Services**
- Data stored in services like Amazon RDS or DynamoDB, often used with EKS applications, can also be encrypted at rest using KMS.
