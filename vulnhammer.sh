#!/bin/bash

# Función principal del script
function vulnhammer {

    # Subfunción para buscar vulnerabilidades SSH
    vssh() {
        echo "Iniciando análisis de vulnerabilidades SSH..."

        # Realizar una comprobación de configuraciones inseguras en SSH
        # Ejemplo: Verificar si el acceso root está habilitado
        if grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config; then
            echo "[LOG]: ¡Advertencia! El acceso root está habilitado en SSH."
        else
            echo "[OK]: El acceso root está deshabilitado en SSH."
        fi

        # Ejemplo: Comprobar si el protocolo SSH v1 está habilitado
        if grep -q "^Protocol 1" /etc/ssh/sshd_config; then
            echo "[LOG]: ¡Advertencia! El protocolo SSH v1 está habilitado. Debería usar SSH v2."
        else
            echo "[OK]: El protocolo SSH v2 está habilitado."
        fi

        # Ejemplo: Verificar si se está utilizando una contraseña débil
        if ssh-keygen -F your_host_name_here; then
            echo "[OK]: Las claves SSH ya están configuradas. Verifique si son seguras."
        else
            echo "[LOG]: No se encontraron claves SSH configuradas."
        fi

        echo "Análisis de SSH completado."
    }
    
}
