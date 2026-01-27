# Синхронизация настроек VS Code

Этот репозиторий содержит глобальные настройки VS Code для синхронизации между разными машинами.

## Содержимое

- `settings.json` - основные настройки редактора
- `keybindings.json` - горячие клавиши
- `extensions.txt` - список установленных расширений
- `sync-extensions.ps1` - скрипт для синхронизации расширений (PowerShell)

## Первоначальная настройка

### 1. Экспорт настроек с текущей машины

```powershell
# Создать папку для репозитория
mkdir vscode-settings
cd vscode-settings

# Скопировать настройки
cp $env:APPDATA\Code\User\settings.json .
cp $env:APPDATA\Code\User\keybindings.json .

# Экспортировать список расширений
code --list-extensions > extensions.txt

# Инициализировать Git и загрузить в GitHub
git init
git add .
git commit -m "Initial VS Code settings"
git remote add origin https://github.com/ваш-username/vscode-settings.git
git push -u origin main
```

## Установка на новой машине

### 1. Клонировать репозиторий

```powershell
cd ~
git clone https://github.com/ваш-username/vscode-settings.git
cd vscode-settings
```

### 2. Скопировать настройки

```powershell
# Скопировать настройки в папку VS Code
cp settings.json $env:APPDATA\Code\User\
cp keybindings.json $env:APPDATA\Code\User\
```

### 3. Установить расширения

```powershell
# Установить все расширения из списка
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```

Или использовать готовый скрипт:

```powershell

# Запустить скрипт синхронизации
.\sync-extensions.ps1
```

### 4. Перезапустить VS Code

После установки расширений перезапустите VS Code для применения всех изменений.

## Обновление настроек

### Сохранить изменения с текущей машины

```powershell
cd ~/vscode-settings

# Обновить настройки
cp $env:APPDATA\Code\User\settings.json .
cp $env:APPDATA\Code\User\keybindings.json .

# Обновить список расширений
code --list-extensions > extensions.txt

# Закоммитить и загрузить
git add .
git commit -m "Update settings $(Get-Date -Format 'yyyy-MM-dd')"
git push
```

### Получить обновления на другой машине

```powershell
cd ~/vscode-settings

# Получить последние изменения
git pull

# Скопировать обновленные настройки
cp settings.json $env:APPDATA\Code\User\
cp keybindings.json $env:APPDATA\Code\User\

# Синхронизировать расширения
.\sync-extensions.ps1
```

## Расположение настроек VS Code

- **Windows**: `%APPDATA%\Code\User\`
- **macOS**: `~/Library/Application Support/Code/User/`
- **Linux**: `~/.config/Code/User/`

## Примечания

- После синхронизации расширений может потребоваться перезапуск VS Code
- Скрипт `sync-extensions.ps1` удаляет все текущие расширения перед установкой новых
- Настройки применяются глобально для всех проектов
- Для настроек конкретного проекта используйте папку `.vscode` в корне проекта

## Автоматизация (опционально)

Создайте скрипт `update.ps1` для быстрого обновления:

```powershell
# Обновить все настройки одной командой
cp $env:APPDATA\Code\User\settings.json .
cp $env:APPDATA\Code\User\keybindings.json .
code --list-extensions > extensions.txt
git add .
git commit -m "Update settings $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push
Write-Host "Settings updated and pushed!" -ForegroundColor Green
```
