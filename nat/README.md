# 🔄 Network Address Translation (NAT)

Configurações de redirecionamento de portas (Inbound) e tradução de endereços de saída (Outbound).

## 📥 Port Forwarding (Port Forwards)

Embora o uso de **HAProxy** seja preferencial para tráfego Web, o Port Forwarding é utilizado para serviços específicos de rede.

### ⚙️ Regras Ativas
| Interface | Protocolo | Porta Externa | IP Interno | Porta Interna | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| WAN | TCP | 2222 | 10.10.10.50 | 22 | SSH Gateway (Jump Host) |
| WAN | UDP | 5060 | 10.10.20.100 | 5060 | SIP Trunk (VoIP) |

### 🛡️ Boas Práticas (Inbound)
*   **NAT Reflection:** Desabilitado por padrão. Utilizar **Split DNS** (Host Overrides no Unbound) para que nomes internos resolvam para IPs internos.
*   **Source Filtering:** Sempre que possível, limitar a origem (Source) do NAT a IPs conhecidos ou Aliases de parceiros.

---

## 📤 Outbound NAT

Configuração de como os IPs internos são traduzidos ao sair para a Internet.

### ⚙️ Modo: **Hybrid Outbound NAT**
O modo Híbrido permite que o pfSense gere regras automáticas, mas nos permite sobrescrever o comportamento para casos críticos (ex: Cluster HA).

### ⚖️ Regras de HA (Alta Disponibilidade)
Para garantir que o failover de CARP não quebre as conexões NAT, todas as subnets internas devem ser mapeadas para o **Virtual IP (CARP)** da interface WAN.

| Interface | Source | Translation IP | Descrição |
| :--- | :--- | :--- | :--- |
| WAN | `10.0.0.0/8` | `WAN_VIP_CARP` | Mapeamento global para HA |

---

## 🛠️ 1:1 NAT (Binat)
Utilizado para mapear um IP público inteiro para um servidor interno específico.
*   **Uso:** Raramente utilizado. Preferir Port Forwarding ou HAProxy por questões de segurança.

---
*Aviso: Evite o uso de "UPnP" ou "NAT-PMP" em ambientes corporativos devido a riscos de segurança e falta de controle sobre a abertura de portas.*
