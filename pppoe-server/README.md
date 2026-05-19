# 🔌 PPPoE Server

O pfSense pode atuar como um servidor **PPPoE (Point-to-Point Protocol over Ethernet)**, permitindo autenticação e controle de banda para clientes diretamente conectados via Layer 2 (comum em provedores ISP locais).

---

## ⚙️ Configurações
*   **Interface:** A porta física onde o servidor ouvirá requisições.
*   **Subnet:** O pool de IPs que os clientes PPPoE receberão.
*   **Auth:** Local User Manager ou RADIUS.

---

## 🛠️ Template XML
O arquivo `template_pppoe.xml` contém a configuração de um servidor PPPoE básico.
