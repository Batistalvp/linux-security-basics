# Laboratório 02 — Permissões de arquivos

## Objetivo

Ler a saída de `ls -l`, entender dono, grupo e o trio leitura/escrita/execução, e alterar permissões **somente** em arquivos criados na sua pasta home.

## Conceitos

Permissões no Linux clássico (DAC — controle de acesso discricionário):

| Letra | Nome | Em arquivo | Em diretório |
| --- | --- | --- | --- |
| `r` | read | Ler conteúdo | Listar nomes |
| `w` | write | Alterar conteúdo | Criar/apagar itens |
| `x` | execute | Executar como programa | Entrar no diretório (`cd`) |

Três campos:

1. **Dono (user)** — dono do arquivo.
2. **Grupo (group)** — grupo associado.
3. **Outros (others)** — restante dos usuários.

Exemplo: `-rw-r-----`

- arquivo comum (`-`)
- dono: lê e escreve
- grupo: só lê
- outros: nada

`chmod` altera permissões. `chown` altera dono e grupo (muitas vezes precisa de privilégio administrativo).

## Comandos utilizados

| Comando | Para que serve |
| --- | --- |
| `ls -l` | Lista permissões, dono e grupo |
| `chmod` | Altera permissões |
| `id` | Confere seu usuário e grupo |
| `chown` | Altera dono/grupo (explicado, não automático) |

## Prática

```bash
cd linux-security-basics
chmod +x scripts/permissions.sh
./scripts/permissions.sh
```

Depois, no diretório `~/linux-security-lab-02`, experimente:

```bash
ls -l
chmod u+x tarefa.sh
ls -l tarefa.sh
chmod go-rwx relatorio.txt
ls -l relatorio.txt
```

Formas comuns de `chmod`:

```bash
chmod u+x arquivo.sh     # dono ganha execução
chmod go-w arquivo.txt   # grupo e outros perdem escrita
chmod 600 arquivo.txt    # dono rw, demais sem acesso (rw-------)
```

`600` é um padrão razoável para arquivo pessoal sensível **de laboratório**. Não use isso em arquivos do sistema sem entender o impacto.

Sobre `chown` (exemplo, só em VM sua):

```bash
# Mostra a ideia. Só execute se você for admin da VM e o arquivo for seu.
chown "$(whoami):$(id -gn)" relatorio.txt
```

## O que observar

- Depois de `chmod u+x`, a coluna do dono passa a ter `x`.
- Depois de `chmod go-rwx`, grupo e outros ficam `---`.
- Um script sem `x` não executa com `./arquivo.sh`.
- Diretórios precisam de `x` para você conseguir `cd` neles.

## O que aprendi

- Permissões são a primeira linha de defesa para dados no disco.
- “Todo mundo pode ler” (`o+r`) só deve ser usado quando o conteúdo realmente for público.
- Dono, grupo e outros são três perguntas diferentes: quem é o dono, quem está no grupo, e o resto.

## Cuidados de segurança

- Não rode `chmod -R 777` em lugar nenhum. Isso libera leitura, escrita e execução para todos.
- Não altere permissões de `/etc`, `/usr` ou `/var` neste laboratório.
- Não coloque senhas em arquivos de exemplo.
- Scripts com permissão de escrita para “outros” são um risco (alguém poderia alterar o conteúdo).
