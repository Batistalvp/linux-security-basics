# Conceitos fundamentais de segurança Linux

Este texto apoia os cinco laboratórios do projeto **linux-security-basics**. A linguagem é simples de propósito: o objetivo é você explicar cada ideia em uma entrevista de estágio.

## O que estamos protegendo?

Em um computador Linux existem, no mínimo:

- **Identidades** — usuários e grupos.
- **Dados** — arquivos e diretórios.
- **Programas em execução** — processos.
- **Rede** — portas e conexões.
- **Histórico** — logs.

Segurança da informação costuma ser resumida em **CIA**:

- **Confidencialidade**: só quem deve ler, lê.
- **Integridade**: os dados não são alterados sem autorização.
- **Disponibilidade**: o sistema continua utilizável para quem tem direito.

Os laboratórios deste projeto tocam os três, com ênfase em confidencialidade (permissões, firewall) e em rastreabilidade (usuários, logs).

## Defesa em camadas

Não existe um único controle mágico. Combina-se:

1. Conta pessoal, sem compartilhar senha.
2. Permissões justas nos arquivos.
3. Poucos serviços de rede expostos.
4. Observação de processos e logs.
5. Atualizações do sistema (fora do escopo prático deste repo, mas essencial).

Se uma camada falha, a seguinte ainda pode reduzir o dano. Isso se chama **defesa em profundidade**.

## Menor privilégio

Princípio: conceda só o acesso necessário, pelo tempo necessário.

Exemplos deste projeto:

- Usar conta comum e `sudo` pontual, não viver como root.
- Arquivo interno com `chmod go-rwx` (grupo e outros sem acesso).
- Firewall permitindo apenas a porta do serviço que você realmente usa.

## Usuários, grupos e responsabilidade

O Linux registra ações associadas a um **UID**. Se todo mundo usa a mesma conta, fica impossível responder “quem fez isso?”.

Grupos resolvem acesso compartilhado sem senha compartilhada: a pasta do time pertence a um grupo; as pessoas entram nesse grupo.

## Permissões como controle de acesso

`rwx` para dono, grupo e outros é o modelo clássico. Ele não é o único (existem ACL e MAC, como SELinux/AppArmor), mas é o que todo administrador júnior precisa ler em `ls -l`.

Erros comuns:

- `chmod 777`: qualquer um lê, grava e executa.
- Script gravável por outros: o conteúdo pode ser trocado nas suas costas.
- Diretório sem `x`: você não entra, mesmo com `r`.

## Processos e visibilidade

O que está em execução **é** o sistema naquele instante. Listar processos ajuda a:

- ver programas que você não iniciou;
- perceber pico de CPU;
- ligar um PID a um usuário.

Encerrar processo (`kill`) é ferramenta de administração, não de “ataque”. Neste curso o `kill` só aparece de forma consciente, em processo criado por você.

## Firewall e superfície de ataque

Cada porta em escuta é uma porta de entrada potencial. O firewall reduz essa superfície.

UFW é um começo em Ubuntu/Debian. O risco clássico do iniciante é ativar o firewall em uma sessão SSH sem permitir a porta 22. Por isso os scripts **não aplicam regras**.

Firewall não substitui:

- senha ou chave forte;
- sistema atualizado;
- serviço configurado com cuidado.

## Logs e detecção

Prevenção falha. Logs permitem **detectar** e **aprender** depois do fato.

Perguntas simples ao ler um log:

- Quando?
- Qual programa ou serviço?
- Qual usuário?
- Sucesso ou falha?
- Isso combina com o que eu estava fazendo na máquina?

Ferramentas deste projeto: `journalctl`, `tail`, `less`, `grep`. São suficientes para um primeiro emprego júnior em suporte ou operação.

## Ética e limite deste laboratório

Tudo aqui é para **sistemas seus** (VM, WSL seu, laboratório da faculdade com autorização).

Fora do escopo, de propósito:

- exploração de vulnerabilidades;
- quebra de senha;
- acesso não autorizado;
- evasão de antivírus ou de firewall de terceiros;
- coleta de credenciais.

Cybersegurança profissional começa com permissão, documentação e respeito à lei.

## Como falar isso em uma entrevista

Frase possível:

> “Eu montei um laboratório Linux em que consulto identidade (`id`, `whoami`), ajusto permissões só na minha pasta, observo processos com `ps`/`top`, leio o status do UFW sem aplicar regras perigosas e pratico leitura de logs com `journalctl` e `grep`. O foco foi menor privilégio, defesa em camadas e operação segura — não ofensiva.”

Se pedirem próximo passo, cite: SSH com chave, `sudo` bem configurado, atualizações, backup e um pouco de hardening (desativar serviços não usados).
