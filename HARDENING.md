# 🔒 pfSense Hardening: Segurança Extrema & Otimização

Este guia foca em transformar o pfSense em uma fortaleza, minimizando a superfície de ataque e otimizando o kernel do FreeBSD para alto desempenho e segurança.

---

## 1. Proteção do Painel Administrativo (WebGUI)

*   **Porta Customizada:** Nunca use a porta `443`. Utilize uma porta alta aleatória (ex: `8443`).
*   **Acesso Restrito:** Criar uma regra de firewall que permita o acesso à WebGUI **apenas** a partir de um IP específico ou Alias da rede administrativa.
*   **HTTPS Strict:** Habilitar "HSTS" e garantir que o certificado seja válido (via ACME).
*   **Login Protection:** Ativar o bloqueio de força bruta (`System > Advanced > Admin Access`) e integrar com o **MFA** se possível.

## 2. Otimização do Kernel (System Tunables)

Ajustes finos no `System > Advanced > System Tunables` para mitigar ataques e melhorar a estabilidade.

| Nome da Variável | Valor Sugerido | Descrição |
| :--- | :--- | :--- |
| `net.inet.tcp.blackhole` | `2` | Não responde a pacotes TCP para portas fechadas (mitiga scans). |
| `net.inet.udp.blackhole` | `1` | Não responde a pacotes UDP para portas fechadas. |
| `net.inet.icmp.drop_redirect` | `1` | Ignora pacotes ICMP Redirect (previne ataques de rota). |
| `net.inet.ip.redirect` | `0` | Desabilita o envio de ICMP Redirects. |
| `net.inet.tcp.drop_synfin` | `1` | Descarta pacotes com as flags SYN e FIN ativas simultaneamente. |
| `hw.usb.no_boot_wait` | `1` | Acelera o boot ignorando espera de dispositivos USB. |

---

## 3. Segurança de Rede (Layer 2 & 3)

*   **Bogon Networks:** Bloquear redes bogon na WAN (redes que não deveriam existir na Internet).
*   **Private Networks:** Bloquear redes privadas na WAN (RFC1918).
*   **IPv6:** Se não estiver em uso, desabilite globalmente para reduzir a superfície de ataque.
*   **MAC Filtering:** Em redes Wi-Fi ou subnets críticas, considere o uso de Static ARP para evitar ataques de ARP Spoofing.

---

## 4. Gerenciamento de SSH

Se o acesso SSH for estritamente necessário:
1.  **Chaves Públicas:** Proibir autenticação por senha. Utilizar apenas `Ed25519` keys.
2.  **Porta:** Mudar a porta padrão `22` para uma porta alta.
3.  **SSH MFA:** Integrar com chaves FIDO2 ou Google Authenticator.

---

## 5. Hardening de Serviços

*   **Unbound:** Habilitar "Harden Glue" e "Harden DNSSEC Data".
*   **NTP:** Utilizar apenas servidores confiáveis e desabilitar o monitoramento NTP (`noquery`) para evitar ataques de amplificação.
*   **Suricata:** Ativar a inspeção de protocolos HTTP/TLS profunda em portas não padrão.

---

## 6. Desativação de Hardware Offloading

Em muitos casos (especialmente em máquinas virtuais ou placas Intel mais antigas), os offloadings de hardware podem causar bugs de segurança ou instabilidade com o IDS/IPS.
*   **Desativar:** Hardware Checksum Offloading.
*   **Desativar:** Hardware TCP Segmentation Offloading (TSO).
*   **Desativar:** Hardware Large Receive Offloading (LRO).

---
*Dica: Após aplicar mudanças nos System Tunables, um reboot é necessário para garantir que todos os parâmetros do kernel sejam lidos corretamente.*
