# Minecraft Server Infrastructure on AWS

Projeto de Cloud/DevOps criado a partir de uma necessidade real: hospedar e administrar um servidor Minecraft privado utilizando infraestrutura em nuvem, aplicando conceitos de Linux, redes, segurança e automação na AWS.

## Contexto

Meu irmão queria jogar Minecraft com amigos, mas não tinha familiaridade com hospedagem de servidores, configuração de rede ou administração de infraestrutura.

Vi nisso uma oportunidade de transformar uma necessidade real em um projeto prático.

Durante a faculdade, na disciplina de Tópicos Computacionais, tive contato com conceitos de computação em nuvem utilizando Oracle Cloud. Decidi aplicar esses conhecimentos em um ambiente diferente, utilizando a AWS e assumindo a configuração e operação do servidor.

Em vez de contratar uma hospedagem de Minecraft pronta, configurei uma instância Amazon EC2 com Ubuntu para executar e administrar o servidor diretamente.

O que começou como uma forma de facilitar o acesso ao jogo se tornou um laboratório prático de Cloud/DevOps.

## Objetivo

Construir e operar um servidor Minecraft Java persistente na AWS, aplicando na prática conceitos de:

- infraestrutura em nuvem;
- administração Linux;
- acesso remoto via SSH;
- redes e controle de acesso;
- gerenciamento de serviços com systemd;
- execução da aplicação com usuário dedicado;
- automação de backups;
- troubleshooting e monitoramento por logs.

## Arquitetura

```mermaid
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
