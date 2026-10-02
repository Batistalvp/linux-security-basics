# Laboratório 01 — Usuários e grupos

## Objetivo

Entender o que são usuários e grupos no Linux, consultar a identidade da sessão atual e perceber por que o gerenciamento de contas é a base da segurança do sistema.

## Conceitos

- **Usuário**: identidade com a qual você entra no sistema. Cada usuário tem um nome e um número (`UID`).
- **Grupo**: conjunto de usuários que compartilham permissões. Cada grupo tem um nome e um número (`GID`).
- **Usuário root**: conta administrativa (`UID 0`). Tem poder total. No dia a dia, use uma conta comum e `sudo` só quando necessário.
- **Contas de serviço**: usuários que existem para programas (web, banco de dados), não para pessoas.
- **Menor privilégio**: cada pessoa recebe só o acesso de que precisa.

## Comandos utilizados

| Comando | Para que serve |
| --- | --- |
| `whoami` | Mostra o nome do usuário da sessão |
| `id` | Mostra UID, GID e grupos |
| `groups` | Lista os grupos do usuário |
| `who` | Lista quem está logado agora |
| `getent passwd` | Consulta contas conhecidas (somente leitura) |

## Prática

Prefira uma **máquina virtual Linux** (Ubuntu ou Debian) da qual você seja administrador.

1. Abra o terminal.
2. Vá até a pasta do projeto:

```bash
cd linux-security-basics
chmod +x scripts/users.sh
./scripts/users.sh
```

3. Repita os comandos manualmente para explicar cada um em voz alta:

```bash
whoami
id
groups
who
```

4. Abra o arquivo de política de exemplo criado em `~/linux-security-lab-01/` e relacione cada item com segurança.

**Não faça neste laboratório:** criar usuários reais, alterar senhas ou editar `/etc/passwd` / `/etc/shadow`.

Se o professor pedir criação de usuário em uma VM isolada, o administrador faria algo neste formato (não execute em máquina compartilhada sem autorização):

```bash
# Apenas em VM de estudo da qual você é dono
sudo adduser aluno-lab
sudo usermod -aG sudo aluno-lab   # só se realmente precisar de sudo
```

## O que observar

- Seu `UID` normalmente não é `0` (zero é root).
- Você pode pertencer a vários grupos ao mesmo tempo.
- `who` mostra sessões ativas: útil para saber se há mais alguém logado.
- `getent passwd` mistura pessoas e contas de serviço.

## O que aprendi

- O Linux identifica ações por usuário, não só por “a máquina”.
- Grupos evitam compartilhar a mesma conta.
- Contas individuais tornam a auditoria possível.

## Cuidados de segurança

- Nunca compartilhe senha da sua conta.
- Não use root como usuário diário.
- Não publique listagens de `/etc/passwd` com dados reais de produção.
- Só crie ou remova usuários em sistemas que você administra.
