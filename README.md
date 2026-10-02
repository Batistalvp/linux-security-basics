# linux-security-basics

Laboratório introdutório de **segurança Linux** para estudantes de Análise e Desenvolvimento de Sistemas (ADS) que estão começando em Cybersegurança.

O material é **educacional e defensivo**: você observa o sistema, pratica comandos com segurança e aprende o vocabulário que aparece em estágios de suporte, infraestrutura e segurança.

## Descrição

Este repositório reúne cinco mini-laboratórios (usuários, permissões, processos, firewall e logs) com roteiros em Markdown e scripts Bash que **explicam o que vão fazer** antes de consultar o sistema.

Os scripts não destroem dados, não gravam senhas e não alteram configurações críticas automaticamente. O laboratório de firewall **não aplica regras** que possam cortar seu acesso remoto.

## Objetivos

Ao terminar, você deve conseguir:

- explicar usuários, grupos, UID e GID;
- ler `ls -l` e alterar permissões só em arquivos seus;
- listar processos e identificar PID, dono e comando;
- descrever o papel de um firewall e consultar o UFW;
- localizar e ler logs com `journalctl`, `tail`, `less` e `grep`;
- relacionar cada tópico a menor privilégio e defesa em camadas.

## 🎯 O que este projeto demonstra

Este projeto demonstra conhecimentos **básicos e práticos** de:

- **Linux** — navegação, identidade, arquivos e operação no terminal;
- **Bash** — scripts simples, comentários, checagem de erro e mensagens claras;
- **Permissões** — modelo `rwx`, dono, grupo e outros;
- **Processos** — `ps`, `top`/`htop` e o conceito de `kill` sem uso imprudente;
- **Firewall** — ideia de filtragem de tráfego e consulta ao UFW;
- **Análise de logs** — leitura dirigida para entender eventos e sinais de atividade incomum.

É um portfólio adequado para entrevista de **estágio**: cada arquivo pode ser aberto e explicado linha a linha.

## Tecnologias utilizadas

- Linux (Ubuntu/Debian recomendados; outras distros também servem com pequenos ajustes)
- Bash (`bash`)
- Comandos GNU coreutils (`ls`, `chmod`, `ps`, `grep`, `tail`, …)
- UFW (quando instalado)
- systemd / `journalctl` (quando disponível)
- Git / GitHub para versionar o laboratório

## Pré-requisitos

- Uma máquina Linux **sua** (VM, dual boot ou WSL2). Evite treinar `sudo` em computador de outra pessoa.
- Terminal com Bash.
- Permissão para executar scripts (`chmod +x`).
- Para firewall e alguns logs: privilégio administrativo **na sua VM**, usado com consciência.
- Git, se for publicar no GitHub.

Não é necessário saber programar além do básico. É necessário ler as mensagens que os scripts imprimem.

## Estrutura do projeto

```text
linux-security-basics/
├── README.md
├── .gitignore
├── scripts/
│   ├── users.sh
│   ├── permissions.sh
│   ├── processes.sh
│   ├── firewall.sh
│   └── logs.sh
├── labs/
│   ├── 01-users-and-groups.md
│   ├── 02-file-permissions.md
│   ├── 03-processes.md
│   ├── 04-firewall.md
│   └── 05-logs.md
└── docs/
    └── security-concepts.md
```

| Caminho | Função |
| --- | --- |
| `labs/` | Roteiro passo a passo de cada prática |
| `scripts/` | Demonstração automatizada e comentada |
| `docs/security-concepts.md` | Teoria curta, em linguagem de entrevista |
| `.gitignore` | Evita versionar logs, chaves e lixo local |

## Como executar

No Linux, dentro da pasta do projeto:

```bash
cd linux-security-basics
chmod +x scripts/*.sh
```

Execute **um laboratório por vez**, na ordem:

```bash
./scripts/users.sh
./scripts/permissions.sh
./scripts/processes.sh
./scripts/firewall.sh
./scripts/logs.sh
```

Leia o arquivo correspondente em `labs/` **antes ou junto** do script. Os scripts de permissões criam arquivos só em `~/linux-security-lab-02`. O de usuários cria um texto de exemplo em `~/linux-security-lab-01`.

Se você estiver no Windows só para editar o repositório, rode os scripts em uma VM Linux ou no WSL.

## Descrição de cada laboratório

### 01 — Usuários e grupos

Identidade no Linux: `whoami`, `id`, `who`, `groups`. Por que contas individuais importam para auditoria e menor privilégio.

### 02 — Permissões de arquivos

Leitura, escrita, execução, dono e grupo. `ls -l` e `chmod` em pasta pessoal. `chown` explicado, sem troca automática de dono.

### 03 — Processos

O que é PID, como listar com `ps`, como olhar `top`/`htop`, e por que monitorar processos é parte da segurança operacional. `kill` só aparece como conceito e prática opcional em processo criado por você.

### 04 — Firewall

O que um firewall faz. Consulta ao UFW. Regras de exemplo **impressas**, não aplicadas. Avisos claros sobre SSH e risco de desconexão.

### 05 — Logs

O que são logs, `/var/log`, `journalctl`, `tail`, `less`, `grep`. Como eventos ajudam a notar falhas de login ou erros de serviço — sem invadir nada.

## Exemplos de comandos

```bash
whoami
id
ls -l
chmod u+x scripts/users.sh
ps aux | head
sudo ufw status
journalctl -n 20 --no-pager
tail -n 20 /var/log/syslog
grep -i error /var/log/syslog | tail
```

Cada comando existe para **observar** ou para alterar apenas arquivos do laboratório.

## Conceitos aprendidos

**Linux / administração**

- Usuários, grupos, UID/GID
- Permissões `rwx` e listagem longa
- Processos, PID, sinais
- Localização de logs e o journal do systemd

**Cybersegurança (fundamentos)**

- Menor privilégio
- Defesa em camadas
- Superfície de ataque (portas)
- Rastreabilidade (quem fez o quê)
- Detecção básica via logs
- Ética: só sistemas autorizados

## Cuidados de segurança

- Use uma VM com snapshot.
- Não grave senhas, chaves SSH privadas, tokens ou `.env` neste repositório (o `.gitignore` ajuda, mas a responsabilidade é sua).
- Não rode `chmod 777`, não apague logs e não ative UFW em SSH sem permitir a porta de acesso.
- Não utilize estes materiais contra sistemas de terceiros.
- Trate logs reais como dados sensíveis.

## Publicação no GitHub

```bash
git init
git add README.md .gitignore scripts labs docs
git status
git commit -m "Add introductory Linux security lab for beginners."
```

Crie o repositório vazio no GitHub e envie o branch:

```bash
git remote add origin https://github.com/SEU_USUARIO/linux-security-basics.git
git branch -M main
git push -u origin main
```

Revise `git status` antes do commit: nenhum arquivo de chave ou senha deve aparecer.

## Próximos passos

Quando estes cinco labs estiverem claros, um nível intermediário poderia incluir:

- SSH com chave pública (sem senha no Git);
- arquivo `/etc/sudoers` com `visudo` (conceitos, em VM);
- atualizações (`apt`) e serviços (`systemctl status`);
- AppArmor ou SELinux em modo didático;
- backup e restauração;
- um mini playbook de resposta: “vi um processo estranho → conferi logs → registrei o horário”.

Nada disso precisa ser ofensivo. Operação segura já é segurança.

## Licença de uso educacional

Use para estudo, aulas e portfólio. Não use para acesso não autorizado.
