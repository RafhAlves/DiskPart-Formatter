#!/usr/bin/env python3
import subprocess
import tempfile
import os
import sys

def run_powershell_get_disks():
    try:
        cmd = ['powershell', '-NoProfile', '-Command',
               'Get-Disk | Select-Object Number, FriendlyName, Size, PartitionStyle | Format-Table -AutoSize']
        res = subprocess.run(cmd, capture_output=True, text=True, check=False)
        return res.stdout
    except Exception as e:
        return f"Erro ao listar discos: {e}"

def write_and_run_diskpart(script_text):
    fd, path = tempfile.mkstemp(suffix=".txt")
    os.close(fd)
    with open(path, "w", encoding="ascii") as f:
        f.write(script_text)
    try:
        print("\nExecutando diskpart...")
        subprocess.run(['diskpart', '/s', path], check=True)
    finally:
        try:
            os.remove(path)
        except:
            pass

def main():
    print("DiskPart Formatter - Python TUI (fallback)")
    print("=== Discos detectados (via PowerShell) ===")
    print(run_powershell_get_disks())
    disk = input("\nDigite o número do disco a ser formatado: ").strip()
    confirm = input(f"Tem certeza que deseja formatar o disco {disk}? (S/N): ").strip().lower()
    if confirm != 's':
        print("Cancelando.")
        sys.exit(0)

    print("\nEscolha o tipo de particionamento:")
    print("1 - GPT (UEFI)")
    print("2 - MBR (Legacy BIOS)")
    tipo = input("Digite 1 ou 2: ").strip()
    if tipo == '1':
        convert = "convert gpt"
        active_cmd = ""
    elif tipo == '2':
        convert = "convert mbr"
        active_cmd = "active"
    else:
        print("Opção inválida.")
        sys.exit(1)

    print("\nEscolha a operação:")
    print("1 - Formatação normal")
    print("2 - Pendrive bootável Windows")
    print("3 - Pendrive bootável Linux / ISO")
    print("4 - Formatar para armazenamento")
    op = input("Digite 1,2,3 ou 4: ").strip()

    drive_letter = input("Letra para atribuir (ex: E): ").strip().upper()
    fs = "ntfs"
    if op == '1':
        fs = input("Sistema de arquivos (NTFS/exFAT/FAT32) [NTFS]: ").strip() or "ntfs"
    elif op == '2':
        fs = "ntfs"
    elif op == '3':
        fs = "fat32"
    elif op == '4':
        print("1 - NTFS\n2 - exFAT\n3 - FAT32")
        one = input("Escolha 1,2 ou 3: ").strip()
        if one == '1':
            fs = "ntfs"
        elif one == '2':
            fs = "exfat"
        elif one == '3':
            fs = "fat32"
        else:
            print("Opção inválida.")
            sys.exit(1)
    else:
        print("Opção inválida.")
        sys.exit(1)

    diskpart_script = f"""select disk {disk}
clean
{convert}
create partition primary
{active_cmd}
format fs={fs} quick
assign letter={drive_letter}
exit
"""
    print("\nDiskPart script que será executado:")
    print(diskpart_script)
    final = input("Executar agora? (S/N): ").strip().lower()
    if final != 's':
        print("Cancelando.")
        sys.exit(0)

    write_and_run_diskpart(diskpart_script)
    print("Concluído.")

if __name__ == '__main__':
    main()
