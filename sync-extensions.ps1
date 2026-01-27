# Скрипт синхронизации расширений VS Code
# Удаляет все текущие расширения и устанавливает из файла extensions.txt

Write-Host "=== Синхронизация расширений VS Code ===" -ForegroundColor Cyan
Write-Host ""

# Проверка наличия файла extensions.txt
if (-Not (Test-Path "extensions.txt")) {
    Write-Host "Ошибка: Файл extensions.txt не найден!" -ForegroundColor Red
    Write-Host "Убедитесь, что вы находитесь в папке с настройками." -ForegroundColor Yellow
    exit 1
}

# Удаление всех установленных расширений
Write-Host "Шаг 1: Удаление всех установленных расширений..." -ForegroundColor Yellow
$currentExtensions = code --list-extensions

if ($currentExtensions) {
    $currentExtensions | ForEach-Object {
        Write-Host "  Удаление: $_" -ForegroundColor Gray
        code --uninstall-extension $_ --force
    }
    Write-Host "Все расширения удалены." -ForegroundColor Green
} else {
    Write-Host "Расширения не найдены." -ForegroundColor Gray
}

Write-Host ""

# Установка расширений из файла
Write-Host "Шаг 2: Установка расширений из списка..." -ForegroundColor Yellow
$extensionsToInstall = Get-Content extensions.txt

$installed = 0
$failed = 0

$extensionsToInstall | ForEach-Object {
    Write-Host "  Установка: $_" -ForegroundColor Gray
    $result = code --install-extension $_ 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        $installed++
    } else {
        $failed++
        Write-Host "    Ошибка при установке $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== Синхронизация завершена ===" -ForegroundColor Cyan
Write-Host "Установлено: $installed" -ForegroundColor Green
if ($failed -gt 0) {
    Write-Host "Ошибок: $failed" -ForegroundColor Red
}
Write-Host ""
Write-Host "Перезапустите VS Code для применения изменений." -ForegroundColor Yellow
