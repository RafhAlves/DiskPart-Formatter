# DiskPart Formatter

![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-supported-blue)

**DiskPart Formatter** é um script interativo para Windows (PowerShell) que simplifica a formatação de discos, criação de pendrives bootáveis (Windows/Linux) e preparação de unidades para armazenamento.

> ⚠️ **AVISO:** Este script APAGA COMPLETAMENTE o disco selecionado. Use com extremo cuidado e somente em discos que você tem certeza.

## Conteúdo deste repositório

- `diskpart_formatter.ps1` - Script PowerShell interativo (versão colorida).
- `demo.gif` - GIF demonstrativo do menu (simulação).
- `tui_fallback.py` - Script Python com interface de terminal (fallback sem dependências externas).

## Recursos

- Listagem automática de discos (via `Get-Disk`)
- Seleção interativa do disco
- Suporte a **GPT** e **MBR**
- Marcação automática de partição **active** quando MBR
- Opções:
  - Formatação normal
  - Criar pendrive bootável Windows
  - Criar pendrive bootável Linux / ISO genérica
  - Formatar disco para armazenamento (NTFS / exFAT / FAT32)
- Menus coloridos para melhor leitura

## Como usar (PowerShell)

1. Baixe `diskpart_formatter.ps1` para sua máquina Windows.
2. Abra o **PowerShell como Administrador**.
3. Navegue até a pasta onde salvou o script.
4. Execute:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\diskpart_formatter.ps1
