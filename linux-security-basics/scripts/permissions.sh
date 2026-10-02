#!/usr/bin/env bash
# =============================================================================
# permissions.sh — Laboratório 02: permissões de arquivos
# =============================================================================
# Este script cria arquivos SOMENTE no diretório do usuário (~/linux-security-lab-02).
# Não altera /etc, /usr, /var nem arquivos de outros usuários.
# =============================================================================

set -euo pipefail

WORKDIR="${HOME}/linux-security-lab-02"

echo "=============================================="
echo " Laboratório 02 — Permissões de arquivos"
echo "=============================================="
echo
echo "Vamos criar arquivos de exemplo em: ${WORKDIR}"
echo "Nenhum arquivo do sistema será modificado."
echo

mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Arquivos de demonstração (conteúdo fictício, sem segredos reais)
echo "relatório interno de exemplo" > relatorio.txt
echo "rascunho público de exemplo" > rascunho.txt
echo "echo 'script de exemplo'" > tarefa.sh

echo "[1] Comando: ls -l"
echo "    O que faz: lista arquivos com dono, grupo e permissões (rwx)."
echo "    Resultado:"
ls -l
echo

echo "[2] Entendendo a coluna de permissões"
echo "    Exemplo: -rw-r--r--"
echo "      -          tipo: arquivo comum (-), diretório (d)"
echo "      rw-        dono: leitura e escrita"
echo "      r--        grupo: somente leitura"
echo "      r--        outros: somente leitura"
echo

echo "[3] Comando: chmod u+x tarefa.sh"
echo "    O que faz: adiciona permissão de execução para o dono do arquivo."
echo "    Antes:"
ls -l tarefa.sh
chmod u+x tarefa.sh
echo "    Depois:"
ls -l tarefa.sh
echo

echo "[4] Comando: chmod go-rwx relatorio.txt"
echo "    O que faz: remove leitura, escrita e execução do grupo e de outros."
echo "    Isso simula um arquivo mais restrito (menor privilégio)."
chmod go-rwx relatorio.txt
ls -l relatorio.txt
echo

echo "[5] Comando: chmod a+r rascunho.txt"
echo "    O que faz: garante leitura para todos (dono, grupo e outros)."
echo "    Útil para um arquivo que deve ser público DENTRO deste laboratório."
chmod a+r rascunho.txt
ls -l rascunho.txt
echo

echo "[6] Comando: id"
echo "    O que faz: mostra seu usuário e grupo — úteis para entender chown."
id
echo
echo "    Observação sobre chown:"
echo "    chown troca o dono/grupo de um arquivo. Em muitos sistemas isso"
echo "    exige privilégio administrativo. Neste laboratório NÃO executamos"
echo "    chown automaticamente para não alterar propriedade sem necessidade."
echo "    Exemplo (NÃO executado): chown \"$(whoami):$(id -gn)\" relatorio.txt"
echo

echo "Por que isso importa para segurança?"
echo "  - Arquivos sensíveis não devem ser lidos por qualquer usuário."
echo "  - Scripts executáveis demais aumentam o risco de uso indevido."
echo "  - O princípio do menor privilégio também vale para arquivos."
echo
echo "Laboratório 02 concluído."
echo "Leia também: labs/02-file-permissions.md"
