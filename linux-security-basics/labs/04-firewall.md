# Laboratório 04 — Firewall (UFW)

## Objetivo

Entender o papel de um firewall no Linux, consultar o status do UFW quando existir, e conhecer regras simples **sem aplicá-las automaticamente**.

## Conceitos

- **Firewall**: filtro de tráfego de rede. Decide o que pode entrar ou sair, com base em regras (porta, protocolo, origem).
- **UFW**: Uncomplicated Firewall — ferramenta amigável em Ubuntu/Debian.
- **Política padrão**: o que acontece quando nenhuma regra específica combina (por exemplo, negar entrada e permitir saída).
- **Superfície de ataque**: cada porta aberta é um possível caminho. Abra só o necessário.
- **Acesso remoto**: se você está em SSH (porta 22), ativar o firewall **sem** permitir 22 pode te trancar para fora.

Este laboratório é **defensivo**. Não ensina a contornar firewall de terceiros.

## Comandos utilizados

| Comando | Para que serve |
| --- | --- |
| `sudo ufw status` | Mostra se o UFW está ativo e as regras |
| `sudo ufw status verbose` | Mostra políticas padrão e mais detalhes |
| `sudo ufw allow 22/tcp` | Exemplo: permitir SSH (não aplicado pelo script) |
| `sudo ufw enable` / `disable` | Liga/desliga o UFW (não aplicado pelo script) |

## Prática

```bash
cd linux-security-basics
chmod +x scripts/firewall.sh
./scripts/firewall.sh
```

O script **consulta** e **explica**. Ele não ativa o firewall.

Na sua VM, se o UFW estiver instalado, consulte:

```bash
sudo ufw status
sudo ufw status verbose
```

Se não estiver instalado (Ubuntu/Debian, VM sua):

```bash
sudo apt update
sudo apt install ufw
```

### Ordem segura em uma VM com SSH

Leia cada linha antes de pensar em executar. Só faça isso se você for o administrador da VM e souber como acessá-la pelo console (não só por SSH):

```bash
sudo ufw allow 22/tcp    # primeiro: não se trancar
sudo ufw status          # conferir a regra
# sudo ufw enable        # só depois de conferir, e com acesso ao console
```

Exemplos didáticos de outras regras (ainda assim, pense antes):

```bash
sudo ufw allow 80/tcp    # HTTP, se houver servidor web de estudo
sudo ufw deny 23/tcp     # Telnet, protocolo antigo
```

Para ver o que **seria** feito, o script imprime esses exemplos sem aplicá-los.

## O que observar

- `Status: inactive` significa que o UFW não está filtrando no momento.
- `Status: active` lista regras `ALLOW` / `DENY`.
- Número da porta + protocolo (`22/tcp`) é mais claro que só o nome do serviço, no começo.
- Sem `sudo`, muita informação de firewall simplesmente não aparece.

## O que aprendi

- Firewall reduz exposição, mas não substitui atualizações nem senhas boas.
- Regras devem ser explícitas e revisadas.
- Em acesso remoto, a ordem das regras importa tanto quanto as regras em si.

## Cuidados de segurança

- Não execute `ufw enable` em servidor remoto sem permitir SSH (ou a porta que você usa).
- Não copie regras de internet sem entender porta e protocolo.
- Não use este laboratório para “fechar” a rede de outra pessoa ou de um laboratório compartilhado sem autorização.
- Prefira sempre uma VM snapshot: se algo der errado, você restaura o ponto anterior.
