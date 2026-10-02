# Laboratório 03 — Processos

## Objetivo

Entender o que é um processo, listar programas em execução, identificar PID, usuário e comando, e saber **quando** (e quando não) usar `kill`.

## Conceitos

- **Processo**: um programa que está rodando. Tem um **PID** (Process ID).
- **PID**: número único enquanto aquele processo existir.
- **Dono do processo**: em geral o usuário que o iniciou.
- **Sinal**: recado enviado ao processo. `SIGTERM` (15) pede encerramento; `SIGKILL` (9) força o fim e deve ser último recurso.
- **Monitoramento**: observar CPU, memória e comandos estranhos faz parte da operação segura.

Este laboratório **não** ensina a derrubar serviços de produção nem a esconder processos.

## Comandos utilizados

| Comando | Para que serve |
| --- | --- |
| `ps` | Lista processos da sessão |
| `ps aux` | Visão ampla do sistema |
| `pgrep` | Busca processo pelo nome |
| `top` | Visão ao vivo (sair com `q`) |
| `htop` | Alternativa mais visual, se instalada |
| `kill` | Envia sinal (não usado pelo script) |

## Prática

```bash
cd linux-security-basics
chmod +x scripts/processes.sh
./scripts/processes.sh
```

Em seguida, no terminal:

```bash
ps
ps aux | head
ps -u "$(whoami)"
```

Abra o monitor interativo:

```bash
top
```

Pressione `q` para sair. Se `htop` existir:

```bash
htop
```

Para localizar um processo **seu** pelo nome:

```bash
pgrep -a bash
```

Sobre `kill` — só em processo que **você** criou na VM de estudo:

1. Abra outro terminal e rode `sleep 300`.
2. No primeiro terminal, descubra o PID: `pgrep -a sleep`.
3. Encerre com: `kill PID` (troque PID pelo número).
4. Confirme que o `sleep` terminou.

Não envie `kill` para processos que você não reconhece (`systemd`, `sshd`, desktop, etc.).

## O que observar

- Cada linha de `ps aux` tem USER, PID, %CPU, %MEM e COMMAND.
- Você verá vários processos do sistema além dos seus.
- `top` atualiza sozinho: útil para picos de CPU.
- O PID muda se o programa for iniciado de novo.

## O que aprendi

- Administrar Linux inclui saber o que está rodando agora.
- Identificar o dono de um processo ajuda em uma investigação.
- Encerrar processo é ação administrativa: precisa de contexto.

## Cuidados de segurança

- `kill -9` não dá chance de o programa salvar estado. Evite no começo.
- Uso alto de recurso **pode** ser normal (atualização, compilação) ou anormal. Investigue antes de concluir.
- Este laboratório não cobre malware. Se algo parecer estranho em uma máquina real, preserve evidências (logs, lista de processos) e peça ajuda de quem administra o sistema.
