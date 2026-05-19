# 📡 Multicast IGMP Proxy

O **IGMP Proxy** é utilizado para encaminhar tráfego de Multicast (ex: IPTV, fluxos de vídeo) entre diferentes subnets/VLANs.

---

## ⚙️ Configuração
*   **Upstream:** A interface de onde vem o tráfego multicast (ex: WAN ou VLAN de IPTV).
*   **Downstream:** A rede onde os clientes que receberão o tráfego estão localizados (ex: LAN).
*   **Threshold:** Limite de saltos (TTL) para o tráfego.

---

## 🛠️ Template XML
O arquivo `template_igmp.xml` contém a definição básica de Upstream e Downstream.
