# ⏰ NTP Server: Sincronização de Tempo

O pfSense atua como um servidor NTP (Network Time Protocol) autoritativo para garantir que todos os dispositivos da rede tenham o relógio sincronizado.

---

## ⚙️ Configurações Recomendadas
*   **Upstreams:** Utilizar o pool oficial `0.pfsense.pool.ntp.org` ou `a.st1.ntp.br` para o Brasil.
*   **Interfaces:** Ouvir apenas nas interfaces internas (LAN/VLANs).
*   **Orphan Mode:** Permite que o pfSense continue servindo hora mesmo se perder a conexão com a Internet.

## 🛡️ Hardening do NTP
*   **Restrict Queries:** Impedir que clientes externos consultem o estado do servidor (`noquery`).
*   **KOD (Kiss-o'-Death):** Envia pacotes de redução de taxa para clientes abusivos.

---

## 🛠️ Template XML
O arquivo `template_ntp.xml` contém a configuração padrão para o serviço NTP.
