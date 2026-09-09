# Segurança

## Controles confirmados

- O processo Java roda como usuário e grupo `minecraft`, não como root.
- O unit aplica `NoNewPrivileges=true`, `PrivateTmp=true` e `UMask=0027`.
- `online-mode=true` preserva a autenticação oficial.
- `white-list=true` restringe a entrada a jogadores autorizados.
- RCON e query estão desabilitados.
- O serviço tem somente a porta de jogo documentada em escuta local: TCP 25565.

## Higiene do repositório

Não versionar chaves privadas, credenciais AWS, IPs ou DNS reais, UUIDs, dados de jogadores, mundos, logs, JARs ou backups. Use `<EC2_PUBLIC_IP>`, `<EC2_PUBLIC_DNS>`, `<EC2_PRIVATE_IP>` e `<PATH_TO_PRIVATE_KEY>` em exemplos.

## Limites

Regras de AWS Security Group, IAM, VPC e controles de conta não foram auditados a partir da VM.
