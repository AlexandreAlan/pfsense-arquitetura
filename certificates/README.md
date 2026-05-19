# 📜 Gestão de Certificados (ACME & Certificates)

Este diretório documenta a gestão de certificados digitais para acesso administrativo, VPNs e publicação de serviços via HAProxy.

## 🤖 Automação via ACME (Let's Encrypt)

O pacote **ACME** é utilizado para automatizar a emissão e renovação de certificados SSL gratuitos.

### 🔑 Métodos de Validação
*   **DNS-01 (Recomendado):** Utiliza APIs de provedores de DNS (Cloudflare, DigitalOcean, Route53) para criar registros TXT. Este método permite a emissão de certificados **Wildcard** (`*.empresa.com`).
*   **HTTP-01:** Requer que a porta 80 esteja aberta e apontada para o pfSense (raramente usado em produção corporativa).

### ⚙️ Configuração da Account
*   **CA:** `Let's Encrypt Production` (ou `ZeroSSL`).
*   **E-mail:** Utilizar um e-mail de grupo de infraestrutura (`infra@empresa.com`).

---

## 🏛️ Certificate Authority (CA) Interna

Para serviços que não são expostos publicamente, utilizamos uma CA interna gerada no pfSense.

### Estrutura de CA
1.  **Internal-Root-CA:** Chave mestra (deve ter vida útil longa, ex: 10 anos).
2.  **Internal-Intermediate-CA:** Utilizada para assinar certificados finais (Segurança).

### Usos Comuns
*   **OpenVPN Server:** Certificados para o servidor e para cada cliente.
*   **WebGUI:** Acesso ao painel administrativo do pfSense via HTTPS.
*   **IPsec:** Autenticação baseada em certificados.

---

## 🛡️ Segurança e Exportação
*   **NUNCA** exportar ou armazenar chaves privadas (`.key`) neste repositório.
*   **Renovação Automática:** Configurar ACME para renovar certificados com 30 dias de antecedência.
*   **HA Sync:** Certificados e chaves (hashes) são sincronizados via XMLRPC para o nó secundário.

---
*Dica: Ao renovar certificados via ACME, configure a "Action" para reiniciar o serviço HAProxy automaticamente.*
