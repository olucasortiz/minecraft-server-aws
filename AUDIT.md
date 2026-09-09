# Auditoria somente leitura

Data da auditoria: 2026-09-09. Nenhuma configuração, pacote, serviço ou recurso AWS foi alterado.

## Infraestrutura observada pela VM

| Item | Confirmado |
| --- | --- |
| Sistema | Ubuntu 26.04 x86_64 |
| Kernel | `7.0.0-1006-aws` |
| CPU | 2 vCPU Intel Xeon Platinum 8488C |
| Memória | 7.6 GiB total; 4.9 GiB disponível no momento da auditoria |
| Swap | Não configurada |
| Disco raiz | 28 GiB total; 25 GiB livres (13% usado) |
| Java | OpenJDK 25.0.4 |

## Minecraft e serviço

| Item | Confirmado |
| --- | --- |
| Minecraft | 26.2 |
| Paper | `26.2-121-main` / API `26.2.build.121-stable` |
| Serviço | `minecraft.service`, enabled e active/running |
| Processo | Java executado como `minecraft` |
| Diretório de trabalho | `/opt/minecraft/server` |
| Inicialização | `java -Xms2G -Xmx6G -jar /opt/minecraft/server/paper.jar --nogui` |
| Reinício | `on-failure`, atraso de 10 segundos |
| Porta | Java em escuta em `*:25565` |

## Propriedades confirmadas

| Propriedade | Valor |
| --- | --- |
| `server-port` | `25565` |
| `max-players` | `10` |
| `online-mode` | `true` |
| `white-list` | `true` |
| `gamemode` | `survival` |
| `difficulty` | `normal` |
| `hardcore` | `false` |
| `level-name` | `world` |
| `level-type` | `minecraft:normal` |
| `view-distance` | `8` |
| `simulation-distance` | `6` |
| `enable-rcon` | `false` |
| `enable-query` | `false` |

## Backup

- `minecraft-backup.timer` está enabled e active.
- Próxima agenda observada: 06:00 UTC diariamente.
- O unit executa `/opt/minecraft/scripts/backup.sh`.
- O script arquiva os itens existentes entre mundos, propriedades, configurações e plugins, e retém os sete backups mais recentes.

## Logs úteis

As linhas inspecionadas mostraram conclusão normal da inicialização (`Done`), preparação dos mundos e escuta da porta 25565. O log também informou que o build do Paper estava duas versões atrás no momento da leitura. Nenhuma atualização foi realizada por estar fora do escopo. Eventos de jogadores, UUIDs, endereços de clientes e coordenadas foram deliberadamente omitidos.

## Limites da auditoria

A VM não permite confirmar, sem consultar a AWS: Security Groups, regras de rede fora do sistema operacional, VPC, subnet, IAM, custos, billing, tipo/tags da instância, snapshots, Elastic IP, CloudWatch ou alarmes.
