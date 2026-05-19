# 📊 SNMP: Monitoramento de Ativos

O **SNMP (Simple Network Management Protocol)** permite que sistemas externos (Zabbix, PRTG, Observium) monitorem o estado de saúde do pfSense.

---

## ⚙️ Versões Suportadas
*   **v2c:** Mais comum, utiliza `Community String` (texto claro).
*   **v3:** Recomendada para produção, suporta criptografia e autenticação de usuário.

## 📋 Métricas Monitoradas (MIBs)
*   Uso de CPU e Memória.
*   Tráfego por Interface (Banda In/Out).
*   Status de Gateways e VPNs.
*   Temperatura do Processador.

---

## 🛠️ Template XML
O arquivo `template_snmp.xml` contém a configuração para SNMP v2c.
