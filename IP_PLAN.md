# 🗺️ Plano de Endereçamento IP (IP Plan)

Este documento define a estratégia de sub-redes e alocação de IPs para a infraestrutura corporativa, garantindo escalabilidade e evitando conflitos.

---

## 🏗️ Divisão de Subnets (RFC1918)

Utilizamos o prefixo `10.0.0.0/8` como base para toda a rede interna.

| VLAN ID | Nome da Rede | Prefixo (CIDR) | Gateway (VIP) | Propósito |
| :--- | :--- | :--- | :--- | :--- |
| 1 | LAN_Admin | `10.0.1.0/24` | `10.0.1.1` | Gerenciamento de Infraestrutura |
| 10 | Management | `10.0.10.0/24` | `10.0.10.1` | IPs de Gerenciamento (Proxmox, iDRAC) |
| 20 | DMZ_Servers | `10.0.20.0/24` | `10.0.20.1` | Servidores Web e Aplicações |
| 30 | Users_Office | `10.0.30.0/24` | `10.0.30.1` | Estações de Trabalho (Wired) |
| 40 | Users_WiFi | `10.0.40.0/22` | `10.0.40.1` | Dispositivos Móveis e Wi-Fi |
| 50 | IoT_Devices | `10.0.50.0/24` | `10.0.50.1` | Dispositivos IoT (Isolados) |
| 90 | Sync_HA | `172.16.0.0/30` | N/A | Sincronização de Estados (pfsync) |

---

## 🔐 Alocação de VPNs

| Serviço | Pool de IPs | Protocolo | Autenticação |
| :--- | :--- | :--- | :--- |
| **OpenVPN (RW)** | `10.0.80.0/24` | SSL/TLS | AD + MFA |
| **WireGuard (RW)** | `10.0.90.0/24` | ChachPoly | Chaves Públicas |
| **Tailscale (Mesh)** | `100.64.x.x/10` | Zero Trust | SSO / Auth |

---

## 📍 IPs de Infraestrutura Crítica

| Dispositivo | IP Fixo | Função |
| :--- | :--- | :--- |
| **pfSense Node 01** | `10.0.1.2` | Master Firewall |
| **pfSense Node 02** | `10.0.1.3` | Backup Firewall |
| **VIP CARP (LAN)** | `10.0.1.1` | Gateway Padrão |
| **Domain Controller 1** | `10.0.10.10` | DNS / AD / LDAP |
| **SIEM / Graylog** | `10.0.10.50` | Coleta de Logs |
| **Proxmox Cluster VIP** | `10.0.10.100` | Virtualização |

---

## 🛡️ Regras de Ouro do IP Plan
1.  **Isolamento:** VLANs de usuários nunca devem acessar a VLAN de Management diretamente.
2.  **Reservas:** IPs de `.2` a `.50` em cada VLAN são reservados para ativos de infraestrutura (Switches, APs, Impressoras).
3.  **DHCP:** Pools de DHCP dinâmico devem começar sempre em `.100`.

---
*Dica: Utilize este documento como base para configurar seus Aliases e regras de Firewall no pfSense.*
