# Masivo.sh

## Descripción

**Masivo.sh** es un script en Bash diseñado para procesar de manera masiva archivos con extensión `.rar`. Este script verifica si los archivos requieren contraseña para extraer su contenido y maneja los casos de archivos desconocidos que no sean `.rar`.

## Características

- Verifica si el usuario ha proporcionado argumentos al ejecutar el script.
- Itera sobre una lista de archivos ingresados como argumentos.
- Identifica archivos con extensión `.rar`.
- Detecta si un archivo `.rar` requiere contraseña para su extracción.
- Solicita la contraseña al usuario en caso necesario.
- Extrae el contenido de los archivos `.rar`, con o sin contraseña.
- Muestra un mensaje para archivos desconocidos que no sean `.rar`.

## Requisitos

- **Bash**: Este script está escrito en Bash y se ejecuta en sistemas compatibles con Bash.
- **UnRAR**: El script utiliza la herramienta `unrar` para manejar los archivos `.rar`. Asegúrate de que esté instalada en tu sistema.

Para instalar `unrar` en sistemas basados en Debian/Ubuntu:
```bash
sudo apt-get install unrar
```

En sistemas basados en Arch Linux:
```bash
sudo pacman -S unrar
```

## Uso

1. Asegúrate de que el script sea ejecutable:
   ```bash
   chmod +x Masivo.sh
   ```

2. Ejecuta el script proporcionando una lista de archivos como argumentos:
   ```bash
   ./Masivo.sh archivo1.rar archivo2.rar archivo3.rar
   ```

### Ejemplo de uso

Supongamos que tienes los siguientes archivos en tu directorio actual:
- `archivo1.rar` (sin contraseña).
- `archivo2.rar` (con contraseña).
- `archivo3.txt` (archivo desconocido).

Ejecución:
```bash
./Masivo.sh archivo1.rar archivo2.rar archivo3.txt
```

Salida esperada:
```bash
Extraído el contenido de archivo1.rar
Ingresa la contraseña: [contraseña]
Extraído el contenido de archivo2.rar
archivo3.txt es un archivo desconocido
```

## Cómo funciona

1. **Verificación de argumentos:**
   - Si el usuario no proporciona ningún argumento, el script muestra un ejemplo de uso y termina la ejecución.

2. **Lista de argumentos:**
   - Todos los argumentos proporcionados al script se almacenan en una lista.

3. **Extracción de archivos `.rar`:**
   - Verifica si el archivo tiene extensión `.rar`.
   - Detecta si el archivo `.rar` requiere una contraseña:
     - Si requiere, solicita la contraseña al usuario y la utiliza para extraer el contenido.
     - Si no requiere contraseña, extrae el contenido directamente.

4. **Archivos desconocidos:**
   - Si el archivo no tiene extensión `.rar`, muestra un mensaje indicando que es un archivo desconocido.

## Lógica del código

```bash
# Verifica si se han ingresado argumentos
if [ -z "$1" ]; then
    echo "ejemplo de como usar:"
    echo "Masivo.sh <argumento1> <argumento2>"
    exit 1
fi

# Almacena los argumentos en una lista
lista=("$@")

# Inicializa la variable para contraseña
password=""

# Detecta si el archivo requiere contraseña
if unrar l "${lista}" &>/dev/null; then
    read -p "Ingresa la contraseña: " password
fi

# Itera sobre la lista de archivos
for i in ${lista[@]}; do
    if [[ "${i: -4}" == ".rar" ]]; then
        if unrar l "$i" &>/dev/null; then
            unrar x -p"$password" "$i"
        else 
            unrar x "$i"
        fi
    else
        echo "$i Es un archivo desconocido"
    fi
done
```

## Licencia

Este proyecto está licenciado bajo la [MIT License](LICENSE). Puedes usar, modificar y distribuir este script libremente.

---

© 2025, Brian Arguello.
