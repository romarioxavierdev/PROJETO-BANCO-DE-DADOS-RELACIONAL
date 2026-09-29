# Modelo Relacional — TechFix

```mermaid
erDiagram
    CLIENTES ||--o{ EQUIPAMENTOS : possui
    EQUIPAMENTOS ||--o{ ORDENS_SERVICO : recebe
    TECNICOS ||--o{ ORDENS_SERVICO : atende
    ORDENS_SERVICO ||--o{ ORDEM_SERVICO_SERVICOS : possui
    SERVICOS ||--o{ ORDEM_SERVICO_SERVICOS : participa
    ORDENS_SERVICO ||--o{ ORDEM_SERVICO_PECAS : utiliza
    PECAS ||--o{ ORDEM_SERVICO_PECAS : participa
    ORDENS_SERVICO ||--o{ PAGAMENTOS : recebe
```

## Resumo dos relacionamentos

- Clientes 1:N Equipamentos
- Equipamentos 1:N Ordens de Serviço
- Técnicos 1:N Ordens de Serviço
- Ordens de Serviço N:N Serviços, através de `ordem_servico_servicos`
- Ordens de Serviço N:N Peças, através de `ordem_servico_pecas`
- Ordens de Serviço 1:N Pagamentos
