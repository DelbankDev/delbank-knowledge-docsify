# Queries Úteis

<h3 style="color: white !important;"> Esta seção contempla as queries SQL para consultas gerais de monitoramento. </h3>

## Pagamento de Contas

- <h4 style="color: white !important;"> Agendamentos Pendentes </h4>

    ```sql
    SELECT * 
    FROM Charges.BankslipPaid bp (nolock) 
    WHERE
        CAST(GETDATE() AS DATE) >= DATEADD(HOUR, -3, bp.PayAt)
        AND DeletedAt IS NULL
        AND PaidAt IS NULL
        AND Status NOT IN ('ScheduleFailure')
    ```

- <h4 style="color: white !important;"> Agendamentos com Erro </h4>

    ```sql
    SELECT * 
    FROM Charges.BankslipPaid bp (NOLOCK) 
    WHERE
        AND DeletedAt IS NULL
        AND Status = 'ScheduleFailure'
    ```

- <h4 style="color: white !important;"> Pendente de Baixa na PCR </h4>

    ```sql
    SELECT * 
    FROM Charges.BankslipPaid bp (NOLOCK)
    LEFT JOIN Charges.ViewLastBankslipPaidHistories bph (NOLOCK)
        ON bp.Id = bph.BankslipPaidId
    WHERE bp.PayAt >= CAST(GETDATE() AS DATE) 
        AND bp.Status = 'Paid'
        AND BarCode IS NOT NULL 
        AND bph.Status NOT IN ('SendingToPcr', 'SentToPcr', 'SendingToCompe', 'SentToCompe', 'SentToSpb', 'ConfirmedPcrPayment')
    ```

- <h4 style="color: white !important;"> Histórico de Falhas de Baixa na PCR </h4>

    ```sql
    SELECT
        top 100 *
    FROM Charges.BankslipPaidHistories bph (nolock) 
    WHERE bph.Status IN ('FailedToSendToPcr', 'PcrPaymentConfirmationFailure') 
    ORDER BY bph.CreatedAt DESC
    ```


## TEDs

- <h4 style="color: white !important;"> Agendamentos com Erro </h4>

    ```sql
    SELECT *
    FROM FundTransfers.FundTransfers ft (NOLOCK)
    WHERE ft.Status = 'CompleteScheduledError' 
        AND ft.[Type] = 'External'
        AND ft.DeletedAt is null
    ```

- <h4 style="color: white !important;"> Pendente de Envio SPB (D-3) </h4>

    ```sql
    SELECT
        top 100 *
    FROM DB_DELBANK.FundTransfers.FundTransfers ft (NOLOCK)
    WHERE ft.[Type] = 'External'
        AND CAST(ft.CreatedAt AS DATE) >= CAST(DATEADD(DAY, -3, GETDATE()) AS DATE)
        AND ft.Status NOT IN ('CompleteScheduledError', 'Dispatched', 'DispatchedWithQueue', 'ScheduledWithQueue');
    ```

- <h4 style="color: white !important;"> Mensagens SPB não processadas (D-3) </h4>

    ```sql
    SELECT *
    FROM FundTransfers.ExternalTransfersReceived etr (NOLOCK)
    WHERE CAST(etr.CreatedAt AS DATE) >= CAST(DATEADD(DAY, -3, GETDATE()) AS DATE)
        AND etr.DeletedAt IS NULL
        AND (etr.Status = 'Error' 
            OR etr.Status != 'Processed' 
            AND etr.CreatedAt <= DATEADD(MINUTE, -20, DATEADD(HOUR, -3, GETUTCDATE())))
    ```