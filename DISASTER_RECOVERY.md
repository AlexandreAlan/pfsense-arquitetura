# 🌪️ Disaster Recovery Plan (DRP): pfSense

Este guia estabelece os procedimentos para restaurar a infraestrutura de rede no menor tempo possível em caso de falha catastrófica de hardware ou software.

---

## 1. Estratégia de Backup (Prevenção)

*   **Backup Automático (Auto Config Backup):** [X] Habilitado (Netgate Cloud).
*   **Backup Local Offline:** Realizado após cada mudança significativa (salvo em local seguro e criptografado).
*   **Versionamento:** Backups sanitizados (via script) armazenados neste repositório Git.

---

## 2. Cenários de Recuperação

### Cenário A: Falha de Disco (SSD/HDD)
1.  Substituir o disco físico.
2.  Reinstalar a mesma versão do pfSense (usar ZFS).
3.  No final da instalação, selecionar "Restore config.xml".

### Cenário B: Falha Total do Hardware (Appliance Queimado)
1.  Providenciar hardware novo (mesmo se for diferente).
2.  Instalar pfSense.
3.  Restaurar o `config.xml`.
4.  **Remapeamento de Interfaces:** O pfSense pedirá para você remapear as interfaces antigas (ex: `igb0`, `igb1`) para as novas (ex: `em0`, `em1`).

---

## 3. Matriz de Prioridade de Restauração

| Ordem | Serviço | Impacto se Down |
| :--- | :--- | :--- |
| 1 | Conectividade WAN | Total (sem Internet) |
| 2 | VPN Site-to-Site | Comunicação entre Filiais |
| 3 | Regras de Firewall | Segurança Comprometida |
| 4 | VPN Road Warrior | Usuários Remotos sem Acesso |
| 5 | Monitoring (Telegraf) | Perda de Visibilidade (Baixo Impacto) |

---

## 🛠️ Procedimento de "Break-Glass" (Emergência)

1.  Mantenha um pendrive com a imagem `.iso` do pfSense pronta.
2.  Mantenha um pendrive com o último arquivo `config.xml` criptografado.
3.  Tenha documentado os IPs estáticos dos gateways do seu ISP.

---

## 🔄 Teste de Recuperação (Anual)
Uma vez por ano, restaure o backup em uma Máquina Virtual (VM) e valide se as regras e VPNs sobem corretamente. Um backup que nunca foi testado não é um backup confiável.

---
*Status: Este plano deve ser atualizado sempre que houver mudanças na topologia WAN ou troca de hardware core.*
