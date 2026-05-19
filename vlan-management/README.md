# 🏗️ VLAN Management: Segmentação Layer 2

A gestão de **VLANs (Virtual LANs)** permite dividir uma única interface física em múltiplas redes lógicas, isolando o tráfego de diferentes departamentos ou serviços.

---

## ⚙️ Configuração (IEEE 802.1Q)
*   **Parent Interface:** A placa física que suporta as VLANs (ex: `igb0`).
*   **VLAN Tag (ID):** O número identificador da VLAN (ex: `10`, `20`).
*   **Priority:** Prioridade de QoS na camada 2 (opcional).

---

## 🛠️ Template XML
O arquivo `template_vlans.xml` contém a definição de 3 VLANs padrão (Admin, Servers, Users).
