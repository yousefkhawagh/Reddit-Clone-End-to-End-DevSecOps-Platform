# REDDIT-PROJECT — Full DevOps CI/CD + GitOps + Monitoring on AWS EKS

This repository contains a **Next.js Reddit Clone** plus everything needed to deploy it on **AWS EKS** using:

- **Terraform** for infrastructure (EKS + optional Jenkins server)
- **Jenkins** for CI (build, scan, containerize, push image)
- **ArgoCD** for CD (GitOps auto-sync to EKS)
- **ALB Ingress + ACM + Route 53** for public HTTPS + custom domain
- **Prometheus + Grafana** for monitoring (kube-prometheus-stack)
- Security scanning: **SonarQube**, **OWASP Dependency-Check**, **Trivy**

---

## What this project does

### Application delivery (high level flow)
1. Developer pushes code to GitHub.
2. Jenkins pipeline runs:
   - install dependencies
   - SonarQube scan + quality gate
   - OWASP dependency scan
   - Trivy filesystem scan
   - Docker build + push to DockerHub with a version tag (BUILD_NUMBER)
   - update Kubernetes manifest image tag in `K8s/deployment.yml` and push it to GitHub
3. ArgoCD detects the Git change in `K8s/` and **auto-deploys** the new version to EKS.
4. The app is exposed via AWS ALB Ingress with HTTPS (ACM cert) and Route 53 DNS.
5. Monitoring stack (Prometheus + Grafana) is deployed and managed via GitOps or Helm.

