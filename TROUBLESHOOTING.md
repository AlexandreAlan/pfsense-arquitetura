# 🚑 Playbook de Troubleshooting: pfSense

Este guia prático foca em resolver problemas comuns de rede e serviços no pfSense de forma estruturada.

---

## 1. Problemas de Conectividade Geral

### O pfSense não navega ou não pinga fora?
1.  **Interface Status:** Vá em `Status > Interfaces` e verifique se a WAN está `UP` e com IP.
2.  **DNS Check:** Vá em `Diagnostics > Ping`. Tente pingar `1.1.1.1` (IP) e depois `google.com` (Hostname). Se o IP pingar mas o nome não, o problema é DNS.
3.  **Gateway Status:** Verifique `Status > Gateways`. Se o gateway estiver `Offline` ou com `100% Packet Loss`, contate o ISP.

---

## 2. Firewall & NAT

### Uma regra de firewall não está funcionando?
*   **Order Matters:** Regras são lidas de **cima para baixo**. A primeira regra que der match será aplicada.
*   **Log Check:** Vá em `Status > System Logs > Firewall`. Filtre pelo IP de origem/destino e veja se o tráfego está sendo bloqueado (`Default Deny`).
*   **State Table:** Às vezes uma conexão antiga impede a nova regra. Vá em `Diagnostics > States` e limpe os estados do IP em questão.

### Port Forward não funciona?
1.  **ISP Block:** Verifique se o seu ISP bloqueia portas comuns (80, 443, 22).
2.  **Gateway Interno:** O servidor interno deve usar o pfSense como Gateway padrão.
3.  **Firewall do Host:** Verifique se o Windows Firewall ou IPTables do servidor destino está bloqueando o tráfego.

---

## 3. VPN (IPsec / OpenVPN / WireGuard)

### O túnel não sobe (Phase 1 Down)?
*   **PSK/Cert Match:** Verifique se a chave pré-compartilhada ou os certificados são idênticos em ambos os lados.
*   **Proposals:** Garanta que a criptografia (AES-GCM), Hash (SHA256) e DH Group sejam iguais.
*   **Portas:** Verifique se a porta `UDP 500` (IPsec) ou `UDP 1194` (OpenVPN) está aberta na WAN.

---

## 4. Ferramentas Avançadas de Diagnóstico

### Packet Capture (A "Prova Real")
Vá em `Diagnostics > Packet Capture`.
*   Selecione a Interface (WAN ou LAN).
*   Filtre pelo Host IP e Porta.
*   Analise se o pacote chega (`Inbound`) e se o pfSense o encaminha (`Outbound`).

### Console / Shell (CLI)
Comandos úteis via SSH:
*   `top -aS`: Ver uso de CPU e processos do sistema.
*   `pfsense-shell`: Executar comandos PHP do pfSense.
*   `tcpdump -ni [interface] host [ip]`: Captura de pacotes via CLI.
*   `clog /var/log/filter.log | grep [ip]`: Ver logs de firewall em tempo real.

---

## 5. Recuperação em Caso de Desastre

1.  **Config History:** Se uma mudança quebrou tudo, vá em `Diagnostics > Configuration History` e faça o rollback para a versão anterior.
2.  **ZFS Boot Environments:** Se uma atualização falhou, selecione o ambiente anterior no menu de boot.
3.  **Factory Reset:** Em último caso, reset via console (Opção 4).

---
*Dica: Sempre realize um backup antes de qualquer alteração crítica!*
