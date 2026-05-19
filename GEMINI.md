# 🤖 AI Instructions - pfSense Architecture Management

Este arquivo fornece diretrizes contextuais para agentes de IA (como o Gemini CLI) que operam neste repositório.

## 🎯 Objetivo do Projeto
Manter a documentação de infraestrutura de rede (pfSense) precisa, segura e atualizada, servindo como a única fonte da verdade para configurações de firewall, VPN e roteamento.

## 🛠️ Workflows Obrigatórios

### 1. Documentação de Novas Regras
Sempre que uma regra for documentada no \`/firewall-rules/README.md\`, siga o formato:
- **ID/Nome:** \`[ORIGEM] to [DESTINO] - [PORT/SRV]\`
- **Propósito:** Justificativa técnica do acesso.
- **Data/Autor:** Data da implementação.

### 2. Sanitização de Backups
Ao lidar com arquivos \`.xml\` de configuração:
- **NUNCA** sugira o commit de um arquivo XML bruto.
- **SEMPRE** execute o script \`scripts/sanitize_pfsense.sh\` antes de qualquer movimentação para a área de staging do Git.

### 3. Diagramas Mermaid
- Ao atualizar a topologia, utilize a sintaxe \`mermaid\` diretamente no Markdown.
- Priorize diagramas de fluxo de pacotes para explicar regras de NAT complexas.

## 🔒 Regras de Segurança (Mandatórias)
- **Zero Secrets:** Nunca imprima chaves PSK, senhas de usuários ou certificados privados nos logs ou no conteúdo do repositório.
- **Aliases:** Recomende sempre a criação de Aliases no pfSense para substituir IPs isolados na documentação.
- **Default Deny:** Toda sugestão de configuração deve partir do princípio de bloqueio total, liberando apenas o estritamente necessário (Princípio do Menor Privilégio).

## 📂 Convenções de Estrutura
- \`/nat\`: Documentar Port Forwards (Inbound) e Outbound regras.
- \`/vpn-ipsec\`: Detalhar Fase 1 (IKE) e Fase 2 (ESP).
- \`/scripts\`: Scripts de automação devem conter cabeçalhos explicativos e tratamento de erro.

---
*Este arquivo deve ser atualizado conforme novas práticas de segurança ou padrões de rede forem adotados.*
