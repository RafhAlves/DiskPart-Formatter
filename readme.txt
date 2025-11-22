# 🧰 DiskPart Formatter – Script Interativo para Formatação e Preparação de Discos

Este projeto fornece um script interativo para Windows que utiliza o **DiskPart** para formatar discos, criar partições, preparar pendrives bootáveis e gerenciar estruturas MBR/GPT, tudo com menus coloridos e interface simples.

---

## 🚀 Recursos Principais

* Interface interativa com **menus coloridos**
* Lista automaticamente todos os discos disponíveis
* Opções para:

  * Criar disco **MBR** com partição ativa (compatível com BIOS/Legacy)
  * Criar disco **GPT** (recomendado para UEFI)
  * Criar **pendrive bootável**
  * Apenas **formatar o disco para uso normal**
* Perguntas guiadas para evitar erros
* Gera e executa automaticamente o arquivo de comandos DiskPart
* Limpeza completa com `clean`
* Marca partição ativa quando necessário
* Compatível com Windows 10 e 11

---

## 📦 Estrutura do Projeto

* `script.cmd` → Script principal em Shell com menus coloridos
* `demo.gif` → Demonstração animada do funcionamento do script
* `script.ps1` → Versão PowerShell do script
* `tui.py` → Interface TUI em Python para interagir com DiskPart
* `README.md` → Documentação completa

---

## 📸 Demonstração (GIF)

Veja abaixo uma simulação do comportamento do script (arquivo `demo.gif`).

> Demonstração mostrando a navegação pelos menus, listagem de discos e seleção das opções de formatação.

---

## 🛠️ Tecnologias Utilizadas

* Shell Script (`.cmd`)
* PowerShell
* Python (para a interface TUI)
* DiskPart (Windows)
* ANSI Escape Codes para cores

---

## 📄 Uso

1. Execute o script como **Administrador**:

```
script.cmd
```

2. Escolha uma das opções no menu:

   * 1: Criar disco MBR ativo
   * 2: Criar disco GPT
   * 3: Criar Pendrive Bootável
   * 4: Formatar disco para uso normal

3. Confirme o número do disco e aguarde.

---

## ⚠️ Aviso Importante

Este script **apaga completamente o disco selecionado**.
Use apenas se souber exatamente o que está fazendo.

---

## 🤝 Contribuições

Pull requests são bem-vindos.

---

## 📜 Licença

Projeto disponível sob a licença MIT.
