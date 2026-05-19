# 🛡️ Firewall Rules: Políticas de Segurança & Segmentação

Este documento detalha a lógica de segurança aplicada entre as diferentes zonas (VLANs) e a borda da Internet, seguindo o princípio de **Zero Trust** e **Menor Privilégio**.

## 🏗️ Estratégia de Segmentação

O tráfego é controlado através de grupos de regras aplicadas nas interfaces, priorizando o bloqueio total (`Default Deny`).

### 1. 🛡️ Interface WAN (Borda)
*   **Default:** Bloqueio total de entrada.
*   **Exceptions:** Apenas portas necessárias para VPNs (`UDP 1194`, `UDP 51820`) e tráfego ICMP limitado para monitoramento.
*   **Block Bogon Networks:** [X] Habilitado.
*   **Block Private Networks:** [X] Habilitado.

### 2. 🏛️ Interface LAN (Management)
*   **Acesso Administrativo:** Apenas esta rede pode acessar a WebGUI e SSH do pfSense.
*   **Saída:** Liberado apenas tráfego para serviços críticos (DNS, NTP, Updates).
*   **Isolamento:** Bloqueado acesso direto a outras VLANs sem regra de destino específica.

### 3. 🌐 VLAN Servers / DMZ
*   **Inbound:** Tráfego permitido apenas via **HAProxy** ou regras de NAT específicas.
*   **Lateral Movement:** Bloqueio de comunicação entre servidores na mesma zona (via Private VLANs no switch ou regras de firewall se forem subnets diferentes).
*   **Outbound:** Servidores não possuem acesso direto à Internet, exceto via Proxy ou Gateway específico para updates.

---

## 📋 Padrão de Nomenclatura e Logs

Todas as regras devem seguir o padrão definido no `GEMINI.md`:
*   **Descrição:** `[ORIGEM] to [DESTINO] - [PORTA/SERVIÇO]`
*   **Logging:** Ativado para todas as regras de bloqueio para facilitar auditoria e troubleshooting.

---

## 📊 Matriz de Fluxo (Exemplo)

| Origem | Destino | Porta | Propósito |
| :--- | :--- | :--- | :--- |
| LAN_Net | DMZ_Server_01 | 443/TCP | Acesso Web Interno |
| Users_Net | Internet | Any | Navegação Geral (via Shaper) |
| VPN_Net | LAN_Net | Any | Acesso Administrativo Remoto |

## 🛠️ Floating Rules
Utilizadas para regras que se aplicam a múltiplas interfaces simultaneamente ou para políticas globais de saída (ex: bloquear DNS externo para forçar o uso do Unbound local).

---
*Dica: Utilize Aliases para agrupar servidores e portas, tornando as regras legíveis e fáceis de manter.*
