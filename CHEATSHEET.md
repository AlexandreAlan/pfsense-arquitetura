# ⚡ pfSense CLI Power User Cheat Sheet

Guia rápido de comandos essenciais para administração via SSH ou Console.

---

## 🛠️ Comandos de Sistema e Interface

| Comando | Descrição |
| :--- | :--- |
| `8` | Entrar no Shell do FreeBSD. |
| `top -aS` | Ver uso de CPU, RAM e processos em tempo real. |
| `pfsense-shell` | Inicia o console interativo do pfSense (PHP). |
| `pfctl -d` | **CUIDADO:** Desabilita o firewall completamente. |
| `pfctl -e` | Reabilita o firewall. |
| `pfctl -F all` | Limpa todas as tabelas e regras temporariamente. |
| `ifconfig` | Lista todas as interfaces físicas e seus endereços IP. |

---

## 🛡️ Diagnóstico de Firewall

| Comando | Descrição |
| :--- | :--- |
| `tcpdump -ni [interface] host [ip]` | Captura tráfego em tempo real para um IP específico. |
| `pfctl -ss` | Lista todas as conexões (states) ativas. |
| `pfctl -ss | grep [ip]` | Filtra conexões de um IP específico. |
| `pfctl -k [ip]` | Mata todas as conexões de um IP específico. |
| `clog /var/log/filter.log | tail -f` | Acompanha os logs do firewall em tempo real. |

---

## 🔐 VPN & Serviços

| Comando | Descrição |
| :--- | :--- |
| `ipsec status` | Mostra o status atual dos túneis IPsec. |
| `ipsec restart` | Reinicia o serviço de IPsec. |
| `unbound-control stats_noreset` | Mostra estatísticas de performance do DNS. |
| `sockstat -4 -l` | Lista todas as portas IPv4 abertas no firewall. |

---

## 📂 Gerenciamento de Arquivos e Logs

*   **Configuração Atual:** `/conf/config.xml`
*   **Logs do Sistema:** `/var/log/system.log`
*   **Logs do Firewall:** `/var/log/filter.log`
*   **Limpar Logs:** `pfsense-shell > system_reboot()` (ou usar o menu do console).

---

## 🚀 Atalhos Rápidos no Menu do Console
1.  **Assign Interfaces:** Reconfigurar portas WAN/LAN.
2.  **Set interface(s) IP address:** Mudar IPs via teclado.
3.  **Reset webConfigurator password:** Recuperar acesso se perder a senha admin.
4.  **Reset to factory defaults:** Limpeza total.
5.  **Reboot system.**
6.  **Halt system.**

---
*Dica: Utilize o `grep` e `awk` para filtrar saídas longas no shell e identificar problemas rapidamente.*
