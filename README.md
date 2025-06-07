# GitHub Historic Commits Generator

Este script de Bash (`crear_commits.sh`) está diseñado para generar commits de Git con fechas históricas. Es útil para simular un historial de commits a lo largo del tiempo, por ejemplo, para poblar un nuevo repositorio con actividad pasada o para propósitos de demostración.

El script iterará desde una fecha de inicio que proporciones hasta el día actual, creando un commit por cada día. Cada commit modificará un archivo específico (`historial_cambios.txt` por defecto) añadiendo una línea con la fecha del commit.

## Características

- Genera commits diarios desde una fecha de inicio especificada hasta la fecha actual.
- Permite personalizar el archivo a modificar y la rama principal.
- Compatible con `date` de GNU (Linux) y BSD (macOS) para el manejo de fechas.
- Establece `GIT_AUTHOR_DATE` y `GIT_COMMITTER_DATE` para cada commit, asegurando que la fecha del commit en el historial de Git sea la fecha iterada.

## Prerrequisitos

- **Bash:** El script está escrito en Bash.
- **Git:** Necesitas tener Git instalado y estar dentro de un repositorio Git inicializado.
- **`date` command:** El script utiliza el comando `date` para la manipulación de fechas. Las versiones para macOS (BSD `date`) y Linux (GNU `date`) son compatibles.

## Configuración

1.  **Clona o crea tu repositorio Git:**

    ```bash
    git init mi_proyecto_historico
    cd mi_proyecto_historico
    ```

2.  **Coloca el script en el repositorio:**
    Copia `crear_commits.sh` en el directorio raíz de tu repositorio Git.

3.  **Hazlo ejecutable:**
    ```bash
    chmod +x crear_commits.sh
    ```

## Uso

1.  **Ejecuta el script:**
    Desde el directorio raíz de tu repositorio Git, ejecuta:

    ```bash
    ./crear_commits.sh
    ```

2.  **Introduce la fecha de inicio:**
    El script te pedirá que introduzcas la fecha de inicio en formato `YYYY-MM-DD`.

    ```
    Introduce la fecha de inicio (YYYY-MM-DD): 2015-01-01
    ```

3.  **Observa el proceso:**
    El script comenzará a generar commits, uno por cada día desde la fecha de inicio hasta la fecha actual. Verás mensajes como:

    ```
    Generando commits desde 2015-01-01 hasta 2024-07-31...
      Commit creado para 2015-01-01
      Commit creado para 2015-01-02
      ...
    Proceso completado. Se han generado commits diarios hasta el día de hoy.
    ```

    El archivo `historial_cambios.txt` (o el nombre que hayas configurado) se creará y/o modificará con cada commit.

## Variables de Configuración (dentro del script)

Puedes modificar las siguientes variables al principio del script `crear_commits.sh` si necesitas personalizar su comportamiento:

- `REPO_DIR`: Por defecto es `$(pwd)`, el directorio actual. Normalmente no necesitas cambiar esto.
- `FILE_TO_MODIFY`: El nombre del archivo que se modificará en cada commit. Por defecto es `"historial_cambios.txt"`.
- `BRANCH_NAME`: El nombre de la rama en la que se realizarán los commits. Por defecto es `"main"`. Cámbialo a `"master"` si esa es tu rama principal.

## ¡Importante!

- **Modificación del Historial:** Este script crea commits con fechas pasadas. Si lo ejecutas en un repositorio que ya tiene un historial y lo subes a un repositorio remoto compartido, podrías reescribir el historial de una manera que cause problemas a otros colaboradores. Úsalo con precaución.
- **Repositorios Nuevos:** Es ideal para usar en repositorios nuevos o en ramas donde no haya historial conflictivo.
- **`git push --force`:** Si necesitas subir estos commits a un repositorio remoto que ya tiene commits en la misma rama, es probable que necesites forzar el push (`git push --force` o `git push --force-with-lease`). **¡Ten mucho cuidado al forzar el push, ya que puede sobrescribir el trabajo de otros!**

## Ejemplo de `historial_cambios.txt`

Después de ejecutar el script, el archivo `historial_cambios.txt` contendrá líneas como estas:
