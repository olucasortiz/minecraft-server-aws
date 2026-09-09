# Troubleshooting

## Serviço não inicia

```bash
sudo systemctl status minecraft --no-pager
sudo journalctl -u minecraft -n 100 --no-pager
java -version
```

Confirme a presença do JAR no diretório de trabalho e a versão Java requerida pelo Paper instalado antes de alterar qualquer coisa.

## Porta inacessível

```bash
sudo ss -lntp | grep 25565
```

Se o listener local existir, valide separadamente as regras AWS e a conectividade externa; esses controles não são visíveis de forma completa pela VM.

## Backup falhou

```bash
sudo systemctl status minecraft-backup.service --no-pager
sudo journalctl -u minecraft-backup.service -n 100 --no-pager
sudo ls -lh /opt/minecraft/backups
```

Não copie dados de mundo em uso manualmente. Investigue o job de backup e mantenha a estratégia de parada controlada.

## Uso de recursos

```bash
free -h
df -h /
ps -o user,pid,ppid,cmd -C java
```
