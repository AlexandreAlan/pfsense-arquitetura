## 💬 OpenVPN (Road Warrior)

Configuração de acesso remoto seguro utilizando certificados digitais e MFA (opcional).

### 🛠️ Parâmetros do Servidor
*   **Interface:** WAN
*   **Protocolo:** UDP on IPv4 Only (Maior performance)
*   **Device Mode:** tun (Layer 3)
*   **Porta:** 1194
*   **Encryption:** AES-256-GCM / SHA256 (Padrão segurança alta)

### 👥 Configuração de Clientes
1.  **Auth:** Local User Manager + Certificado Individual.
2.  **Split Tunneling:** [X] Habilitado (Apenas tráfego interno passa pela VPN).
3.  **DNS:** Clientes recebem o IP do pfSense para resolução de nomes internos.

### 🛡️ Checklist de Segurança
- [ ] TLS Key habilitada e direcional.
- [ ] Bloqueio de conexões simultâneas por usuário (opcional).
- [ ] Regras de firewall no `OpenVPN Tab` limitadas aos IPs necessários.

---
*Dica: Utilize o pacote `openvpn-client-export` para gerar os arquivos `.ovpn` facilmente.*
