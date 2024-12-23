jxtr() {
    local config_file=$1  # Primer argumento: archivo de configuración
    local data_key=$2     # Segundo argumento: clave de los datos a extraer
    local result           # Variable para almacenar el resultado

    # Validamos si el archivo de configuración existe
    if [[ ! -f "$config_file" ]]; then
        echo -n "[ERR]: "
        echo "El archivo no existe."
        return 1
    fi

    # Usamos jq para extraer el valor de la clave especificada
    result=$(jq -r "$data_key" "$config_file")  # Extraemos el dato con la clave proporcionada

    # Verificamos si jq encontró algún resultado
    if [[ "$result" == "null" ]]; then
        echo -n "[ERR]: "
        echo "No se encontró el dato '$data_key'."
        return 2
    fi
    
}
