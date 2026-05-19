# ⚖️ Deep Dive: Alta Disponibilidade (CARP & pfsync)

O cluster HA do pfSense é baseado na interação complexa de dois protocolos principais: **CARP** e **pfsync**.

---

## 1. CARP: A Matemática do Failover

O CARP funciona enviando pacotes de anúncio via multicast (`224.0.0.18`). A decisão de quem é o Master é baseada no valor de `advskew`.

### 🧮 A Equação de Prioridade
O intervalo de anúncio é: `advbase + (advskew / 256)`.
*   **advbase:** Padrão `1` segundo.
*   **advskew:** 
    *   Master: `0` (Intervalo = 1.00s).
    *   Backup: `100` (Intervalo = 1.39s).

Se o nó Master falhar por 3 anúncios consecutivos, o Backup assume.

### 🛡️ Preempção (Preemption)
*   **Enabled:** Se o nó Master original voltar, ele retoma o VIP imediatamente.
*   **Disabled:** O Backup continua como Master até que ocorra outra falha. Recomendado para evitar "flapping" de rede.

---

## 2. pfsync: Sincronização de Estados

O **pfsync** garante que as conexões TCP/UDP continuem ativas mesmo após um failover.

### ⚙️ Funcionamento Interno
Toda vez que uma entrada é criada ou alterada na **State Table** do Master, um pacote `pfsync` é enviado ao Backup.
*   **Protocolo IP:** 240.
*   **Performance:** Em redes 10G, o tráfego de `pfsync` pode ser massivo. Use uma interface de 10Gbps dedicada e direta (DAC/Fiber) entre os firewalls.
*   **Defer:** O pfSense pode ser configurado para "esperar" o ACK do pfsync antes de permitir um pacote, garantindo consistência total (embora aumente a latência).

---

## 🔄 XMLRPC Sync: O que é sincronizado?

O XMLRPC replica o arquivo `config.xml` de forma granular.

| Sincronizado | NÃO Sincronizado |
| :--- | :--- |
| Regras de Firewall | Hostname único dos nós |
| Aliases & VIPs | Endereços IP das interfaces (exceto VIPs) |
| Certificados ACME | Logs locais |
| VPNs (OpenVPN/IPsec) | RRD Graphs |
| Pacotes (HAProxy/pfB) | Dashboards de Monitoramento |

---

## 🛠️ Troubleshooting de HA
1.  **Split Brain:** Ambos os nós acham que são Master. Causa: Problema de comunicação Layer 2 entre eles.
2.  **State Mismatch:** Conexões caem no failover. Causa: `pfsync` não configurado ou bloqueado no firewall.
3.  **VIP Demotion:** O pfSense rebaixa o VIP se detectar problemas na interface. Verifique `Status > High Availability`.

---
*Dica: Utilize o comando `tcpdump -ni [interface_sync] proto 240` para validar se o tráfego pfsync está fluindo.*
