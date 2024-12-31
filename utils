# Colors

BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
RESET="\e[0m"

# Background Colors

BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"

# Text modes.

BOLD="\e[1m"
UNDERLINE="\e[4m"
INVERT="\e[7m"
HIDDEN="\e[8m"

#-- LOG SERVICE

# Función para imprimir log con colores
log_() {
    local message=$1
    local color=$2
    echo -e -n "${YELLOW}[LOG]: ${RESET}"
    echo -e "${color}${message}${RESET}"
}

# Función para imprimir log con timestamp
log_w() {
    local message=$1
    local color=$2
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e -n "${YELLOW}[LOG]: ${RESET}"
    echo -e "${color}[${timestamp}] ${message}${RESET}"
}


#-- START SERVICE

# Función para iniciar servicios
start() {
    if [[ -z "$1" ]]; then
        echo "Uso: start <servicio>"
        return 1
    fi

    local service_name="$1"

    # Detectar y corregir el nombre del servicio si es necesario
    if [[ "$service_name" == "ssh" ]]; then
        service_name="sshd"
    fi

    # Iniciar el servicio
    sudo systemctl start "$service_name" && \
    echo -e -n "${YELLOW}[LOG]: ${RESET}
    echo "Servicio '$service_name' iniciado correctamente." || \"
    echo "Error al iniciar el servicio '$service_name'."
}



