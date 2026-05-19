# 🛡️ CrowdSec no pfSense: Segurança Colaborativa

O **CrowdSec** é um IPS (Intrusion Prevention System) moderno, leve e de código aberto que utiliza inteligência coletiva para bloquear atacantes.

## 🌟 Por que usar CrowdSec com pfSense?
Diferente do Suricata, que analisa assinaturas locais, o CrowdSec recebe sinais de uma rede global. Se um IP é identificado atacando outro usuário CrowdSec em qualquer lugar do mundo, ele é banido automaticamente do seu firewall.

---

## ⚙️ Instalação (FreeBSD Package)

O pfSense é baseado em FreeBSD, permitindo a instalação do agente CrowdSec via shell.

1.  **Habilitar o Repositório FreeBSD:**
    `pkg install crowdsec`
2.  **Instalar o Bouncer (Bloqueador):**
    O Bouncer é o que realmente cria as regras no firewall para bloquear os IPs.
    `pkg install crowdsec-firewall-bouncer`

---

## 📋 Configuração de Coletores (Parsers)

O CrowdSec precisa ler os logs do pfSense para identificar comportamentos suspeitos.

### Logs Recomendados:
*   `/var/log/filter.log` (Logs do Firewall)
*   `/var/log/auth.log` (Tentativas de login SSH/WebGUI)
*   `/var/log/vpn.log` (Logs de VPN)

---

## 📊 Dashboard e Console
Conecte seu pfSense ao [CrowdSec Console](https://app.crowdsec.net/) para visualizar:
*   De quais países vêm os ataques mais frequentes.
*   Quais serviços estão sendo visados.
*   Status do seu "Bouncer" em tempo real.

---

## 🛡️ Comandos Úteis (CLI)
*   `cscli decisions list`: Lista todos os IPs atualmente banidos.
*   `cscli alerts list`: Mostra os alertas recentes de comportamento malicioso.
*   `cscli bouncers list`: Verifica se o bloqueador do pfSense está ativo.
*   `cscli decisions add --ip 1.2.3.4 --reason "Manual Block"`: Banir um IP manualmente.

---
*Dica: O CrowdSec consome muito menos CPU e RAM que o Suricata, sendo ideal para hardware de entrada ou VMs limitadas.*
