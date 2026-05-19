# 🖥️ pfSense: Virtualização & Cloud

Rodar o pfSense em ambientes virtuais exige configurações específicas para garantir estabilidade e performance próxima ao hardware real (bare-metal).

---

## 🦄 Proxmox VE (KVM) - Best Practices

O Proxmox é a plataforma ideal para virtualizar o pfSense em laboratórios e produção.

### ⚙️ Configuração da VM
*   **CPU:** Tipo `host` (permite que o pfSense use instruções AES-NI para criptografia).
*   **NICs:** Utilizar o driver `VirtIO (paravirtualized)`. Desativar o "Firewall" nas opções da interface do Proxmox para evitar conflitos.
*   **QEMU Agent:** Ativar para permitir o shutdown seguro via Proxmox.

### 🚀 Performance (SR-IOV / Passthrough)
Para throughput acima de 1Gbps, considere o **PCI Passthrough** da placa de rede diretamente para a VM do pfSense. Isso elimina o overhead do vSwitch do Proxmox.

---

## 🏢 VMware ESXi

*   **NICs:** Utilizar `VMXNET3`.
*   **Promiscuous Mode:** Deve estar habilitado no vSwitch se você estiver usando **CARP (HA)**, caso contrário, o VIP não funcionará.
*   **Hardware Version:** Utilizar a versão mais recente compatível com seu host.

---

## ☁️ pfSense na Nuvem (AWS / Azure)

### AWS (Amazon Web Services)
*   **Instância:** Utilizar a AMI oficial da Netgate.
*   **Source/Dest Check:** **IMPORTANTE.** Deve ser desabilitado na instância do pfSense no console AWS para permitir o roteamento de outras subnets.
*   **Elastic IP:** Atribuir à interface WAN.

### Azure
*   **Accelerated Networking:** Habilitar se a instância suportar para menor latência.
*   **UDR (User Defined Routes):** Configurar no Azure para que o tráfego das subnets internas aponte para o IP interno do pfSense como Gateway.

---

## 🔒 Hardening Virtual
1.  **Isolamento de VLANs:** Garanta que as VLANs do hipervisor correspondam exatamente às do pfSense.
2.  **Snapshots:** Sempre tire um snapshot antes de atualizar o pfSense.
3.  **Clock Sync:** Certifique-se de que o host e a VM estão sincronizados (NTP).

---
*Dica: Em ambientes virtuais, desativar Hardware Checksum Offloading no pfSense é obrigatório para evitar pacotes corrompidos.*
