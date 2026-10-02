# Laboratório 05 — Logs

## Objetivo

Saber o que são logs, onde encontrá-los no Linux, ler trechos com `journalctl`, `tail`, `less` e `grep`, e relacionar eventos com investigação defensiva.

## Conceitos

- **Log**: registro de evento com data, origem e mensagem.
- **Syslog / journal**: mecanismos comuns de registro. Distros com systemd usam `journalctl`.
- **`/var/log`**: pasta clássica (`auth.log` ou `secure` para autenticação, `syslog` ou `messages` para o sistema).
- **Auditoria**: reconstruir “quem fez o quê, quando”.
- **Indicador**, não sentença: várias falhas de login **podem** ser senha errada ou varredura. Sempre falta contexto.

Este laboratório ensina **leitura**. Não ensina apagar logs, forjar eventos nem invadir contas.

## Comandos utilizados

| Comando | Para que serve |
| --- | --- |
| `ls /var/log` | Ver nomes dos arquivos de log |
| `journalctl` | Ler o diário do systemd |
| `tail` | Ver as últimas linhas |
| `less` | Ler com rolagem (sair com `q`) |
| `grep` | Filtrar linhas por texto |

## Prática

```bash
cd linux-security-basics
chmod +x scripts/logs.sh
./scripts/logs.sh
```

Consultas manuais comuns:

```bash
ls /var/log | head
journalctl -n 20 --no-pager
```

Se `auth.log` for legível (ou com `sudo` na **sua** VM):

```bash
sudo tail -n 20 /var/log/auth.log
```

Filtro defensivo de exemplo (falhas de autenticação — leitura, não ataque):

```bash
sudo grep -i -E "failed|invalid|failure" /var/log/auth.log | tail
```

Leitura página a página:

```bash
sudo less /var/log/syslog
```

No `less`: setas para rolar, `/` para buscar texto, `q` para sair.

Em sistemas Red Hat/Fedora o arquivo de autenticação pode ser `/var/log/secure` em vez de `auth.log`.

## O que observar

- Muitos logs exigem privilégio: isso protege a privacidade e a integridade dos registros.
- `journalctl -n` limita quantidade — comece pequeno.
- `grep` diferencia maiúsculas com `-i` (ignore case).
- Ausência de permissão é um resultado válido do laboratório, não um erro seu.

## O que aprendi

- Operação segura deixa rastro. Sem log, a investigação fica no escuro.
- Ferramentas simples (`tail` + `grep`) já ajudam um iniciante.
- Correlacionar horário do log com um processo (`ps`) ou um login (`who`) é o início de uma análise.

## Cuidados de segurança

- Não copie logs reais de empresa para o GitHub.
- Não tente “limpar” logs para esconder atividade — isso é antiético e, em muitos contextos, ilegal.
- Não use `grep` para vasculhar arquivos pessoais de outros usuários.
- Trate logs como dados sensíveis: podem conter nomes de contas, IPs e caminhos.
