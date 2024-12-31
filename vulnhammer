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

    # Subfunción para configurar la seguridad de SSH
    configure_security() {
        echo "Configurando seguridad de SSH..."

        # Deshabilitar el acceso root en SSH
        sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
        echo "[OK]: Acceso root deshabilitado en SSH."

        # Habilitar solo SSH v2
        sed -i 's/^Protocol 1/Protocol 2/' /etc/ssh/sshd_config
        echo "[OK]: Protocolo SSH v2 habilitado."

        # Restringir permisos del archivo de configuración
        chmod 600 /etc/ssh/sshd_config
        echo "[OK]: Permisos del archivo /etc/ssh/sshd_config configurados."

        # Reiniciar SSH para aplicar los cambios
        systemctl restart sshd
        echo "[OK]: Servicio SSH reiniciado con la nueva configuración."
    }

    # Subfunción para configurar el firewall
    configure_firewall() {
        echo "Configurando firewall..."

        # Asegurarse de que UFW esté instalado
        if ! command -v ufw &> /dev/null; then
            echo "[ERR]: UFW no está instalado. Instalando..."
            apt-get install -y ufw
        fi

        # Habilitar reglas básicas del firewall para SSH
        ufw allow OpenSSH
        ufw enable
        echo "[OK]: Firewall configurado para permitir SSH."

        # Asegurarse de que el firewall esté activo
        ufw status verbose
    }

    # Subfunción para configurar Fail2Ban
    configure_fail2ban() {
        echo "Configurando Fail2Ban..."

        # Asegurarse de que Fail2Ban esté instalado
        if ! command -v fail2ban-client &> /dev/null; then
            echo "[ERR]: Fail2Ban no está instalado. Instalando..."
            apt-get install -y fail2ban
        fi

        # Reiniciar Fail2Ban para aplicar cualquier configuración
        systemctl restart fail2ban
        echo "[OK]: Fail2Ban configurado y reiniciado."

        # Verificar el estado de Fail2Ban
        fail2ban-client status sshd
    }

    # Si se pasa el flag -crt, ejecutar la configuración adicional
    if [[ "$1" == "-crt" ]]; then
        configure_security
        configure_firewall
        configure_fail2ban
    else
        vssh
    fi
}
