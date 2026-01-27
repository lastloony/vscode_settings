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

## Настройка терминала с Oh My Posh

### Установка Nerd Font

Для корректного отображения иконок в терминале необходимо установить шрифт с поддержкой Powerline/Nerd Fonts.

#### Шаг 1: Скачивание шрифта

1. Перейдите на [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
2. Скачайте один из рекомендуемых шрифтов:
   - **AdwaitaMono Nerd Font** (Agave)
   - **Meslo LGM NF**
   - **FiraCode Nerd Font**
   - **JetBrains Mono Nerd Font**

Или скачайте напрямую с GitHub:
```
https://github.com/ryanoasis/nerd-fonts/releases/latest
```

#### Шаг 2: Установка шрифта в Windows

1. Распакуйте скачанный `.zip` файл
2. Выделите все `.ttf` файлы
3. Правой кнопкой мыши → **"Установить для всех пользователей"**
4. Или перетащите файлы в `C:\Windows\Fonts`

#### Шаг 3: Настройка VSCode

Добавьте в `settings.json`:
```json
{
    "terminal.integrated.fontFamily": "AdwaitaMono Nerd Font",
    "terminal.integrated.fontSize": 14
}
```

### Установка Oh My Posh

Oh My Posh - это кастомизируемый prompt engine для любой оболочки.

#### Установка через winget (рекомендуется)

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

#### Установка через PowerShell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```

### Настройка PowerShell

1. Откройте профиль PowerShell:
```powershell
notepad $PROFILE
```

2. Если файл не существует, создайте его:
```powershell
New-Item -Path $PROFILE -Type File -Force
notepad $PROFILE
```

3. Добавьте в файл (рекомендуемая тема по умолчанию):
```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
```

Или используйте базовую инициализацию без указания темы:
```powershell
oh-my-posh init pwsh | Invoke-Expression
```

4. Сохраните файл и перезагрузите профиль:
```powershell
. $PROFILE
```

### Просмотр и смена темы (опционально)

#### Просмотр доступных тем

```powershell
Get-PoshThemes
```

#### Популярные темы

- `jandedobbeleer` (рекомендуемая тема по умолчанию)
- `agnoster`
- `paradox`
- `powerlevel10k_rainbow`
- `atomic`
- `blue-owl`
- `quick-term`

Чтобы изменить тему, отредактируйте `$PROFILE` и укажите другую тему:
```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
```

### Проверка установки

Перезапустите терминал - вы должны увидеть красивый prompt с иконками и темой `jandedobbeleer`. Если иконки отображаются как квадратики `�` или знаки вопроса, проверьте настройки шрифта.

### Troubleshooting

#### Иконки не отображаются
- Убедитесь, что установлен Nerd Font
- Проверьте настройки шрифта в Windows Terminal и VSCode
- Перезапустите терминал/VSCode

#### Oh My Posh не запускается
Проверьте ExecutionPolicy:
```powershell
Get-ExecutionPolicy
```

Если возвращает `Restricted`, установите:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Медленная загрузка PowerShell
- Oh My Posh может немного замедлить запуск терминала
- Рассмотрите использование более простой темы
- Или используйте тему с меньшим количеством сегментов

### Полезные ссылки

- [Oh My Posh Documentation](https://ohmyposh.dev/)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [Oh My Posh Themes](https://ohmyposh.dev/docs/themes)
- [GitHub - Oh My Posh](https://github.com/JanDeDobbeleer/oh-my-posh)
