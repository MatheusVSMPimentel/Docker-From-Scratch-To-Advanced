#!/bin/bash
# entrypoint.sh

# Aguarda o início do SQL Server e executa o script setup.sql
# Loop até que o sqlservr esteja disponível

set -e

# Inicia o SQL Server em background
/opt/mssql/bin/sqlservr &

# Aguarda a inicialização do SQL Server
until /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -Q 'SELECT 1'; do
    echo "SQL Server ainda não está disponível..."
    sleep 5
done

echo "SQL Server iniciado."

# Executa o script SQL
echo "Executando o script 'setup.sql'..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i /docker-entrypoint-initdb.d/setup.sql

echo "Script 'setup.sql' executado com sucesso."

# Mantém o processo em foreground para que o Docker possa gerenciá-lo
wait
