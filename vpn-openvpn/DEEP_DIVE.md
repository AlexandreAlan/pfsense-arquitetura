# 🔐 Deep Dive: VPN Performance (DCO, WireGuard & VTI)

O pfSense 2.8+ elevou o patamar de performance de VPNs ao integrar tecnologias de aceleração de kernel.

---

## 1. OpenVPN DCO: Por que é tão rápido?

O **Data Channel Offload (DCO)** é a maior mudança no OpenVPN em décadas.

### ⚙️ Arquitetura Tradicional vs DCO
*   **Tradicional:** O tráfego criptografado viaja da Interface de Rede -> Kernel -> OpenVPN Process (User Space) -> Kernel -> LAN. Cada troca de contexto (Context Switch) consome CPU e aumenta a latência.
*   **DCO:** O tráfego é descriptografado diretamente pelo driver de kernel do OpenVPN. O processo em User Space cuida apenas da negociação inicial (Control Channel).

### 🚀 Tuning DCO
*   **Ciphers:** Apenas `AES-128-GCM`, `AES-256-GCM` e `CHACHA20-POLY1305` são compatíveis.
*   **MTU:** O DCO lida melhor com MTU padrão (`1500`), mas recomenda-se `1427` para evitar fragmentação em links PPPoE.

---

## 2. WireGuard: Kernel-Native Efficiency

O WireGuard no pfSense não usa o driver `go-wireguard` (user-space). Ele utiliza o driver nativo do FreeBSD (`if_wg`).

### ⚡ Performance Secrets
*   **Multithreading:** O driver `if_wg` no FreeBSD consegue distribuir o processamento de criptografia por todos os cores da CPU.
*   **Memory Footprint:** Extremamente baixo. Ideal para sistemas embarcados com pouca RAM.

---

## 3. IPsec VTI: O Padrão Enterprise

O **VTI (Virtual Tunnel Interface)** transforma o IPsec de uma "política de tráfego" em uma "interface de rede".

### 🏛️ Vantagens de Baixo Nível
*   **FIB (Forwarding Information Base):** Ao ter uma interface real, o pfSense pode usar a tabela de rotas do kernel para decidir o caminho do pacote, em vez de escanear a lista de políticas de segurança (SPD) em cada pacote.
*   **Interoperabilidade:** O VTI do pfSense é 100% compatível com o Route-Based IPsec da AWS, Azure e Google Cloud.

---

## 📊 Comparativo de Performance (Est. Mbps/Core)

| Protocolo | Aceleração | Eficiência CPU | Latência |
| :--- | :--- | :--- | :--- |
| **OpenVPN Legado** | User-space | 🟡 Baixa | 🔴 Alta |
| **OpenVPN DCO** | Kernel-Offload | 🟢 Alta | 🟡 Média |
| **WireGuard** | Native Kernel | 🟢 Máxima | 🟢 Mínima |
| **IPsec VTI** | Crypto-Offload | 🟢 Alta | 🟢 Mínima |

## 🛠️ Checklist de Performance de VPN
- [ ] Ativar **AES-NI** nos System Tunables.
- [ ] Validar suporte a **AES-GCM** em ambos os lados do túnel.
- [ ] Configurar **MSS Clamping** para `1350` para evitar o custo de fragmentação de pacotes.

---
*Dica: Utilize o comando `top -P` para ver como o tráfego da VPN está sendo distribuído entre os cores da sua CPU.*
