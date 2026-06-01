# Infrastructure Automation — Module Intro

## The Problem with Raw API Calls

- Calling the Cloud API from code is powerful but has maintainability challenges
- A program could have dozens of locations that call the API to create VMs — tracking down which call created a specific resource is difficult
- Applications change rapidly, requiring constant code maintenance
- Infrastructure quality becomes directly tied to code quality

---

## What Terraform Solves

- Uses **highly structured templates and configuration files** to define infrastructure in a readable, understandable format
- **Conceals the underlying Cloud API calls** — you focus on defining what you want, not how to call the API
- Infrastructure is documented as code, making it easy to review, version, and maintain

---

## What This Module Covers

- How to use **Terraform** to automate infrastructure deployment
- How to use **Google Cloud Marketplace** to launch infrastructure solutions
- Lab: use Terraform to deploy a **VPC network, firewall rule, and VM instances**
