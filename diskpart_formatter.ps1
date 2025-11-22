# ==================================================== #
#   SCRIPT DE FORMATAÇÃO INTERATIVA DISKPART           #
#  GPT / MBR / Boot Windows / Linux / Armazenamento    #
# ==================================================== #


Write-Host "=== LISTA DE DISCOS ===" -ForegroundColor Cyan
Get-Disk | Select Number, FriendlyName, Size, PartitionStyle | Format-Table

Write-Host ""
Write-Host "Atenção: ESCOLHER O DISCO ERRADO IRÁ APAGAR TODOS OS DADOS!" -ForegroundColor Red

$diskNumber = Read-Host "`nDigite o NÚMERO do disco para formatar"

$confirm = Read-Host "Tem CERTEZA que deseja formatar o DISCO $diskNumber? (S/N)"
if ($confirm -notmatch '^[Ss]$') {
    Write-Host "Operação cancelada." -ForegroundColor Yellow
    exit
}

# TIPO DE PARTICIONAMENTO
Write-Host "`nEscolha o tipo de particionamento:" -ForegroundColor Cyan
Write-Host "1 - GPT (UEFI)" -ForegroundColor Yellow
Write-Host "2 - MBR (BIOS / Legacy)" -ForegroundColor Yellow
$tipo = Read-Host "Digite 1 ou 2"

if ($tipo -eq 1) {
    $convert = "convert gpt"
    $active = ""
} elseif ($tipo -eq 2) {
    $convert = "convert mbr"
    $active = "active"
} else {
    Write-Host "Opção inválida. Cancelando." -ForegroundColor Red
    exit
}

# MENU PRINCIPAL
Write-Host "`n=== O que deseja fazer com o disco? ===" -ForegroundColor Cyan
Write-Host "1 - Formatação normal (rápida)" -ForegroundColor Yellow
Write-Host "2 - Criar pendrive bootável Windows" -ForegroundColor Yellow
Write-Host "3 - Criar pendrive bootável Linux / ISO genérica" -ForegroundColor Yellow
Write-Host "4 - Formatar disco para armazenamento (uso comum)" -ForegroundColor Yellow

$boot = Read-Host "Digite 1, 2, 3 ou 4"


switch ($boot) {

    1 {
        Write-Host "`n=== Formatação normal ===" -ForegroundColor Green
        $driveLetter = Read-Host "Letra da unidade (ex: E)"
        $fs = Read-Host "Sistema de arquivos (NTFS/FAT32/exFAT) [NTFS]"
        if ([string]::IsNullOrWhiteSpace($fs)) { $fs = "NTFS" }

        $diskpartScript = @"
select disk $diskNumber
clean
$convert
create partition primary
$active
format fs=$fs quick
assign letter=$driveLetter
exit
"@
    }

    2 {
        Write-Host "`n=== Criar Pendrive Bootável Windows ===" -ForegroundColor Green
        $driveLetter = Read-Host "Letra da unidade (ex: E)"

        $diskpartScript = @"
select disk $diskNumber
clean
$convert
create partition primary
$active
format fs=ntfs quick
assign letter=$driveLetter
exit
"@

        Write-Host "`nApós finalizar, copie o conteúdo da ISO montada do Windows para o pendrive." -ForegroundColor Cyan
    }

    3 {
        Write-Host "`n=== Criar Pendrive Bootável Linux / ISO ===" -ForegroundColor Green
        $driveLetter = Read-Host "Letra da unidade (ex: E)"

        $diskpartScript = @"
select disk $diskNumber
clean
$convert
create partition primary
$active
format fs=fat32 quick
assign letter=$driveLetter
exit
"@

        Write-Host "`nAlgumas ISOs grandes podem precisar de NTFS." -ForegroundColor Yellow
    }

    4 {
        Write-Host "`n=== Formatação para Armazenamento ===" -ForegroundColor Green

        $driveLetter = Read-Host "Letra da unidade (ex: E)"

        Write-Host "`nEscolha o sistema de arquivos:" -ForegroundColor Cyan
        Write-Host "1 - NTFS (Windows / arquivos grandes)" -ForegroundColor Yellow
        Write-Host "2 - exFAT (compatível com Windows/Mac/TV)" -ForegroundColor Yellow
        Write-Host "3 - FAT32 (máx 4GB por arquivo)" -ForegroundColor Yellow

        $fsOpt = Read-Host "Digite 1, 2 ou 3"

        switch ($fsOpt) {
            1 { $fs = "ntfs" }
            2 { $fs = "exfat" }
            3 { $fs = "fat32" }
            default {
                Write-Host "Opção inválida. Saindo." -ForegroundColor Red
                exit
            }
        }

        $diskpartScript = @"
select disk $diskNumber
clean
$convert
create partition primary
$active
format fs=$fs quick
assign letter=$driveLetter
exit
"@

        Write-Host "`nDisco configurado para armazenamento com $fs." -ForegroundColor Cyan
    }

    default {
        Write-Host "Opção inválida. Saindo." -ForegroundColor Red
        exit
    }
}

# EXECUÇÃO
$tempFile = "$env:TEMP\diskpart_final.txt"
Set-Content -Path $tempFile -Value $diskpartScript -Encoding ASCII

Write-Host "`nExecutando DiskPart..." -ForegroundColor Cyan
diskpart /s $tempFile

Remove-Item $tempFile -Force

Write-Host "`nProcesso concluído com sucesso!" -ForegroundColor Green
