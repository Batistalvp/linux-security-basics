#!/usr/bin/env bash
# =============================================================================
# logs.sh — Laboratório 05: logs do sistema
# =============================================================================
# Este script lê logs de forma limitada e segura.
# Não altera arquivos de log e não extrai senhas.
# =============================================================================

set -euo pipefail

echo "=============================================="
echo " Laboratório 05 — Logs no Linux"
echo "=============================================="
echo
echo "Logs são registros de eventos: login, serviços, erros e avisos."
echo "Eles ajudam a entender o que aconteceu e a detectar atividade estranha."
echo "Este script só lê trechos pequenos. Nenhum log será apagado."
echo

echo "[1] Onde os logs costumam estar"
echo "    /var/log/          — arquivos clássicos de log"
echo "    journalctl         — diário do systemd (muitas distros modernas)"
echo

echo "[2] Comando: ls /var/log | head -n 20"
echo "    O que faz: lista nomes de arquivos de log (sem abrir o conteúdo)."
if [ -d /var/log ]; then
  ls /var/log | head -n 20
else
  echo "    Diretório /var/log não encontrado neste ambiente."
fi
echo

echo "[3] journalctl — registros recentes do sistema"
if command -v journalctl >/dev/null 2>&1; then
  echo "    Comando: journalctl -n 8 --no-pager"
  echo "    O que faz: mostra as 8 entradas mais recentes, sem abrir pager."
  echo "    Em alguns sistemas isso exige permissão extra."
  if journalctl -n 8 --no-pager >/dev/null 2>&1; then
    journalctl -n 8 --no-pager
  else
    echo "    Sem permissão para ler o journal completo. Tentando --user:"
    journalctl --user -n 8 --no-pager || echo "    Journal do usuário também indisponível."
  fi
else
  echo "    journalctl não está disponível (sistema sem systemd, ou não instalado)."
fi
echo

echo "[4] tail — ver o final de um arquivo"
AUTH_CANDIDATES=("/var/log/auth.log" "/var/log/secure")
FOUND_AUTH=""
for f in "${AUTH_CANDIDATES[@]}"; do
  if [ -r "$f" ]; then
    FOUND_AUTH="$f"
    break
  fi
done

if [ -n "${FOUND_AUTH}" ]; then
  echo "    Arquivo legível encontrado: ${FOUND_AUTH}"
  echo "    Comando: tail -n 5 ${FOUND_AUTH}"
  echo "    O que faz: mostra as 5 últimas linhas (eventos mais recentes)."
  tail -n 5 "${FOUND_AUTH}"
else
  echo "    auth.log/secure não estão legíveis com seu usuário atual."
  echo "    Isso é esperado: logs de autenticação costumam ser restritos."
  echo "    Em uma VM de estudo, o administrador pode usar: sudo tail -n 20 /var/log/auth.log"
fi
echo

echo "[5] grep — procurar um padrão (exemplo defensivo)"
echo "    grep filtra linhas. Exemplo educacional (NÃO é um ataque):"
echo "    procurar a palavra 'Failed' ou 'error' em logs que você PODE ler."
echo

if [ -n "${FOUND_AUTH}" ]; then
  echo "    Comando: grep -i -E 'failed|error|invalid' ${FOUND_AUTH} | tail -n 5"
  grep -i -E 'failed|error|invalid' "${FOUND_AUTH}" | tail -n 5 || echo "    Nenhuma linha correspondente nas amostras."
else
  if command -v journalctl >/dev/null 2>&1; then
    echo "    Alternativa: journalctl -n 200 --no-pager | grep -i -E 'error|fail' | tail -n 5"
    if journalctl -n 200 --no-pager >/dev/null 2>&1; then
      journalctl -n 200 --no-pager | grep -i -E 'error|fail' | tail -n 5 || echo "    Nenhuma linha correspondente."
    else
      echo "    Sem permissão para essa consulta. Tente na sua VM com sudo, se for o administrador."
    fi
  fi
fi
echo

echo "[6] less — leitura página a página"
echo "    less abre um arquivo para você rolar com as setas."
echo "    Sair: tecla q. Este script não abre o less (é interativo)."
echo "    Exemplo: less /var/log/syslog"
echo

echo "Como logs ajudam a identificar atividade suspeita?"
echo "  - Muitas falhas de login em pouco tempo."
echo "  - Serviços caindo e subindo sem motivo conhecido."
echo "  - Comandos administrativos em horários incomuns."
echo "  Lembrete: um evento isolado não prova um ataque. Contexto importa."
echo
echo "Laboratório 05 concluído."
echo "Leia também: labs/05-logs.md"
