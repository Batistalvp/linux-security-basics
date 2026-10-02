#!/usr/bin/env bash
# =============================================================================
# users.sh — Laboratório 01: usuários e grupos
# =============================================================================
# Este script é educacional e defensivo.
# Ele APENAS consulta informações do sistema e cria arquivos de exemplo
# na pasta do usuário. Não cria, altera nem remove contas reais.
# =============================================================================

set -euo pipefail

echo "=============================================="
echo " Laboratório 01 — Usuários e grupos no Linux"
echo "=============================================="
echo
echo "Este script mostra quem você é no sistema e em quais grupos está."
echo "Nenhuma conta será criada ou alterada."
echo

# -----------------------------------------------------------------------------
# whoami: mostra o nome do usuário da sessão atual
# -----------------------------------------------------------------------------
echo "[1] Comando: whoami"
echo "    O que faz: imprime o nome do usuário autenticado nesta sessão."
echo "    Resultado:"
whoami
echo

# -----------------------------------------------------------------------------
# id: mostra UID, GID e grupos do usuário atual
# -----------------------------------------------------------------------------
echo "[2] Comando: id"
echo "    O que faz: mostra o identificador numérico (UID), o grupo"
echo "    principal (GID) e os demais grupos do usuário."
echo "    Resultado:"
id
echo

# -----------------------------------------------------------------------------
# groups: lista os grupos do usuário atual
# -----------------------------------------------------------------------------
echo "[3] Comando: groups"
echo "    O que faz: lista os grupos aos quais você pertence."
echo "    Resultado:"
groups
echo

# -----------------------------------------------------------------------------
# who: mostra quem está logado agora
# -----------------------------------------------------------------------------
echo "[4] Comando: who"
echo "    O que faz: lista sessões ativas (usuário, terminal e horário)."
echo "    Resultado:"
who
echo

# -----------------------------------------------------------------------------
# getent passwd: consulta o banco de contas (somente leitura)
# Limitamos a 8 linhas para não poluir a tela.
# -----------------------------------------------------------------------------
echo "[5] Comando: getent passwd | head -n 8"
echo "    O que faz: consulta contas conhecidas pelo sistema (somente leitura)."
echo "    Observação: contas de serviço também aparecem; isso é normal."
echo "    Resultado (primeiras linhas):"
if command -v getent >/dev/null 2>&1; then
  getent passwd | head -n 8
else
  echo "    Aviso: getent não está disponível. Mostrando /etc/passwd (somente leitura)."
  head -n 8 /etc/passwd
fi
echo

# -----------------------------------------------------------------------------
# Exemplo seguro: arquivo de "política" fictícia no diretório do usuário
# -----------------------------------------------------------------------------
WORKDIR="${HOME}/linux-security-lab-01"
mkdir -p "${WORKDIR}"

POLICY_FILE="${WORKDIR}/politica-usuarios-exemplo.txt"

cat > "${POLICY_FILE}" << 'EOF'
Política de exemplo (laboratório educacional)
---------------------------------------------
1. Cada pessoa deve ter sua própria conta.
2. Ninguém deve usar a conta root no dia a dia.
3. Use sudo apenas quando precisar de privilégio administrativo.
4. Remova contas que não são mais necessárias.
5. Prefira grupos para conceder acesso compartilhado, não senhas compartilhadas.
EOF

echo "[6] Arquivo de exemplo criado em: ${POLICY_FILE}"
echo "    Este arquivo NÃO altera o sistema. Serve só para estudo."
echo
echo "Por que isso importa para segurança?"
echo "  - Identidade: saber QUEM fez cada ação."
echo "  - Menor privilégio: cada pessoa recebe só o acesso necessário."
echo "  - Auditoria: contas individuais permitem rastrear eventos nos logs."
echo
echo "Laboratório 01 concluído."
echo "Leia também: labs/01-users-and-groups.md"
