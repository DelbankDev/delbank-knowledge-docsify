# Pix API <!-- {docsify-ignore-all} -->

## Descrição

Descrição e contextualização do ativo.

## Stack & Tecnologias

- Linguagens
- Frameworks
- Databases
- Message Brokers
- Principais dependências

### Pilar Responsável

- Colaborador 1
- Colaborador 2
- Colaborador 3

### Links Importantes

- Repositório no Github
- Imagem no ECR
- Pipelines
- SonarQube
- Grafana
- Logs
- Gateways

## Autenticação

Conte sobre o processo de autenticação para o uso da solução.

## Implantação/Infraestrutura

### Servidores

EC2, Fargate, VPS, VM, etc.

### Bancos de Dados

SQL Server, MongoDB, Redis, etc.

#### Diagramas

DER, etc.

#### Plano de Expurgo

Rotina e processo de expurgo. Quem aciona? Quais os scripts? Qual a prioridade? Como monitorar?

### Message Brokers

RabbitMQ, SQS, SNS, etc.

#### Lista de Filas

Lista de filas utilizadas, quem publica nelas, quem faz leitura e quais ações são realizadas.

#### Diagrama de Comunicação

Se possível, monte um diagrama da comunicação entre os componentes que usam as filas.

### Serviços de Armazenamento

S3, FTP, SFTP, etc

### Variáveis de Ambiente

Banco de dados, endpoints, etc.

## Desenho da Solução

Digrama geral da solução.

## Integrações

Lista de integrações com qualquer tipo de serviço. Deve ter o tipo do serviço, descrição e motivação da comunicação. Por
exemplo: APIs externas, APIs internas, filas, etc.

## Organização do Projeto (código-fonte)

Diagrama de pastas do projeto. Caso siga alguma arquitetura de referência, inserir o link aqui.

### Visão Geral

Descrição geral do projeto.

### Diagrama por Funcionalidade

Caso alguma funcionalidade seja muito complexa e/ou possua vários níveis de integração com terceiros, é necessário criar
um diagrama de fluxo para deixar claro.

## Débitos Técnicos

Lista de débitos técnicos a serem resolvidos futuramente. Inserir links do backlog.

## Lista de Incidentes (Troubleshooting)

<details class="troubleshooting">
    <summary><b>Cash-outs externos pendentes de processamento</b></summary>
    <div>

> ### Descrição do Problema
>
> Transferências Pix feitas pelo **Delbank** para as quais o tempo de resposta do SPI é maior que 30 segundos. Pode ser
> problema no próprio SPI ou na nossa rotina de atualização de status dos Pix efetuados. Geralmente é o segundo caso.
>
> No primeiro caso, deve-se abrir um chamado para a JDPI (`jdpi@jdconsultores.com.br`) ou usar algum contato direto para
> tentar compreender e resolver a situação junto ao fornecedor.
>
> No segundo caso, o que ocorre é que após a _rotina de sondagem_ obter no SPI o status de um Pix efetuado, ela envia
> essa informação para o **PixWorker** (projeto .NET à parte) via fila, para que a atualização seja feita no banco de
> dados. Só que, por algum motivo ainda não diagnosticado (pois não há logs suficientes no PixWorker), os consumidores
> do RabbitMQ instanciados por esse projeto "morrem" e as requisições de atualização de status ficam presas na fila
_pix.update-payment-status-entity.in_. Esse Worker também gerencia os consumidores da fila
_pix.update-initiation-pix-entity.in_.
>
> ### Impacto (Quem é afetado?)
>
> Afeta clientes que NÃO usam webhook, que no momento são minoria. Logo, não é extremamente grave.
>
> Quando esse erro ocorre, também é esperado que todas as consultas de chaves fiquem com 100% de não utilização, pois
> como os status dos Pix efetuados ainda não terão sido atualizados no banco de dados, do ponto de vista da aplicação,
> aquelas consultas de chaves não foram convertidas em pagamentos. Quando a resolução for aplicada, essas porcentagens
> devem se normalizar.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso ao ECS (Elastic Container Service) de produção na AWS;
> 2. Permissão para forçar um novo deploy de um serviço, mais especificamente do PixWorker.
>
> ### Passo-a-passo da solução
>
> A solução efetiva seria diagnosticar e corrigir o problema no PixWorker. A solução manual e paliativa é:
>
> 1. Acessar a instância do PixWorker no ECS (Elastic Container Service), na AWS;
> 2. Forçar um novo deploy do PixWorker.
>
> Como há somente uma instância do PixWorker em produção, o deploy forçado fará com que a instância atual seja
> reiniciada e os consumidores do RabbitMQ sejam recriados. Dessa forma, as requisições presas na fila serão
> consumidas e os status dos Pix efetuados serão atualizados de imediato no banco de dados.
</div>
</details>

## Anexos

Lista de anexos para apoio. Por exemplo: documentação de fornecedores, outros links de documentação, etc.

## Histórico de Atualizações

Changelog **DO DOCUMENTO**. Tabela com a lista de atualizações dessa documentação, contendo a data, o autor e um resumo
das mudanças.
