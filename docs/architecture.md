# Arquitetura

O host público é representado apenas por placeholders neste repositório.

```mermaid
flowchart TB
  Admin[Administrador] -->|SSH com <PATH_TO_PRIVATE_KEY>| Host[EC2 Ubuntu\n<EC2_PUBLIC_DNS>]
  Client[Cliente Minecraft] -->|TCP 25565| Host
  Host --> Service[minecraft.service]
  Service --> Runtime[Java 25 + PaperMC]
  Runtime --> Data[/opt/minecraft/server]
  Timer[minecraft-backup.timer] --> Job[minecraft-backup.service]
  Job --> Script[/opt/minecraft/scripts/backup.sh]
  Script --> Store[/opt/minecraft/backups]
```

O serviço principal é gerenciado pelo systemd e usa `/opt/minecraft/server` como diretório de trabalho. O agendador systemd chama um job Bash independente para backup.
