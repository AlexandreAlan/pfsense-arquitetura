# 🏛️ Autenticação Enterprise: RADIUS, LDAP & AD

Em ambientes corporativos, a gestão de identidade centralizada é fundamental para a segurança e conformidade.

---

## 1. Integração com Active Directory (LDAP)

O pfSense permite que os administradores e usuários de VPN utilizem suas credenciais do Windows (AD).

### ⚙️ Configuração (System > User Manager > Authentication Servers)
*   **Type:** LDAP.
*   **Hostname:** IP do Domain Controller.
*   **Base DN:** `DC=empresa,DC=com`.
*   **Authentication Containers:** `OU=Usuarios,DC=empresa,DC=com`.
*   **Bind Credentials:** Um usuário de serviço no AD com permissão de leitura.

---

## 2. RADIUS Server (FreeRADIUS)

O pacote **FreeRADIUS** no pfSense permite transformar o firewall em um servidor de autenticação para switches, Wi-Fi (WPA2/3 Enterprise) e VPNs.

### 📶 Casos de Uso
*   **Wi-Fi Corporativo:** Usuários logam no Wi-Fi com seu próprio login/senha do AD.
*   **Switch Port Security (802.1X):** Uma porta de rede só libera tráfego após a autenticação do dispositivo.

---

## 3. Autenticação de Dois Fatores (2FA/MFA)

Para conformidade com **PCI-DSS** e **HIPAA**, o 2FA é obrigatório.

### Opções no pfSense:
1.  **Google Authenticator (TOTP):** Integrado nativamente no User Manager.
2.  **Duo Security:** Via RADIUS Proxy.
3.  **Certificados Digitais:** Autenticação mútua (Certificado + Senha).

---

## 🛡️ Melhores Práticas
*   **Fallback:** Sempre mantenha um usuário local de emergência (break-glass) caso o servidor AD/LDAP fique offline.
*   **Grupos:** Mapeie grupos do AD para "Scopes" no pfSense para controlar quem pode apenas ver logs e quem pode alterar regras.
*   **LDAPS:** Utilize sempre a porta `636` (LDAP sobre SSL) para evitar o envio de credenciais em texto claro na rede interna.

---
*Dica: Teste a autenticação em `Diagnostics > Authentication` antes de aplicá-la globalmente.*
