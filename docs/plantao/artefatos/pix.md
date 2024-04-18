# Fluxo Pix

[Sobre a API do Pix.](/ativos-software/pix/)

// TODO

## Status de uma transação
<h5 style="color: white !important">Ferramentas necessárias</h5>

- Ferramentas para banco de dados [Dbeaver](https://dbeaver.io/download/) e [MongoDB Compass](https://www.mongodb.com/products/tools/compass)
- Ferramenta para Httclient pode ser [Insomnia](https://insomnia.rest/download) ou [Postman](https://www.postman.com/downloads/) (recomendado: postman).

<h5 style="color: white !important">Endpoints internos usados</h5>

- Endpoint para consultar informação das transações `https://xnmk9le5m7.execute-api.us-east-1.amazonaws.com/prd/api/v1/pix/:endToEnd`
- Endpoint para reenvio do webhook na api do webhook:
    - URI `http://nlb-prod-private-3f0e64f8b20e9491.elb.us-east-1.amazonaws.com:1094/api/v1/webhooks/resend-notification`
    - Headers:
        - 'Content-Type: application/json'
        - 'accept: \*/\*'
        - 'x-delbank-api-key: {apiKey}
    - Body:
        - idempotencyKey: {endToEndId}

- Endpoint para reenvio do webhook na api do Pix:
    - URI `http://nlb-prod-private-3f0e64f8b20e9491.elb.us-east-1.amazonaws.com/internal/api/v1/pix/cashin/resend-webhook?filterType=TX_ID&skipItemError=false`
    - Headers:
        - 'Content-Type: text/plain'
        - 'accept: \*/\*' \
    - Body: `vcharge1f4c6ef163ef48678133138b0`

<h4 style="color: white !important"> Consultando o status de uma transação enviado pelo whatsapp</h4>

<h5> Diferença entre endToEnd e chave idempotência</h5>

EndToEnd começam com a letra E ou com a letra D
- E3822485720240416173206093905522

- D592854112024041617326pmkpmQC38U

A chave idempotência é passado pelo usuário, para cada cliente tem uma string diferente, segue alguns exemplos dos nossos clientes.

- S202404149shf1Xh
- A20240416174845222555

Ambos são identificadores únicos para cada Pix.

Para cashout (Enviando Pix. É possível saber que é um cashout porque depois do prefixo E contém o ipsb do delbank 3822...).
O primeiro passo para consultar é ir na tabela tb_pix consultar a coluna cd_situacao. Existem 3 estados possíveis, -1, 0 e 9; erro, processando e sucesso respectivamente. as possíveis meios para fazer consulta nessa tabela:

```sql
SELECT
    top 10 *
FROM DB_PIX.delbank_pix.tb_iniciacao_pix tip (NOLOCK)
WHERE tip.end_to_end_id = 'E24654881202404101601213aCLSegjo'
```

ou

```sql
SELECT
    top 10 *
FROM DB_PIX.delbank_pix.tb_pix (NOLOCK)
WHERE chave_idempotencia = '0011270220240412f83m84rk'
```

- Para o caso `cd_erro = -1`: Erro no recebedor. Para esses casos existe a coluna preenchida cd_erro que tem os erros mapeados da JD.É possível consultar os códigos de erro nesse no arquivo da JD (esse arquivo será enviado no teams).

- Para o caso `cd_erro = 9`: Esse caso é o de sucesso. Quer dizer o dinheiro chegou no recedor e deu tudo certo. O webhook também foi enviado.

- Para o caso `cd_erro = 0`: Em processing. Significa que não recebemos do SPI(responsável pelo PIX) a confirmação final do status. Para esses casos as vezes necessário reprocessar o Pix. Devido as últimas mudanças não aparece esses casos. Para isso é necessário esperar um pouco para mudar o status para o 9 ou -1. Pix de devoluções atualmente fica em 0 para sempre, mas a transação foi sucesso.

<h5 style="color: white !important"> Para casos de não encontrar no tb_pix.</h5>
Verificar na tabela transaction pelo Id que é a chave_idempotência na tb_pix:

```sql
SELECT
    top 10 *
FROM DB_DELBANK.BankAccounts.Transactions t (NOLOCK)
WHERE t.Id = '4793d84b-d8b5-433e-a4c4-86fd820dd95d'
```

Existe uma tebela gêmea da transaction que pode procurar nela também.

```sql
SELECT
    top 10 *
FROM DB_DELBANK.FundTransfers.FundTransfers ft (NOLOCK)
WHERE ft.Id = '0013800920240414figz7cIk'
```

Essas tabela é a que aparece no extrato. Então é possível que no dasbboard(nosso internet banking) diga que a transação foi sucesso mesmo não estando na tb_pix. Para esses casos, signigica que o dinheiro saiu da conta do usuário, mas ainda não foi para o fluxo do Pix.

Se também não estiver na transaction e fundTransfer, não significa que a transação falhou é necessário olhar também na tabela de fila. Se o sistema da Delbank respondeu 200 ele pelo menos inseriu nessa tabela. A busca na tabela pode ser feita dessa meneira:

```sql
SELECT
    top 10 *
FROM DB_DELBANK.FundTransfers.TransferCashoutQueue tcq (NOLOCK)
WHERE tcq.PixEndToEndId = 'E3822485720240414150106188834660'
```

caso estaja somente nessa tabela, significa que ela ainda será processada e ficou em espera em uma das nossas filas de processo.

Caso não esteja nem nessa tabela, é preciso olhar no logs que possívelmente para essa transação foi retornado um erro 500. Para garantir isso é necessário consultar nos logs do clouldWatch (*tutorial em breve*).

<h4 style="color: white !important">Status de uma transação devolvida.</h4>

Para verificar se uma transação foi devolvida é só consulta na tabela tb_pix buscando pelo endToEndOriginal.
Exemplo: E24654881202404101601213aCLSegjo na consulta fica

```sql
SELECT
    top 10 *
FROM DB_PIX.delbank_pix.tb_pix tp (NOLOCK)
WHERE tp.end_to_end_id_original = 'E3788020620240412194070XYWOKFY8I'
```

<h4 style="color: white !important">CloudWatch</h4>

// TODO

## Reenvio de webhook

// TODO

## Arquivos Úteis

- [Participantes Homologados](/plantao/arquivos/participantes-homologados.md)
- [Lista APIs JDPI](/plantao/arquivos/jdpi.md)