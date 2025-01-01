
# Veeva Project

This repository contains various components related to the Veeva project, including an e-commerce application, its Helm chart for Kubernetes deployment, and Terraform scripts for infrastructure management.

## Repository Structure

- **documentation/**: Contains project documentation.
- **e-commerce-app/**: Helm chart for deploying the e-commerce application on Kubernetes.
- **e-commerce-app.source/**: Source code for the e-commerce application.
- **terraform/**: Terraform scripts for provisioning infrastructure.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started): To build and run the application locally.
- [Kubernetes](https://kubernetes.io/docs/setup/): For deploying the application.
- [Helm](https://helm.sh/docs/intro/install/): To manage Kubernetes applications.
- [Terraform](https://www.terraform.io/downloads.html): For infrastructure as code.

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/geek-kb/veeva_project.git
   cd veeva_project
   ```

2. **Build the e-commerce application**:

   Navigate to the `e-commerce-app.source` directory and follow the build instructions provided in its README.

3. **Deploy using Helm**:

   Navigate to the `e-commerce-app` directory and run:

   ```bash
   helm install e-commerce-app .
   ```

   Alternatively, add the Helm chart repository and install it from there:

   ```bash
   helm repo add geek-kb-repo https://geek-kb.github.io/helm-charts/
   helm repo update
   helm install release-name geek-kb-repo/e-commerce-app --namespace <target_namespace>
   ```

4. **Provision infrastructure with Terraform**:  
   **This is an unfinished part of the project**  
   Navigate to the `terraform` directory, edit the relevant `locals`.source, and execute:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Contributing

Contributions are welcome! Please fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries, please contact Itai Ganot at <admin@geek-kb.com>.
