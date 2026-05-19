# 📖 Guia de Referência Oficial: Funções do pfSense

Este documento fornece uma visão técnica exaustiva das funcionalidades do pfSense, baseada nos padrões da Netgate, explicando o que são, para que servem e como devem ser aplicadas em ambientes profissionais.

---

## 1. Firewall & NAT

### 🛡️ Firewall Rules
*   **O que é:** O mecanismo central de controle de tráfego baseado em pacotes (Layer 3 e 4).
*   **O que faz:** Inspeciona pacotes que entram em uma interface e decide se devem ser permitidos (Pass), bloqueados (Block) ou rejeitados (Reject).
*   **Como aplicar:** 
    *   Sempre aplicar regras na interface onde o tráfego **entra**.
    *   Utilizar o princípio de *Default Deny* (Bloqueio Total).
    *   Usar *Floating Rules* para regras que afetam múltiplas interfaces ou para controle de saída (Outbound).

### 🔄 NAT (Network Address Translation)
*   **O que é:** Tradução de endereços de rede.
*   **O que faz:** Permite que múltiplos dispositivos em uma rede privada acessem a Internet usando um único IP público (Outbound) ou expõe serviços internos para a Internet (Inbound/Port Forward).
*   **Como aplicar:** 
    *   **Port Forward:** Usar para serviços específicos como VPNs ou SSH.
    *   **Outbound NAT:** Em clusters HA, mudar para modo *Hybrid* ou *Manual* e mapear para o VIP CARP.
    *   **1:1 NAT:** Usar apenas quando um host interno precisa de um mapeamento estático completo para um IP público.

### 🏷️ Aliases
*   **O que é:** Objetos lógicos que agrupam IPs, Redes ou Portas.
*   **O que faz:** Simplifica a gestão das regras de firewall. Em vez de criar 10 regras para 10 servidores, cria-se um Alias "Srv_Web" e uma única regra.
*   **Como aplicar:** Nunca usar IPs diretamente nas regras. Tudo deve ser via Alias para facilitar atualizações futuras.

---

## 2. Serviços de Rede (Services)

### 🟢 Kea / ISC DHCP
*   **O que é:** Servidor de atribuição dinâmica de IPs.
*   **O que faz:** Entrega IPs, Gateways e Servidores DNS automaticamente para os dispositivos da rede.
*   **Como aplicar:** Usar o **Kea DHCP** para novas instalações (padrão v2.8+). Definir reservas estáticas (Static Leases) para servidores e infraestrutura.

### 🔍 DNS Resolver (Unbound)
*   **O que é:** Um servidor DNS recursivo com suporte a validação DNSSEC.
*   **O que faz:** Resolve nomes de domínio diretamente dos Root Servers ou via Forwarding.
*   **Como aplicar:** Habilitar *DNS over TLS* para privacidade e configurar *Host Overrides* para resolução de nomes internos na LAN.

### ⏰ NTP (Network Time Protocol)
*   **O que é:** Sincronizador de relógio.
*   **O que faz:** Garante que todos os dispositivos e logs da rede tenham a mesma hora exata.
*   **Como aplicar:** Configurar o pfSense como o servidor NTP autoritativo para a rede local, apontando para o `pool.ntp.org`.

---

## 3. VPN (Virtual Private Networks)

### ⚡ WireGuard
*   **O que é:** Protocolo VPN moderno baseado em criptografia de curva elíptica.
*   **O que faz:** Cria túneis de ultra-alta performance e baixa latência.
*   **Como aplicar:** Usar para conexões Site-to-Site e para acesso administrativo Road Warrior.

### 🔒 OpenVPN
*   **O que é:** Protocolo VPN versátil baseado em SSL/TLS.
*   **O que faz:** Provê acesso remoto seguro e túneis entre escritórios.
*   **Como aplicar:** Habilitar o modo **DCO (Data Channel Offload)** para performance acelerada por kernel.

### 🏛️ IPsec
*   **O que é:** Suite de protocolos para segurança em nível de rede.
*   **O que faz:** Padrão industrial para interligação de túneis corporativos.
*   **Como aplicar:** Preferir **IKEv2** e **Route-Based (VTI)** para integração com BGP/OSPF.

---

## 4. Alta Disponibilidade (High Availability)

### ⚖️ CARP (Common Address Redundancy Protocol)
*   **O que é:** Protocolo de redundância de IP.
*   **O que faz:** Permite que dois firewalls compartilhem um IP Virtual. Se o Master cai, o Backup assume em menos de 1 segundo.
*   **Como aplicar:** Exige um switch que suporte tráfego multicast Layer 2 e uma interface dedicada de SYNC.

### 🔄 XMLRPC Sync
*   **O que é:** Sincronização de configuração.
*   **O que faz:** Replica regras, aliases e configurações do Master para o Backup automaticamente.
*   **Como aplicar:** Habilitar no nó Master apontando para o IP da interface de SYNC do Backup.

---

## 5. Pacotes Avançados (Add-on Packages)

### 🚫 pfBlockerNG-devel
*   **O que é:** Sistema de filtragem de IP e DNS.
*   **O que faz:** Bloqueia anúncios, malware e tráfego de países específicos (GeoIP).
*   **Como aplicar:** Usar DNSBL para proteção de navegação e IP Blocklists para proteger a borda WAN.

### 🔄 HAProxy
*   **O que é:** Balanceador de carga e Proxy Reverso Layer 7.
*   **O que faz:** Distribui tráfego web entre múltiplos servidores internos e gerencia certificados SSL.
*   **Como aplicar:** Usar para publicar aplicações internas de forma segura com SSL Offloading.

### 🛡️ Suricata / Snort
*   **O que é:** IDS/IPS (Intrusion Detection/Prevention System).
*   **O que faz:** Inspeciona o conteúdo dos pacotes em busca de assinaturas de ataques conhecidos.
*   **Como aplicar:** Usar o **Suricata em modo Inline (Netmap)** para bloquear ataques automaticamente sem derrubar conexões legítimas.

---

## 6. Diagnóstico & Monitoramento

### 📊 Traffic Graphs / ntopng
*   **O que faz:** Visualização em tempo real de quem está consumindo banda e quais protocolos estão ativos.

### 📈 Dashboard & Telegraf
*   **O que faz:** Coleta métricas do sistema (CPU, RAM, Status de Gateway) para visualização em dashboards como Grafana.

---
*Este documento é uma síntese da documentação oficial e das melhores práticas da indústria para pfSense.*
