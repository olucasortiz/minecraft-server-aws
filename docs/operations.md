# Operações

Execute comandos administrativos via SSH usando o placeholder de chave:

```bash
ssh -i "<PATH_TO_PRIVATE_KEY>" ubuntu@<EC2_PUBLIC_DNS>
```

## Serviço

```bash
sudo systemctl status minecraft
sudo journalctl -u minecraft -f
sudo systemctl restart minecraft
sudo systemctl stop minecraft
sudo systemctl start minecraft
```

O serviço está configurado para iniciar no boot e reiniciar em falhas.

## Backup

O agendamento confirmado é diário às 06:00 UTC. Para verificar o timer:

```bash
sudo systemctl list-timers minecraft-backup.timer
sudo systemctl status minecraft-backup.timer
```

O backup usa parada controlada, gera `minecraft-backup-YYYY-MM-DD_HH-MM-SS.tar.gz` e retém sete arquivos. Ele somente religa o serviço quando este estava ativo antes da execução.
