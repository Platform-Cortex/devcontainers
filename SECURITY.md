# Security Policy

## Supported Versions

Because Platform-Cortex orchestrates critical cloud infrastructures (Platform Engineering) and executes code autonomously (Agentic AI), security is our utmost priority. We provide active security fixes for the following core release versions:

| Version | Supported |
| :--- | :--- |
| v2.x.x | ✅ Active |
| v1.x.x | ⚠️ Critical High/Critical severity bugs only |
| < v1.0.0 | ❌ End of Life (EOL) |

## Reporting a Vulnerability

**Please do not open public Issues to report security vulnerabilities.**

If you discover a security flaw in Platform-Cortex, please follow this responsible disclosure workflow:

1. Send a detailed report to **security@platform-cortex.org** (or use GitHub's native *Private Vulnerability Reporting* feature within the affected repository).
2. Inside your report, make sure to include:
   * The specific module or repository affected (e.g., `cortex-agent`).
   * A thorough description of the vulnerability.
   * Step-by-step instructions or a minimum Proof of Concept (PoC) to reproduce the flaw.
   * The potential blast radius or impact on automated workflows.

### Our Response Lifecycle

* **Acknowledgment:** You will receive a human response validating receipt of your report within 48 business hours.
* **Triage & Remediation:** Our team will assess the impact and build a patch inside a private staging repository.
* **Disclosure:** Once the fix is verified and deployed, we will tag a new release and issue an official CVE/Advisory, providing proper credit to you for the discovery (if desired).

---

## 📜 Security Patch Licensing

In strict alignment with our dual-licensing structure, any security patch, fallback workaround, or pull request submitted to patch a vulnerability within Platform-Cortex will be licensed under the joint terms of the **Apache License 2.0** and the **MIT License**.
