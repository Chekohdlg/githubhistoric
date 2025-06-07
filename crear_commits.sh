#!/bin/bash

# --- Configuración ---
REPO_DIR=$(pwd) # Directorio actual donde se ejecutará el script
FILE_TO_MODIFY="historial_cambios.txt"
BRANCH_NAME="main" # O 'master' si es tu rama principal

# --- Función para generar commits ---
generate_commits() {
    read -p "Introduce la fecha de inicio (YYYY-MM-DD): " START_DATE

    # Validar la fecha de inicio
    # Use BSD-date compatible validation: -j (don't set time), -f (input format)
    if ! date -j -f "%Y-%m-%d" "$START_DATE" +"%Y-%m-%d" &>/dev/null; then
        echo "Error: Formato de fecha inválido o comando 'date' no compatible con '-d'. Usa YYYY-MM-DD."
        echo "Si estás en macOS, esta versión intenta usar la sintaxis de BSD 'date'."
        exit 1
    fi

    CURRENT_DATE=$(date +%Y-%m-%d)
    ITER_DATE="$START_DATE"

    echo "Generando commits desde $START_DATE hasta $CURRENT_DATE..."

    # Calculate target end date using BSD-date compatible syntax for adding a day
    TARGET_END_DATE_PLUS_ONE=$(date -j -v+1d -f "%Y-%m-%d" "$CURRENT_DATE" "+%Y-%m-%d")
    while [[ "$ITER_DATE" != "$TARGET_END_DATE_PLUS_ONE" ]]; do
        COMMIT_MESSAGE="Cambio para el día: $ITER_DATE"
        FILE_CONTENT="Este es el historial de cambios."
        APPEND_LINE="[Fecha: $ITER_DATE] Se realizó una actualización."

        # Agrega el contenido base si el archivo es nuevo, o solo la nueva línea
        if [ ! -f "$FILE_TO_MODIFY" ]; then
            echo "$FILE_CONTENT" > "$FILE_TO_MODIFY"
        fi
        echo "$APPEND_LINE" >> "$FILE_TO_MODIFY"

        # Agrega y commitea con la fecha especificada
        GIT_AUTHOR_DATE="$ITER_DATE 12:00:00" GIT_COMMITTER_DATE="$ITER_DATE 12:00:00" \
        git add "$FILE_TO_MODIFY"
        GIT_AUTHOR_DATE="$ITER_DATE 12:00:00" GIT_COMMITTER_DATE="$ITER_DATE 12:00:00" \
        git commit -m "$COMMIT_MESSAGE"

        echo "  Commit creado para $ITER_DATE"

        # Avanza al siguiente día
        # Use BSD-date compatible syntax for adding a day: -v+1d
        ITER_DATE=$(date -j -v+1d -f "%Y-%m-%d" "$ITER_DATE" "+%Y-%m-%d")
    done

    echo "Proceso completado. Se han generado commits diarios hasta el día de hoy."
}

# --- Ejecutar la función principal ---
generate_commits