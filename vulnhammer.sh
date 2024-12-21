#!/bin/bash

# Función principal del script
function vulnhammer {

    # Subfunción para buscar vulnerabilidades SSH
    vssh() {
        echo "Iniciando análisis de vulnerabilidades SSH..."

        # Verificar si el script se ejecuta como root
        if [ "$(id -u)" -ne 0 ]; then
            echo "[ERR]: Este script debe ejecutarse con privilegios de superusuario."
            exit 1
        fi

        # Realizar una comprobación de configuraciones inseguras en SSH

        # Verificar si el acceso root está habilitado
        if grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config; then
            echo "[LOG]: ¡Advertencia! El acceso root está habilitado en SSH. Esto podría ser un riesgo de seguridad."
        else
            echo "[OK]: El acceso root está deshabilitado en SSH."
        fi

        # Comprobar si el protocolo SSH v1 está habilitado
        if grep -q "^Protocol 1" /etc/ssh/sshd_config; then
            echo "[LOG]: ¡Advertencia! El protocolo SSH v1 está habilitado. Deberías usar SSH v2 para mayor seguridad."
        else
            echo "[OK]: El protocolo SSH v2 está habilitado."
        fi

        # Verificar si se está utilizando una contraseña débil
        if ssh-keygen -F your_host_name_here > /dev/null; then
            echo "[OK]: Las claves SSH ya están configuradas. Verifica que no sean débiles."
        else
            echo "[LOG]: No se encontraron claves SSH configuradas. Esto puede indicar que las claves no están configuradas correctamente."
        fi

        # Comprobar si el archivo de configuración de SSH está restringido
        if [ -f /etc/ssh/sshd_config ]; then
            perms=$(stat -c %a /etc/ssh/sshd_config)
            if [ "$perms" -gt 600 ]; then
                echo "[OK]: El archivo de configuración SSH tiene permisos adecuados."
            else
                echo "[LOG]: ¡Advertencia! El archivo de configuración SSH no tiene permisos restrictivos, lo que puede ser un riesgo de seguridad."
            fi
        fi

        echo "Análisis de SSH completado."
    }

}
