#!/usr/bin/env bash
# =============================================================================
# processes.sh — Laboratório 03: processos
# =============================================================================
# Este script consulta processos em execução (somente leitura).
# Ele NÃO envia sinais de término (kill) automaticamente.
# =============================================================================

set -euo pipefail

echo "=============================================="
echo " Laboratório 03 — Processos no Linux"
echo "=============================================="
echo
echo "Um processo é um programa em execução, com um PID (identificador)."
echo "Este script apenas observa. Nenhum processo será encerrado."
echo

echo "[1] Comando: ps"
echo "    O que faz: lista processos da sessão atual."
echo "    Resultado:"
ps
echo

echo "[2] Comando: ps aux | head -n 12"
echo "    O que faz: visão mais ampla (usuário, PID, CPU, memória, comando)."
echo "    Usamos head para limitar a saída."
echo "    Resultado:"
ps aux | head -n 12
echo

echo "[3] Comando: ps -u \"$(whoami)\" | head -n 15"
echo "    O que faz: lista processos do SEU usuário."
echo "    Em segurança, comece sempre pelo que pertence à sua conta."
echo "    Resultado:"
ps -u "$(whoami)" | head -n 15
echo

echo "[4] Como identificar um processo"
echo "    Colunas importantes em ps aux:"
echo "      USER  — quem iniciou o processo"
echo "      PID   — número único do processo"
echo "      %CPU  — uso de processador"
echo "      %MEM  — uso de memória"
echo "      COMMAND — o que está rodando"
echo

if command -v pgrep >/dev/null 2>&1; then
  echo "[5] Comando: pgrep -a bash | head -n 5"
  echo "    O que faz: encontra processos pelo nome (exemplo: bash)."
  echo "    Resultado:"
  pgrep -a bash | head -n 5 || true
  echo
else
  echo "[5] pgrep não está disponível neste sistema."
  echo
fi

echo "[6] Sobre top e htop"
echo "    top  — monitor em tempo real no terminal (pressione q para sair)."
echo "    htop — versão mais amigável, se estiver instalada."
echo "    Este script NÃO abre top/htop automaticamente, porque são interativos."
echo "    Experimente depois: top"
echo

echo "[7] Sobre kill (NÃO executado aqui)"
echo "    kill envia um sinal a um processo. O mais comum é SIGTERM (15),"
echo "    que pede um encerramento educado."
echo "    Exemplo (NÃO execute sem saber o PID): kill 1234"
echo "    Nunca mate processos do sistema sem entender o impacto."
echo

echo "Por que isso importa para segurança?"
echo "  - Processos desconhecidos podem indicar software indesejado."
echo "  - Uso alto de CPU/memória pode ser falha ou atividade anormal."
echo "  - Saber o dono do processo ajuda a investigar incidentes."
echo
echo "Laboratório 03 concluído."
echo "Leia também: labs/03-processes.md"
