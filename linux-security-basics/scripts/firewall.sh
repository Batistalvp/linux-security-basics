#!/usr/bin/env bash
# =============================================================================
# firewall.sh — Laboratório 04: firewall (UFW)
# =============================================================================
# Este script é SOMENTE CONSULTA por padrão.
# Ele NÃO ativa o firewall e NÃO cria regras que possam te desconectar.
# Regras de exemplo são apenas IMPRESSAS na tela.
# =============================================================================

set -euo pipefail

echo "=============================================="
echo " Laboratório 04 — Firewall introdutório (UFW)"
echo "=============================================="
echo
echo "Firewall filtra tráfego de rede: o que entra e o que sai."
echo "UFW (Uncomplicated Firewall) é uma interface simples sobre o iptables/nftables."
echo
echo "ATENÇÃO: alterar firewall em uma máquina remota (SSH) pode te desconectar."
echo "Este script NÃO aplica regras. Apenas consulta e explica."
echo

if ! command -v ufw >/dev/null 2>&1; then
  echo "UFW não está instalado neste sistema."
  echo
  echo "O que fazer em um laboratório próprio (Debian/Ubuntu):"
  echo "  sudo apt update"
  echo "  sudo apt install ufw"
  echo
  echo "Mesmo sem UFW, o conceito permanece:"
  echo "  permitir só o necessário (menor privilégio de rede)."
  echo
  echo "Laboratório 04 encerrado (consulta: UFW indisponível)."
  exit 0
fi

echo "[1] Comando: sudo ufw status"
echo "    O que faz: mostra se o firewall está ativo e as regras atuais."
echo "    Pode pedir sua senha porque status completo costuma exigir sudo."
echo

if sudo -n ufw status >/dev/null 2>&1; then
  echo "    Resultado:"
  sudo ufw status
elif sudo -n true >/dev/null 2>&1; then
  echo "    Resultado:"
  sudo ufw status
else
  echo "    Não foi possível executar sudo sem senha neste ambiente."
  echo "    Execute manualmente no seu Linux: sudo ufw status"
  echo "    Alternativa sem sudo (pode mostrar menos detalhes):"
  ufw status || true
fi
echo

echo "[2] Comando útil: sudo ufw status verbose"
echo "    O que faz: mostra política padrão (entrada/saída) e mais detalhes."
echo "    NÃO executado automaticamente aqui."
echo

echo "[3] Exemplos de regras SIMPLES (NÃO aplicadas por este script)"
echo "    Explique cada uma antes de usar em uma VM de estudo:"
echo
echo "    sudo ufw allow 22/tcp"
echo "      Permite SSH (porta 22). Em acesso remoto, faça ISSO ANTES de ativar o UFW."
echo
echo "    sudo ufw allow 80/tcp"
echo "      Permite HTTP (porta 80), se você estiver estudando um servidor web."
echo
echo "    sudo ufw deny 23/tcp"
echo "      Nega Telnet (porta 23), protocolo antigo e inseguro."
echo
echo "    sudo ufw enable"
echo "      Ativa o firewall. NÃO execute em SSH sem ter permitido a porta 22."
echo
echo "    sudo ufw disable"
echo "      Desativa o UFW. Use só se você for o administrador da máquina de estudo."
echo

echo "Por que isso importa para segurança?"
echo "  - Reduz a superfície de ataque: serviços não usados ficam inacessíveis."
echo "  - Complementa senhas fortes e atualizações: defesa em camadas."
echo "  - Regras devem ser conscientes; uma regra errada pode cortar seu acesso."
echo
echo "Laboratório 04 concluído."
echo "Leia também: labs/04-firewall.md"
