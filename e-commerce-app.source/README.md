
# E-Commerce Application

This repository contains the source code and deployment configurations for the e-commerce application. It includes the application logic, database setup, and Kubernetes deployment manifests.

## Directory Structure

```plaintext
.
├── app
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   └── templates
│       ├── index.html
│       └── register.html
├── db
│   ├── Dockerfile
│   └── init.sql
└── k8s
    ├── app
    │   ├── app-deployment.yaml
    │   └── app-service.yaml
    └── db
        ├── db-config-map.yaml
        ├── db-deployment.yaml
        ├── db-pv.yaml
        ├── db-pvc.yaml
        └── db-service.yaml
```

## Contents

### `/app`
This directory contains the application code and related resources.

- **`app.py`**: The main Python script for the web application.
- **`requirements.txt`**: List of Python dependencies required to run the application.
- **`Dockerfile`**: Instructions to build the Docker image for the application.
- **`templates/`**:
  - **`index.html`**: Template for the homepage.

### `/db`
Contains the database configuration and initialization files.

- **`init.sql`**: SQL script for initializing the database schema and data.
- **`Dockerfile`**: Docker image definition for the database.

### `/k8s`
Kubernetes deployment manifests for the application and database.

- **`app/`**:
  - **`app-deployment.yaml`**: Deployment configuration for the application.
  - **`app-service.yaml`**: Service definition to expose the application.
- **`db/`**:
  - **`db-config-map.yaml`**: ConfigMap for database environment variables.
  - **`db-deployment.yaml`**: Deployment configuration for the database.
  - **`db-pv.yaml`**: Persistent Volume definition for the database storage.
  - **`db-pvc.yaml`**: Persistent Volume Claim for the database storage.
  - **`db-service.yaml`**: Service definition to expose the database.

## Getting Started

### Prerequisites
- **Docker**: To build and run container images.
- **Kubernetes**: A running Kubernetes cluster to deploy the application.
- **kubectl**: CLI tool for interacting with the Kubernetes cluster.

### Setup Instructions

#### 1. Build Docker Images
Navigate to the respective directories to build the Docker images for the application and database:

```bash
# Build application image
cd app
docker build -t e-commerce-app .

# Build database image
cd ../db
docker build -t e-commerce-db .
```

#### 2. Deploy to Kubernetes
Apply the Kubernetes manifests to deploy the application and database:

```bash
# Deploy the database components
kubectl apply -f k8s/db/

# Deploy the application components
kubectl apply -f k8s/app/
```

#### 3. Access the Application
Retrieve the service details to access the application:

```bash
kubectl get services
```

Use the external IP or NodePort provided to access the application in your browser.

## Notes
- Ensure your Kubernetes cluster has sufficient resources to deploy the components.
- Modify configuration files as per your environment needs (e.g., database credentials, resource limits).
- For production deployments, consider using persistent storage and enabling security configurations.

---

Developed with ❤️ by Itai Ganot, 2024.
