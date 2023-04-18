#!/bin/bash

# script pra rodar novamente o server automático em caso de crash
echo "Iniciando"

cd /home//home/server1305
mkdir -p logs

ulimit -c unlimited
set -o pipefail

gdb --batch -return-child-result --command=debugcommand --args ./otbr 2>&1 | awk '{ print strftime("%F %T - "), $0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"