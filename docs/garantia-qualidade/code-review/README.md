# Checklist para Code Reviews <!-- {docsify-ignore-all} -->

Antes de realizar um code review, é aconselhável que o desenvolvedor possua conhecimento na linguagem do código que será
analisado, para conseguir perceber se algo for feito de forma errada ou não recomendada. Dito isso, os elementos a serem
revisados em um código podem ser divididos nas seguintes categorias:

### 1. Padrões:

- [ ]  **A branches e o pull request seguem os padrões internos de nomenclatura.**
- [ ]  **Os commits seguem o padrão [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).**

### 2. Funcionalidade:

- [ ]  **O código cumpre os requisitos especificados na tarefa.**
- [ ]  **O código não possui falhas aparentes de lógica, como condições erradas em `if`s, operações matemáticas
  incorretas, etc.**

### 3. Qualidade do Código:

- [ ]  **O código está legível e bem documentado.**
- [ ]  **O código não possui comentários desnecessários ou "código morto" (isto é, código que não é mais utilizado, mas
  foi mantido como comentário).**
- [ ]  **Variáveis e métodos possuem nomes descritivos, significativos e de fácil compreensão.**
- [ ]  **O código segue as convenções de nomenclatura e estilo estabelecidas pela equipe, para a linguagem em questão.**
- [ ]  **O código segue convenções de boas práticas de programação, como Clean Code, SOLID e afins.**

### 4. Segurança:

- [ ]  **Os dados sensíveis são tratados de forma segura, como o uso de hashing para senhas e ocultação de informações
  confidenciais nas respostas da API.**
- [ ]  **Dados de autenticação, como senhas ou chaves de API, não estão sendo expostos no código e nem salvos
  descriptografados no banco de dados, arquivos de configuração ou qualquer outro lugar.**

### 5. Tratamento de Erros:

- [ ]  **O código trata adequadamente casos de erro e exceções.**
- [ ]  **São fornecidas mensagens de erro significativas e úteis nos logs e respostas da API para o usuário final.**
- [ ]  **O código possui validações para evitar potenciais NPEs (`NullPointerException`) ou outros erros comuns.**

### 6. Desempenho:

- [ ]  **O código foi otimizado para desempenho, evitando operações custosas, ou a realização da mesma operação
  repetidamente, de forma desnecessária.**
- [ ]  **As consultas ao banco de dados e _procedures_ são eficientes e usam adequadamente os campos indexados, quando
  possível.**
- [ ]  **Foram implementadas medidas de cache, quando apropriado.**
- [ ]  **O código não possui loops ou operações que possam causar _deadlocks_ ou outros problemas aparentes de
  concorrência.**

### 7. Escalabilidade e Manutenibilidade:

- [ ] **O código é fácil de entender e dar manutenção, mesmo por quem não o escreveu.**
- [ ]  **A solução é escalável e capaz de lidar com um aumento no volume de dados ou tráfego. _Especialmente quando há o
  uso de mensageiria, consumo de APIs externas e consultas a bancos de dados._**
- [ ]  **O código pode ser implantado em um ambiente de produção sem causar problemas ou interrupções. _Exemplo: se uma
  fila do RabbitMQ ou SQS for renomeada, no momento da implantação, onde a versão antiga e nova ficam no ar
  simultaneamente, o código conseguirá lidar com isso?_**

### 8. Testes:

- [ ]  **Em projetos que possuem testes automatizados, foram escritos testes unitários para cobrir as principais
  funcionalidades e casos atípicos (_corner cases_).**
- [ ]  **Os testes estão bem escritos e documentados, para serem fáceis de entender e manter.**
- [ ] **Foram considerados testes de integração, quando necessário.**
