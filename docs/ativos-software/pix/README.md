# Pix API <!-- {docsify-ignore-all} -->

## Descrição

Descrição e contextualização do ativo.

## Stack & Tecnologias

- Java
- Spring Boot
- SQL Server, MongoDB e Redis
- RabbitMQ

### Pilar Responsável

- [Alexandre Vieira](https://github.com/tech-andrade)
- [Wesley Alves](https://github.com/wyalves)

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
<summary><b>Cash-outs pendentes de atualização de status</b></summary>
<div>

> ### Descrição do Problema
>
> Pix feitos pelo **Delbank** para as quais o tempo de resposta do SPI é maior que 30 segundos. Pode ocorrer por
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
> Afeta clientes que NÃO usam webhook, que no momento são minoria. Logo, não é grave.
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
</details><br/>

<details class="troubleshooting">
<summary><b>Cash-outs debitados e não enviados ao SPI</b></summary>
<div>

> ### Descrição do Problema
>
> Pix feitos do **Delbank** para outras instituições financeiras, cujo valor foi debitado da conta do cliente
> **Delbank**, mas não foi enviado para o SPI. Pode ocorrer por uma multitude de razões, como falha no consumo de
> mensagens de uma fila, timeout na comunicação com a JDPI/SPI, etc.
>
> ### Impacto (Quem é afetado?)
>
> Pode afetar qualquer tipo de cliente. É grave, pois significa que o valor não chegou ao recebedor, o que pode ter
> implicações legais e financeiras para o cliente.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso à API do _Backoffice_ em produção (porta 1080 do Load Balancer);
> 3. Permissões de consulta na tabela `DB_DELBANK.FundTransfers.FundTransfers`, em produção.
>
> ### Passo-a-passo da solução
>
> 1. Buscar as transações em questão na tabela `DB_DELBANK.FundTransfers.FundTransfers`;
> 2. Utilizar o endpoint `POST /api/v1/backoffice/bank-accounts/fund-transfers/sync-pix-batch` para fazer o
     reprocessamento, informando uma lista com os IDs das transações a serem reprocessadas. Os IDs que devem ser
     informados são os da chave primária `Id`, da tabela `DB_DELBANK.FundTransfers.FundTransfers`.
>
> Ao fazer isto, o _Backoffice_ irá verificar se as iniciações dos Pix a serem reprocessados foram criados há mais de
> _15 minutos_. Caso não, então os End-to-end IDs gerados anteriormente serão reutilizados. Caso contrário, serão
> gerados novos End-to-end IDs.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Cash-outs pendentes de devolução</b></summary>
<div>

> ### Descrição do Problema
>
> Assim como no caso anterior, tratam-se de Pix feitos do **Delbank** para outras instituições financeiras, cujo valor
> foi debitado da conta do cliente **Delbank**, mas não foi enviado para o SPI. A diferença é que, em certas situações,
> ao invés de reprocessar o pagamento, pode-se querer devolver o valor para a conta do cliente pagador.
>
>  ### Impacto (Quem é afetado?)
>
> Pode afetar qualquer tipo de cliente. É grave, pois o dinheiro nem foi enviado ao recebedor, nem devolvido ao
> cliente pagador.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso ao banco de dados `DB_DELBANK` em produção;
> 3. Permissão para executar a procedure `DB_DELBANK.BankAccounts.UndoneTransfer`.
>
> ### Passo-a-passo da solução
>
> 1. Executar a procedure `DB_DELBANK.BankAccounts.UndoneTransfer`, informando o ID da transação (obtido da tabela
     `FundTransfers`) a ser desfeita.
>
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Erro no processamento de Cash-outs pelo Core Banking</b></summary>
<div>

> ### Descrição do Problema
>
> Ao tentar processar cash-outs de Pix, o _Core Banking_ pode sofrer com erros, e as transações podem parar na
> fila `core-banking.process-debit-pix.error`, do virtual host `/core-banking`. Isso pode ocorrer tanto por erros não
> tratados pelo Core, quanto por falha na comunicação com o _Pix_.
>
> Esse também é um caso de "Cash-outs debitados e não enviados ao SPI", só que nesse cenário a transação sequer chega à
> API do Pix.
>
>  ### Impacto (Quem é afetado?)
>
> É grave e pode afetar qualquer tipo de cliente.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso ao RabbitMQ Management de produção;
> 3. Permissões para mover mensagens de uma fila para outra, no RabbitMQ Management.
>
> ### Passo-a-passo da solução
>
> 1. Acessar o RabbitMQ Management de produção;
> 2. Na aba `Queues`, buscar pela fila `core-banking.process-debit-pix.error`, no virtual host `/core-banking`;
> 3. Utilizar a busca de mensagens, `Get messages`, para buscar as mensagens a serem reprocessadas;
> 4. Copiar o conteúdo da mensagem, que é um JSON, descrito no campo `Payload`;
> 5. Acessar a fila `core-banking.process-debit-pix.in`, no virtual host `/core-banking`;
> 6. Utilizar a opção `Publish message` para enviar as mensagens copiadas anteriormente para a fila de entrada;
>
> Antes de proceder com essa solução, é recomendado analisar os logs da aplicação, pare se certificar de que o erro que
> ocorreu anteriormente pode ser resolvido com um retry, e que não irá persistir ao longo das múltiplas tentativas.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Falha na efetivação de Pix Agendados</b></summary>
<div>

> ### Descrição do Problema
>
> Quando um Pix é agendado, pode acontecer de no horário marcado para o pagamento, o mesmo não ser efetivado. Isso
> pode ocorrer por falha na comunicação entre o _Pix_ e o _Core Banking, ou por tentativa de uso de uma
> _Iniciação de Pagamento_ expirada.
>
> ### Impacto (Quem é afetado?)
>
> Pode afetar qualquer tipo de cliente, mas afeta principalmente clientes finais, pois clientes de integração não
> costumam utilizar o agendamento. É grave, pois significa que o valor não chegou ao recebedor, o que pode ter
> implicações legais e financeiras para o cliente.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso à API do _Backoffice_ em produção (porta 1080 do Load Balancer);
> 3. Permissões de consulta na tabela `DB_DELBANK.FundTransfers.FundTransfers`, em produção.
>
> ### Passo-a-passo da solução
>
> 1. Buscar as transações em questão na tabela `DB_DELBANK.FundTransfers.FundTransfers`;
> 2. Utilizar o endpoint `POST /api/v1/backoffice/bank-accounts/fund-transfers/sync-pix-batch` para fazer o
     reprocessamento, informando uma lista com os IDs das transações a serem reprocessadas. Os IDs que devem ser
     informados são os da chave primária `Id`, da tabela `DB_DELBANK.FundTransfers.FundTransfers`.
>
> Ao fazer isto, o _Backoffice_ irá verificar se as iniciações dos Pix a serem reprocessados foram criados há mais de
> _15 minutos_. Caso não, então os End-to-end IDs gerados anteriormente serão reutilizados. Caso contrário, serão
> gerados novos End-to-end IDs.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Desfazimento de Devolução com erro no processamento</b></summary>
<div>

> ### Descrição do Problema
>
> Quando ocorre um erro interno em um Pix, o processo de desfazimento do mesmo é feito de forma automática. Porém, para
> devoluções de Pix, o desfazimento ainda é manual. Geralmente, o erro ocorre por timeout na comunicação com o SPI.
>
> Este cenário é parecido com o de _Cash-outs debitados e não enviados ao SPI_, mas há casos em que se poder querer
> cancelar a devolução, ao invés de prosseguir com a mesma. Nestes cenários, o reprocessamento não é o apropriado.
>
> ### Impacto (Quem é afetado?)
>
> Depende bastante do cenário e pode afetar qualquer tipo de cliente. É grave, pois embora não haja mais a necessidade
> de enviar o dinheiro para o recebedor, o montante ainda está retido na conta do cliente pagador.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso ao RabbitMQ Management de produção;
> 3. Permissões para mover mensagens de uma fila para outra, no RabbitMQ Management.
>
> ### Passo-a-passo da solução
>
> 1. Acessar o RabbitMQ Management de produção;
> 2. Na aba `Queues`, buscar pela fila de erros de devolução, `pix.devolucao.error`, no virtual host `/pix`;
> 3. Utilizar a busca de mensagens, `Get messages`, para buscar a devolução que se deseja cancelar;
> 4. Copiar o conteúdo da mensagem, que é um JSON, descrito no campo `Payload`;
> 5. Acessar a fila de desfazimento de devoluções, `pix.devolucao.undo`, no virtual host `/pix`;
> 6. Utilizar a opção `Publish message` para enviar a mensagem copiada anteriormente para a fila de desfazimento.
> 7. Monitorar os logs do _Pix_ para verificar se a devolução foi desfeita com sucesso.
>
> Ao fazer isto, na tabela `DB_PIX.delbank_pix.tb_pix`, a transação desfeita deve ficar com o status
> (coluna `cd_situacao`) como `-1` e data do desfazimento (coluna `dt_desfazimento`) preenchida com a data e hora
> atual. Além disso, o valor da transação deve ser devolvido para a conta do cliente pagador.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Desfazimento de Devolução com status de Erro</b></summary>
<div>

> ### Descrição do Problema
>
> Este cenário difere do anterior porque a devolução foi feita com sucesso e devidamente enviada ao SPI, mas após o
> processo de sondagem, o status retornado é `-1` (erro). Ou seja, trata-se de um erro de negócio, e não um erro
> técnico. Quando isso ocorre, os Pix são postados na fila `pix.devolucao.analysis`, para investigação. No entanto,
> essa fila não possui consumidores, então é preciso realizar o desfazimento manualmente, para que o dinheiro retorne à
> conta do cliente. Logo, a solução é parecida com a do problema anterior, embora a causa do problema seja diferente.
>
> ### Impacto (Quem é afetado?)
>
> É grave e pode afetar qualquer tipo de cliente.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso ao RabbitMQ Management de produção;
> 3. Permissões para mover mensagens de uma fila para outra, no RabbitMQ Management.
>
> ### Passo-a-passo da solução
>
> 1. Acessar o RabbitMQ Management de produção;
> 2. Na aba `Queues`, buscar pela fila de erros de devolução, `pix.devolucao.analysis`, no virtual host `/pix`;
> 3. Utilizar a busca de mensagens, `Get messages`, para buscar a devolução que se deseja desfazer;
> 4. Copiar o conteúdo da mensagem, que é um JSON, descrito no campo `Payload`;
> 5. Acessar a fila de desfazimento de devoluções, `pix.devolucao.undo`, no virtual host `/pix`;
> 6. Utilizar a opção `Publish message` para enviar a mensagem copiada anteriormente para a fila de desfazimento.
> 7. Monitorar os logs do _Pix_ para verificar se a devolução foi desfeita com sucesso.
>
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Webhook não enviado</b></summary>
<div>

> ### Descrição do Problema
>
> Quando um Pix é feito para um _Cliente de Integração_, um webhook é enviado para o endpoint configurado pelo cliente,
> para notificar sobre o pagamento. Pode ocorrer de o webhook não ser enviado, ou ainda, o próprio cliente solicitar o
> reenvio do webhook.
>
> ### Impacto (Quem é afetado?)
>
> Clientes de integração que possuam webhook configurado. A gravidade do problema depende da situação; se o webhook não
> foi enviado por falha interna, então é grave, pois o cliente não tem como saber se o pagamento foi efetuado. Se o
> cliente solicitar o reenvio, mesmo com o webhook tendo sido enviado anteriormente, então o problema é menos grave.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso à API do _Pix_ em produção (porta 1086 do Load Balancer).
>
> ### Passo-a-passo da solução
>
> 1. Obter os IDs dos Pix cujo webhook deseja-se reenviar. Esses IDs podem ser End-to-end IDs, IDs de Correlação ou IDs
     de Conciliação. A escolha deve ser informada no corpo do request, no campo `filterType`.
> 2. Utilizar o endpoint `POST /internal/api/v1/pix/cashin/resend-webhook` para reenviar os webhooks. O corpo do
     request deve conter o `filterType`, bem como uma lista dos IDs dos Pix a serem reenviados, informados no
     campo `ids`, e formatados como uma única string, separados por um carácter de quebra de linha (`\n`).
> 3. Opcionalmente, pode-se informar também o campo booleano `skipItemError`. Se este campo for informado como `false`,
     a requisição irá parar ao primeiro erro encontrado. Se for informado como `true` ou omitido, a requisição irá
     ignorar os erros e continuar o reenvio dos webhooks.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Bloqueio de consultas ao DICT</b></summary>
<div>

> ### Descrição do Problema
>
> Se algum cliente estiver fazendo mau uso das consultas ao DICT, ou ainda, se for suspeito de fraude, é possível
> bloqueá-lo de realizar mais consultas.
>
> ### Impacto (Quem é afetado?)
>
> Apenas os clientes bloqueados.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Permissões para realizar UPDATE na tabela `DB_PIX.delbank_pix.tb_parametro`, em produção.
>
> ### Passo-a-passo da solução
>
> 1. Utilizar a seguinte query:
     ```sql
     UPDATE DB_PIX.delbank_pix.tb_parametro
     SET vl_parametro = CONCAT(vl_parametro, ',?')
     WHERE cp_nm_secao = 'PIX'
     AND cp_nm_parametro = 'PIX_DICT_PIPAYERID_BLOCKED';
     ```
> 2. Substituir o `?` pelo documento do cliente a ser bloqueado. Perceba que há uma vírgula antes da `?`, pois essa
     coluna armazena uma lista de documentos separados por vírgula.
</div>
</details><br/>

<details class="troubleshooting">
<summary><b>Devolução de Pix por conta de MEDs</b></summary>
<div>

> ### Descrição do Problema
>
> Se um cliente **Delbank** for suspeito de realizar fraudes, a instituição financeira das entidades lesadas podem abrir
> uma _Notificação de Infração_, que faz parte do fluxo de MEDs (_Medidas Especiais de Devolução_), e será analisada
> pelos _Operadores da Cabine do Pix_. Quando uma Notificação de Infração é aceita, cria-se então uma
> _Solicitação de Devolução_.
>
> Atualmente, o processamento de MEDs é feito de forma manual. Uma vez criada a Solicitação de Devolução, têm-se um
> prazo de 24h para devolver o Pix.
>
> ### Impacto (Quem é afetado?)
>
> O cliente suspeito de fraude, pois o valor do Pix será devolvido para a conta do pagador.
>
> ### Pré-requisitos para a solução
>
> 1. Acesso à VPN de produção;
> 2. Acesso à API do _Pix_ em produção (porta 1086 do Load Balancer).
>
> ### Passo-a-passo da solução
>
> 1. Executar o endpoint `/internal/api/v1/infraction-reports/effective-temporary-blocking?bankAccount=12345?`,
     informando a conta bancária do cliente suspeito de fraude;
> 2. Depois, executar o endpoint `/internal/api/v1/infraction-reports/effective-refund-request`;
> 3. E por fim, executar o
     endpoint `/internal/api/v1/infraction-reports/send-refund-request-jdpi?afterCreatedAt=2024-01-01`, informando uma
     data anterior à da criação da Notificação de Infração.
>
> O primeiro endpoint irá realizar um bloqueio temporário de saldo na conta do cliente, bloqueando o maior valor
> possível que não ultrapasse a soma de todas as Solicitações de Devolução pendentes para aquela conta. O segundo
> endpoint irá realizar as devoluções. E o terceiro endpoint irá atualizar o status das devoluções no SPI, marcando-as
> como concluídas.

</div>
</details><br/>

## Anexos

Lista de anexos para apoio. Por exemplo: documentação de fornecedores, outros links de documentação, etc.

## Histórico de Atualizações

Changelog **DO DOCUMENTO**. Tabela com a lista de atualizações dessa documentação, contendo a data, o autor e um resumo
das mudanças.
