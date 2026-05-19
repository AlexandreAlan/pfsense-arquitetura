# 🚦 Deep Dive: Traffic Shaping & Bufferbloat

A modelagem de tráfego moderna no pfSense evoluiu do antigo ALTQ para o uso de **Limiters** com o escalonador **FQ_CoDel**.

---

## 1. O Problema: Bufferbloat

Bufferbloat é a latência excessiva causada pelo buffer excessivo de pacotes em equipamentos de rede. Quando o link satura, o buffer enche, e o tempo de resposta (ping) aumenta drasticamente.

### 🧪 Como testar?
Utilize o teste de Bufferbloat (ex: `waveform.com/tools/bufferbloat`). Se o seu ping sobe mais de 50ms durante o download/upload, você tem bufferbloat.

---

## 2. A Solução: FQ_CoDel

O **FQ_CoDel (Fair Queuing Controlled Delay)** funciona através de dois mecanismos:
1.  **Fair Queuing:** Garante que fluxos "pequenos" (VoIP, DNS, ACK) não fiquem presos atrás de fluxos "grandes" (Download de ISO, Backup).
2.  **Controlled Delay (CoDel):** Gerencia dinamicamente o tamanho da fila. Se um pacote fica na fila por muito tempo, o CoDel o descarta preventivamente para forçar o TCP a reduzir a janela de transmissão.

### ⚙️ Parâmetros Técnicos (DCO Ready)
*   **Target:** Tempo ideal que um pacote deve ficar na fila (Padrão: `5ms`).
*   **Interval:** Tempo para o CoDel observar a fila antes de agir (Padrão: `100ms`).
*   **Flows:** Número de filas independentes (Padrão: `1024`).

---

## 3. Implementação com Limiters

Diferente do Shaper clássico, os Limiters são aplicados nas interfaces via regras de firewall.

### 📶 Lógica de Inbound/Outbound
*   **Limiter In:** Controla o Download (aplicado na regra de entrada da WAN ou saída da LAN).
*   **Limiter Out:** Controla o Upload.

---

## 📊 Visualização de Filas (Limiter Info)

```mermaid
graph LR
    P[Pacotes de Entrada] --> FQ[FQ_CoDel Scheduler]
    subgraph Queues [1024 Fair Queues]
        FQ --> Q1[VoIP / SSH]
        FQ --> Q2[Web / HTTPS]
        FQ --> Q3[ISO Download]
    end
    Q1 --> Out[Saída Prioritária]
    Q2 --> Out
    Q3 --> Out
    Note over Q3: CoDel descarta pacotes se Q3 exceder o Target
```

## 🛠️ Otimização para Hardware Multi-core
*   **Tail Drop vs CoDel:** Evite o Tail Drop clássico. Ele descarta apenas os últimos pacotes, o que causa retransmissões massivas e o fenômeno de "TCP Global Synchronization".
*   **Ecn (Explicit Congestion Notification):** Habilitar se os servidores de destino suportarem. Permite que o firewall notifique o servidor para reduzir a velocidade sem precisar descartar o pacote.

---
*Dica: Para links acima de 500Mbps, verifique o uso de CPU. O FQ_CoDel é excelente, mas exige processamento para gerenciar as 1024 filas em tempo real.*
