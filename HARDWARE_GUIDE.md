# ⚙️ Guia de Hardware & Dimensionamento (Sizing)

Escolher o hardware correto é o passo mais importante para garantir que o pfSense suporte o tráfego da sua empresa sem gargalos.

---

## 🏎️ Requisitos Chave

### 1. Processador (CPU) & AES-NI
*   **AES-NI:** Instrução de hardware para aceleração de criptografia. **É OBRIGATÓRIO** para performance decente em VPNs (IPsec/OpenVPN).
*   **Clock vs Cores:** O pfSense (FreeBSD) escala bem em múltiplos cores para pacotes, mas processos como OpenVPN (sem DCO) e Snort são single-threaded. Prefira clocks altos (3.0GHz+).

### 2. Placas de Rede (NICs)
*   **Intel:** O padrão ouro. Drivers estáveis e excelente performance (ex: i210, i211, i225/i226 para 2.5G).
*   **Chelsio:** Recomendado para redes 10Gbps+.
*   **Realtek:** Evitar em ambientes de alta carga devido a drivers instáveis no FreeBSD.

---

## 📊 Tabela de Dimensionamento Sugerido

| Perfil de Uso | CPU Sugerida | RAM | NICs | Throughput Est. |
| :--- | :--- | :--- | :--- | :--- |
| **Home/SOHO** | Intel Celeron / J4125 | 4GB | 1GbE | Até 1Gbps |
| **PME (50 users)** | Intel Core i3 / i5 | 8GB | 1GbE | 1Gbps + VPNs |
| **Enterprise** | Intel Xeon / AMD EPYC | 16GB+ | 10GbE SFP+ | 10Gbps+ / IDS Ativo |
| **Virtualizado** | 2-4 vCPUs (AES-NI Passthrough) | 4-8GB | VirtIO | Variável |

---

## 🌡️ Considerações de Performance (Tuning)

1.  **Suricata/Snort:** Consomem muita RAM e CPU. Se planeja usar IPS em links de 1Gbps, use pelo menos 16GB de RAM e CPUs de alto desempenho.
2.  **pfBlockerNG:** O consumo de RAM escala com o número de listas (feeds). Para listas massivas, 8GB de RAM é o mínimo.
3.  **ZFS:** Recomendamos o uso de SSDs (mesmo pequenos) em vez de HDDs ou cartões SD para evitar corrupção de arquivos e melhorar a velocidade dos logs.

---

## 🏢 Hardware Homologado (Exemplos)
*   **Netgate Appliances:** Hardware oficial (SG-2100, SG-6100, etc.).
*   **Protectli / Qotom:** Mini PCs populares para pfSense com múltiplas portas Intel.
*   **Dell PowerEdge / HP ProLiant:** Servidores rack para ambientes de data center.

---
*Dica: Se estiver comprando hardware novo em 2026, prefira portas de 2.5Gbps (Intel i226-V) para estar pronto para a nova geração de switches e links de fibra.*
