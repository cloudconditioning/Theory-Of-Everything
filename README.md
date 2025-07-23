# Theory-Of-Everything

## 🏗️ **Project Title:** **Enterprise Hybrid Cloud Lab: Azure + Microsoft 365 + Active Directory (Terraform-First)**

### 📄 **Description:**

This project simulates a real-world **enterprise IT environment** using a hybrid architecture that spans **on-premises Active Directory**, **Azure cloud infrastructure**, and **Microsoft 365 services**. It is fully built and managed through **Infrastructure as Code (IaC)** using **Terraform**, with CI/CD pipelines for deployment automation and reproducibility.

Designed to reflect the complexity and standards of a production enterprise, the lab enables hands-on experience with:

* **Hybrid identity** (AD DS + Entra ID)
* **Secure network architecture** (hub-and-spoke with Azure Firewall & Bastion)
* **Microsoft 365 services** (Exchange Online, SharePoint, Teams, Intune)
* **Device lifecycle management** (Autopilot, Compliance, App Protection)
* **Security monitoring** (Microsoft Defender XDR, Sentinel, Log Analytics)
* **Automation & governance** (Terraform modules, PowerShell, Azure Policies)

---

### 🎯 **Key Objectives:**

* Simulate real enterprise hybrid identity using **Azure AD Connect Cloud Sync** and **Pass-Through Authentication**.
* Deploy **Windows Server Domain Controllers** in Azure IaaS and configure **Active Directory Sites and Subnets**.
* Build and secure a **hub-and-spoke network topology** using **Azure Firewall**, NSGs, UDRs, and Bastion.
* Configure **Intune** for device enrollment, compliance policies, and mobile application management.
* Enable **Windows Hello for Business with Cloud Kerberos Trust**.
* Set up **Microsoft Defender for Office, Identity, and Cloud**, with alerting integrated into **Microsoft Sentinel**.
* Write **Terraform modules** for each layer (network, identity, M365, Intune, monitoring).
* Create a **CI/CD pipeline** (GitHub Actions or Azure DevOps) for version-controlled deployments with drift detection and destroy/rebuild capability.

---

### 🧰 **Tech Stack:**

* **Infrastructure:** Azure IaaS, Virtual Networks, Application Gateway, Azure Firewall
* **Identity:** Microsoft Entra ID (Azure AD), Active Directory DS, PIM, Conditional Access
* **Productivity & Collaboration:** Microsoft 365 (Exchange Online, SharePoint, Teams)
* **Device Management:** Microsoft Intune, Autopilot, Compliance Policies
* **Security:** Microsoft Defender XDR, Microsoft Sentinel, Log Analytics
* **Automation:** Terraform, GitHub Actions, PowerShell, Graph API
* **Governance:** Azure Policy, Management Groups, Tagging, Budgets





