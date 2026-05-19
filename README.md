# 🛡️ Arquitetura e Configurações - pfSense

Este repositório documenta as configurações e as práticas de arquitetura de rede adotadas utilizando o firewall pfSense. O objetivo é manter um registro centralizado das políticas de segurança, túneis VPN e direcionamento de tráfego.

## Estrutura do Repositório

* \`/firewall-rules\` - Políticas de isolamento (VLANs) e tráfego LAN/WAN.
* \`/nat\` - Regras de Port Forwarding e Outbound NAT.
* \`/vpn-ipsec\` - Configurações de túneis Site-to-Site.
* \`/vpn-openvpn\` - Configuração de VPN Road Warrior para acesso remoto seguro.
* \`/pfblockerng\` - Listas de bloqueio de IP e DNS sinkhole.

---
**Nota:** Nenhuma credencial, IP público ou chave pré-compartilhada (PSK) real está exposta neste repositório.
