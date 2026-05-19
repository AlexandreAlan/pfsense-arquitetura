# 🏛️ FreeRADIUS: Autenticação Avançada

O pacote **FreeRADIUS** no pfSense permite a gestão centralizada de usuários para autenticação em VPNs, Wi-Fi Enterprise (802.1X) e Captive Portal.

---

## ⚙️ Componentes
1.  **Clients (NAS):** Dispositivos que consultam o RADIUS (ex: Access Points, Switches).
2.  **Interfaces:** Portas onde o RADIUS ouve requisições (Padrão: `1812` para Auth, `1813` para Acct).
3.  **Users:** Base de dados local de usuários ou proxy para AD/LDAP.

---

## 🛠️ Template XML
O arquivo `template_freeradius.xml` contém a configuração de uma interface e um cliente RADIUS básico.
