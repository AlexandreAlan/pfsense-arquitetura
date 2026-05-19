# 📡 Deep Dive: Kea DHCP & Unbound DNS

Aprofundamento técnico nos serviços de infraestrutura core do pfSense.

---

## 1. Kea DHCP: Performance & API

O Kea DHCP não é apenas um substituto para o ISC; ele é um servidor DHCP moderno projetado para ambientes de alta densidade.

### ⚙️ Arquitetura do Kea
*   **Separation of Concerns:** O Kea separa a lógica de DHCP (serviço) da lógica de armazenamento (banco de dados). No pfSense, ele utiliza um back-end de memória altamente otimizado.
*   **Lease File:** Diferente do ISC, que escreve em um arquivo de texto plano sequencial, o Kea gerencia leases de forma mais eficiente, reduzindo o I/O de disco.

### 🛠️ Otimização Avançada
*   **Subnet-Specific Options:** Definir opções personalizadas (ex: Opção 66 para TFTP/VoIP) por VLAN de forma granular.
*   **API Control:** No futuro, o Kea permitirá mudanças de configuração sem reiniciar o serviço (Diferencial para ambientes 24/7).

---

## 2. Unbound DNS: Segurança & Tuning

O Unbound é um servidor DNS recursivo, validador e com foco em privacidade.

### 🔒 Hardening do Resolver
1.  **Harden-Glue:** Previne que o Unbound aceite registros A fora da zona de autoridade.
2.  **Unwanted-Reply-Threshold:** Se o Unbound receber muitas respostas não solicitadas, ele limpa o cache e altera a porta de consulta para mitigar ataques de envenenamento de cache (Poisoning).
3.  **QNAME Minimization:** Envia apenas a parte mínima necessária do nome do domínio para os servidores upstream, aumentando a privacidade.

### ⚡ Tuning de Performance (System Tunables)
Para redes com milhares de dispositivos, ajuste os buffers do Unbound:
*   `msg-cache-slabs`: Igual ao número de cores da CPU.
*   `rrset-cache-size`: Dobro do `msg-cache-size`.
*   `outgoing-range`: Aumentar para suportar mais consultas simultâneas.

---

## 📊 Fluxo de Sincronização em HA

```mermaid
graph LR
    Master[Nó Master] -->|XMLRPC Sync| Backup[Nó Backup]
    Master -->|Lease Database| DB[(Shared State)]
    Note over Master, Backup: DHCP Leases são sincronizados via High Availability no Kea (v2.8+)
```

## ⚠️ Limitações Atuais (v2.8)
*   **Kea DHCP:** Algumas funcionalidades avançadas de DNS Dinâmico (DDNS) e integração total com HA ainda estão sendo refinadas em comparação com o ISC legado. Sempre verifique o status do serviço em `Status > DHCP Leases`.

---
*Dica: Utilize o `unbound-control` via shell para inspecionar o cache DNS em tempo real.*
