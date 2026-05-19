# 🗺️ Interoperabilidade Multi-Vendor

O pfSense é altamente compatível. Aqui estão os parâmetros padrão para conectar o pfSense a outros grandes players do mercado via VPN IPsec.

---

## 1. pfSense <-> FortiGate (Site-to-Site)

**Fase 1 (IKEv2):**
*   **Encryption:** AES-256.
*   **Hash:** SHA256.
*   **DH Group:** 14 (2048 bit).
*   **FortiGate Note:** Desativar "ASIC Offload" se houver problemas de estabilidade.

**Fase 2:**
*   **Encryption:** AES-256-GCM.
*   **PFS:** Enabled (DH Group 14).

---

## 2. pfSense <-> Cisco ASA / Firepower

**Fase 1:**
*   **Encryption:** AES-256.
*   **Hash:** SHA256.
*   **Cisco Note:** Garantir que o `Identity` (Local/Remote) esteja configurado como IP se o IPsec for Policy-Based.

**Fase 2:**
*   **Encryption:** AES-256.
*   **Hash:** SHA256.
*   **Mode:** Tunnel.

---

## 3. pfSense <-> Mikrotik (RouterOS v7)

**Fase 1 (IKEv2):**
*   **Mikrotik Note:** O Mikrotik v7 suporta IKEv2 de forma muito mais estável que o v6.
*   **Auth Method:** Pre-shared Key (PSK).

**Fase 2:**
*   **Encryption:** AES-256-CBC.
*   **Hash:** SHA256.

---

## 🛡️ Dicas de Compatibilidade
1.  **MSS Clamping:** Sempre configure o MSS Clamping para `1350` no pfSense para evitar que pacotes grandes sejam descartados pelo túnel.
2.  **Dead Peer Detection (DPD):** Use os mesmos intervalos de DPD em ambos os lados (ex: 10s delay, 5 retries).
3.  **NAT Traversal:** Se um dos lados estiver atrás de NAT, habilite o NAT-T em ambos os firewalls.

---
*Dica: Utilize o [Troubleshooting Playbook](./TROUBLESHOOTING.md) se o túnel entre fabricantes diferentes não subir de primeira.*
