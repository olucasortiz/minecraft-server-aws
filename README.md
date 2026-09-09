# Minecraft Server Infrastructure on AWS

Projeto de Cloud/DevOps criado a partir de uma necessidade real: hospedar e administrar um servidor Minecraft privado utilizando infraestrutura em nuvem, aplicando conceitos de Linux, redes, segurança e automação na AWS.

## Contexto

Meu irmão queria jogar Minecraft com amigos, mas não tinha familiaridade com hospedagem de servidores, configuração de rede ou administração de infraestrutura.

Vi nisso uma oportunidade de transformar uma necessidade real em um projeto prático.

Durante a faculdade, na disciplina de **Tópicos Computacionais**, tive contato com conceitos de computação em nuvem utilizando a **Oracle Cloud**. Decidi aplicar esses conhecimentos em um ambiente diferente, utilizando a **AWS** e assumindo a configuração e operação do servidor.

Em vez de contratar uma hospedagem de Minecraft pronta, configurei uma instância **Amazon EC2 com Ubuntu** para executar e administrar o servidor diretamente.

O que começou como uma forma de facilitar o acesso ao jogo se tornou um laboratório prático de **Cloud/DevOps**.

## Objetivo

Construir e operar um servidor Minecraft Java persistente na AWS, aplicando na prática conceitos de:

- infraestrutura em nuvem;
- administração Linux;
- acesso remoto via SSH;
- redes e controle de acesso;
- gerenciamento de serviços com systemd;
- execução da aplicação com usuário dedicado;
- automação de backups;
- troubleshooting e análise de logs.

## Arquitetura

~~~~mermaid
flowchart LR
    Player[Jogadores] -->|TCP 25565| SG[Security Group]
    SG --> EC2[Amazon EC2 / Ubuntu]

    Admin[Administrador] -->|SSH 22| SG
    SG --> EC2

    EC2 --> Systemd[systemd]
    Systemd --> Paper[Java + PaperMC]
    Paper --> World[Dados do servidor]

    Timer[systemd timer] --> Backup[backup.sh]
    Backup --> Archive[Backups tar.gz]
~~~~

> As configurações sensíveis da infraestrutura não são expostas neste repositório. A documentação pública utiliza apenas informações sanitizadas.

## Configuração

| Item | Configuração |
|---|---|
| Sistema | Ubuntu 26.04 |
| Java | OpenJDK 25 |
| Minecraft | 26.2 |
| Servidor | PaperMC 26.2 build 121 |
| Porta | TCP 25565 |
| Memória JVM | 2–6 GiB |
| Gamemode | Survival |
| Dificuldade | Normal |
| Autenticação | Online mode |
| Controle de acesso | Whitelist |
| RCON | Desabilitado |
| Query | Desabilitado |

## Tecnologias utilizadas

- Amazon EC2
- Ubuntu Linux
- SSH
- Java / OpenJDK
- PaperMC
- systemd
- Bash
- `tar`

## Implementação

O servidor é executado como um serviço Linux através do `minecraft.service`, utilizando o usuário dedicado `minecraft` em vez de executar a aplicação como root.

A JVM foi configurada com:

~~~~text
-Xms2G -Xmx6G
~~~~

O serviço permanece disponível através da porta TCP `25565` e é gerenciado pelo **systemd**, permitindo inicialização automática, reinício em caso de falha e consulta centralizada de logs.

Além do serviço principal, um **systemd timer** executa diariamente a rotina automatizada de backup.

Consulte [AUDIT.md](AUDIT.md) para a auditoria técnica do ambiente e [docs/operations.md](docs/operations.md) para os procedimentos operacionais.

## Segurança

Algumas decisões adotadas para reduzir a superfície de exposição e limitar privilégios:

- aplicação executada por usuário Linux dedicado;
- `NoNewPrivileges=true`;
- `PrivateTmp=true`;
- `UMask=0027`;
- autenticação oficial do Minecraft através de `online-mode`;
- whitelist habilitada;
- RCON desabilitado;
- Query desabilitado;
- administração remota via SSH;
- ausência de credenciais, IPs, chaves privadas e dados de jogadores no repositório.

A chave SSH utilizada para administrar a instância não faz parte deste projeto e nunca deve ser versionada.

Mais detalhes estão disponíveis em [docs/security.md](docs/security.md).

## Backup automatizado

Os backups são executados diariamente através de:

~~~~text
minecraft-backup.timer
        ↓
minecraft-backup.service
        ↓
backup.sh
        ↓
arquivo .tar.gz
~~~~

A rotina:

1. identifica o estado atual do servidor;
2. realiza uma parada controlada quando necessário;
3. cria o arquivo compactado;
4. mantém os sete backups mais recentes;
5. inicia novamente o servidor caso ele estivesse ativo.

Essa abordagem evita simplesmente copiar os arquivos do mundo enquanto a aplicação está realizando escritas.

## Operação

O servidor pode ser administrado utilizando ferramentas nativas do Linux:

~~~~bash
sudo systemctl status minecraft
sudo systemctl start minecraft
sudo systemctl stop minecraft
sudo systemctl restart minecraft
sudo journalctl -u minecraft -f
~~~~

Procedimentos adicionais estão documentados em [docs/operations.md](docs/operations.md).

## Troubleshooting

Durante a configuração e operação, o projeto também envolveu diagnóstico de problemas relacionados a:

- conexão SSH;
- permissões da chave privada;
- gerenciamento do serviço systemd;
- processos e portas;
- compatibilidade entre cliente e servidor;
- whitelist;
- logs da aplicação.

O guia operacional está disponível em [docs/troubleshooting.md](docs/troubleshooting.md).

## O que aprendi

O projeto permitiu levar conceitos de computação em nuvem vistos academicamente para um cenário real e em uma plataforma diferente.

Na prática, trabalhei com:

- criação e administração de uma máquina Linux na nuvem;
- conexão e autenticação por SSH;
- conceitos de IP, portas e regras de acesso;
- gerenciamento de processos e serviços Linux;
- princípio de menor privilégio;
- configuração e operação de uma aplicação Java persistente;
- automação com Bash e systemd;
- estratégia de backup e retenção;
- análise de logs e troubleshooting;
- documentação técnica sem exposição de informações sensíveis.

Mais do que manter um servidor Minecraft funcionando, o projeto serviu como um ambiente prático para entender o ciclo de operação de um serviço hospedado em cloud.

## Estrutura do repositório

~~~~text
.
├── README.md
├── AUDIT.md
├── docs/
│   ├── architecture.md
│   ├── operations.md
│   ├── security.md
│   └── troubleshooting.md
├── scripts/
│   └── backup.sh
└── systemd/
    ├── minecraft.service
    ├── minecraft-backup.service
    └── minecraft-backup.timer
~~~~

## Roadmap

Próximas evoluções planejadas para continuar utilizando o projeto como laboratório de Cloud/DevOps:

- Infrastructure as Code com Terraform;
- métricas e logs com Amazon CloudWatch;
- alertas e acompanhamento de custos;
- testes periódicos de restauração dos backups;
- maior automação do processo de implantação.

> **Nota:** esses itens fazem parte do roadmap e ainda não representam funcionalidades implementadas na versão atual.
