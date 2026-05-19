# 📜 Conformidade e Auditoria (Compliance)

Este documento descreve como configurar e manter o pfSense em conformidade com padrões internacionais de segurança, como **PCI-DSS**, **HIPAA**, **GDPR/LGPD** e **ISO 27001**.

---

## 1. Controle de Acesso (IAM)

*   **Identificação Única:** Cada administrador deve ter seu próprio usuário. O uso da conta `admin` deve ser desativado ou estritamente limitado.
*   **MFA (Multi-Factor Authentication):** Obrigatório para todos os administradores e usuários de VPN (requisito PCI-DSS).
*   **Políticas de Senha:** Definir expiração e complexidade de senhas via LDAP/AD se possível.

## 2. Auditoria e Logs (Logging)

*   **Centralização:** Logs de firewall e sistema devem ser enviados para um servidor Syslog remoto (SIEM) e mantidos por no mínimo 1 ano (PCI-DSS).
*   **Registro de Acesso:** Toda alteração de configuração no pfSense deve ser registrada (`Audit Trail`).
*   **IDS/IPS:** Manter logs de alertas do Suricata para análise forense em caso de incidentes.

---

## 3. Segurança de Dados em Trânsito

*   **Criptografia Forte:** Utilizar apenas TLS 1.2 ou 1.3 para a WebGUI e VPNs. Desativar protocolos legados (SSLv3, TLS 1.0/1.1).
*   **VPNs Corporativas:** Exigir certificados digitais para autenticação mútua em túneis IPsec e OpenVPN.

---

## 4. Gestão de Vulnerabilidades

*   **Atualizações:** Manter o pfSense na versão estável mais recente. Vulnerabilidades de segurança devem ser corrigidas em até 30 dias.
*   **Config Backup:** Realizar backups automáticos e criptografados das configurações.
*   **ZFS Boot Environments:** Utilizar para permitir rollback imediato em caso de falha na atualização.

---

## 5. Segmentação de Rede

*   **Isolamento de CDE (Cardholder Data Environment):** Segmentar a rede que processa cartões de crédito de outras redes (VLANs dedicadas e regras de firewall restritivas).
*   **DMZ:** Servidores públicos devem estar em zonas desmilitarizadas, sem acesso direto à LAN administrativa.

---

## 🛠️ Checklist de Auditoria

| Requisito | Status | Verificação |
| :--- | :--- | :--- |
| MFA em VPN | [ ] | Logs de autenticação RADIUS/Local |
| Logs Remotos | [ ] | Verificar recepção no SIEM |
| WebGUI em HTTPS | [ ] | Teste de conexão na porta segura |
| Firewall Default Deny | [ ] | Teste de varredura de portas externa |
| IDS Ativo | [ ] | Status do serviço Suricata/Snort |

---
*Nota: A conformidade é um processo contínuo. Este documento deve ser revisado anualmente ou após qualquer mudança significativa na infraestrutura.*
