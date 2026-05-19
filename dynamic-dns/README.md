# 🌐 Dynamic DNS (DDNS)

O serviço de **Dynamic DNS** permite que você acesse seu pfSense via um nome de domínio (ex: `home.no-ip.com`) mesmo se o seu IP público for dinâmico.

---

## 🛠️ Provedores Suportados
*   No-IP
*   DynDNS
*   Cloudflare (API)
*   DuckDNS
*   DigitalOcean

## ⚙️ Configuração via Cloudflare (API)
Recomendado para quem possui domínio próprio. O pfSense utiliza um `API Token` para atualizar o registro de DNS automaticamente.

---

## 🛠️ Template XML
O arquivo `template_ddns.xml` contém a estrutura para um cliente DDNS genérico.
