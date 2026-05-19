# 🎮 UPnP & NAT-PMP: Automação de Portas

O **UPnP (Universal Plug and Play)** e o **NAT-PMP** permitem que dispositivos internos (consoles de jogos, softwares de torrent) abram portas automaticamente no firewall.

---

## ⚠️ Segurança
O uso de UPnP é desencorajado em ambientes corporativos devido a riscos de segurança (malware pode abrir portas sem autorização).

### Hardening
*   **User Specified Permissions:** Permitir apenas que IPs específicos (ex: IP do console) utilizem o serviço.
*   **Deny by Default:** Bloquear todas as requisições de UPnP exceto as explicitamente permitidas.

---

## 🛠️ Template XML
O arquivo `template_upnp.xml` contém a estrutura para ativação do serviço com restrição de IP.
