# Clean Code - Guia de boas práticas

## Eficácia, Eficiência e Simplicidade

Sempre que preciso pensar em como implementar um novo recurso em uma base de código já existente, ou como resolver um problema específico, sempre priorizo ​​essas três coisas simples.

### Eficácia
Primeiro, nosso código deve ser eficaz , o que significa que deve resolver o problema que deveria resolver. Claro que esta é a expectativa mais básica que poderíamos ter para o nosso código, mas se a nossa implementação não funcionar de fato, não vale a pena pensar em qualquer outra coisa.

### Eficiência
Segundo, uma vez que sabemos que nosso código resolve o problema, devemos verificar se ele o faz de forma eficiente. O programa é executado utilizando uma quantidade razoável de recursos em termos de tempo e espaço? Ele pode funcionar mais rápido e com menos espaço?

Para expandir a eficiência, aqui estão dois exemplos de uma função que calcula a soma de todos os números em uma matriz.

```javascript
// Inefficient Example
function sumArrayInefficient(array) {
  let sum = 0;
  for (let i = 0; i < array.length; i++) {
    sum += array[i];
  }
  return sum;
}
```

Esta implementação da função `sumArrayInefficient` itera no array usando um loop `for` e adiciona cada elemento à variável `sum`. Esta é uma solução válida, mas não é muito eficiente porque requer iteração em todo o array, independentemente do seu comprimento.

```javascript
// Inefficient Example
// Efficient example
function sumArrayEfficient(array) {
  return array.reduce((a, b) => a + b, 0);
}
```

Esta implementação da função `sumArrayEfficient` usa o método `reduce` para somar os elementos do array. O reducemétodo aplica uma função a cada elemento do array e acumula o resultado. Neste caso, a função simplesmente adiciona cada elemento ao acumulador, que começa em 0.

Esta é uma solução mais eficiente porque requer apenas uma única iteração na matriz e executa a operação de soma em cada elemento à medida que avança.

### Simplicidade
E por último vem a simplicidade. Este é o mais difícil de avaliar porque é subjetivo, depende de quem lê o código. Mas algumas diretrizes que podemos seguir são:

1. Você consegue entender facilmente o que o programa faz em cada linha?
2. As funções e variáveis ​​possuem nomes que representam claramente suas responsabilidades?
3. O código está recuado corretamente e espaçado com o mesmo formato ao longo de toda a base de código?
4. Existe alguma documentação disponível para o código? Os comentários são usados ​​para explicar partes complexas do programa?
5. Com que rapidez você consegue identificar em qual parte da base de código estão determinados recursos do programa? Você pode excluir/adicionar novos recursos sem a necessidade de modificar muitas outras partes do código?
6. O código segue uma abordagem modular, com diferentes funcionalidades separadas em componentes?
7. O código é reutilizado quando possível?
8. As mesmas decisões de arquitetura, design e implementação são seguidas igualmente ao longo de toda a base de código?

Seguindo e priorizando esses três conceitos de eficácia, eficiência e simplicidade, podemos sempre ter uma diretriz a seguir ao pensar em como implementar uma solução. Agora vamos expandir algumas das diretrizes que podem nos ajudar a simplificar nosso código.

## Alguns casos de uso

### Nomes significativos de variáveis ​​e funções

Use nomes descritivos para variáveis, funções, classes e outros identificadores. Um nome bem escolhido pode transmitir o propósito da entidade, tornando o código mais compreensível. Evite nomes de variáveis ​​com uma única letra ou abreviações enigmáticas.

```javascript
// Bad variable name
x = 5

// Good variable name
totalScore = 5
```

### Mantenha funções e métodos curtos

Funções e métodos devem ser concisos e focados em uma única tarefa. O Princípio da Responsabilidade Única (SRP) afirma que uma função deve fazer uma coisa e fazê-la bem. Funções mais curtas são mais fáceis de entender, testar e manter. Se uma função se tornar muito longa ou complexa, considere dividi-la em funções menores e mais gerenciáveis.

```javascript
// Long and complex function
function processUserData(user) {
    // Many lines of code...
}

// Refactored into smaller functions
function validateUserInput(userInput) {
    // Validation logic...
}

function saveUserToDatabase(user) {
    // Database operation...
}
```

### Comentários e documentação

Use comentários com moderação e, quando o fizer, torne-os significativos. O código deve ser autoexplicativo sempre que possível. A documentação, como comentários embutidos e arquivos README, ajuda outros desenvolvedores a entender a finalidade e o uso do seu código. Documente algoritmos complexos, decisões não triviais e APIs públicas.

```javascript
// Bad comment
x = x + 1  # Increment x

// Good comment
// Calculate the total score by incrementing x
totalScore = x + 1
```

### Formatação e recuo consistentes

Siga um estilo de codificação e recuo consistentes. Isso faz com que a base de código pareça limpa e organizada. A maioria das linguagens de programação possui padrões de codificação aceitos pela comunidade (por exemplo, PEP 8 para Python, eslint para JavaScript) que você deve seguir. A consistência também se aplica às convenções de nomenclatura, espaçamento e estrutura de código.

```javascript
// Inconsistent formatting
if(condition){
    doSomething();
  } else {
      doSomethingElse();
}

// Consistent formatting
if (condition) {
    doSomething();
} else {
    doSomethingElse();
}
```

### DRY (Don't Repeat Yourself) Principle

Evite duplicar código. Código repetido é mais difícil de manter e aumenta o risco de inconsistências. Extraia funcionalidades comuns em funções, métodos ou classes para promover a reutilização do código. Quando precisar fazer uma alteração, você só precisará fazê-la em um só lugar.

Suponha que você esteja trabalhando em um aplicativo JavaScript que calcula o preço total dos itens em um carrinho de compras. Inicialmente, você tem duas funções distintas para calcular o preço de cada tipo de item: uma para calcular o preço de um livro e outra para calcular o preço de um laptop. Aqui está o código inicial:

```javascript
function calculateBookPrice(quantity, price) {
    return quantity * price;
}

function calculateLaptopPrice(quantity, price) {
    return quantity * price;
}
```

Embora essas funções funcionem, elas violam o princípio DRY porque a lógica de cálculo do preço total é repetida para diferentes tipos de itens. Se você tiver mais tipos de itens para calcular, acabará duplicando essa lógica. Para seguir o princípio DRY e melhorar a capacidade de manutenção do código, você pode refatorar o código da seguinte maneira:

```javascript
function calculateItemPrice(quantity, price) {
    return quantity * price;
}

const bookQuantity = 3;
const bookPrice = 25;

const laptopQuantity = 2;
const laptopPrice = 800;

const bookTotalPrice = calculateItemPrice(bookQuantity, bookPrice);
const laptopTotalPrice = calculateItemPrice(laptopQuantity, laptopPrice);
```

Neste código refatorado, temos uma única função calculaItemPrice que calcula o preço total para qualquer tipo de item com base na quantidade e no preço fornecidos como argumentos. Isto segue o princípio DRY porque a lógica de cálculo não é mais duplicada.

Agora, você pode calcular facilmente o preço total de livros, laptops ou qualquer outro tipo de item chamando calculaItemPrice com os valores apropriados de quantidade e preço. Essa abordagem promove a reutilização, legibilidade e manutenção do código, ao mesmo tempo que reduz o risco de erros causados ​​por código duplicado.

### Use espaços em branco significativos

Formate corretamente seu código com espaços e quebras de linha. Isso melhora a legibilidade. Use espaços em branco para separar seções lógicas do seu código. Código bem formatado é mais fácil de digitalizar, reduzindo a carga cognitiva dos leitores.

```javascript
// Poor use of whitespace
const sum=function(a,b){return a+b;}

// Improved use of whitespace
const sum = function (a, b) {
    return a + b;
}
```

### Manipulação de erros

Lide com erros normalmente. Use blocos try-catch ou mecanismos de tratamento de erros apropriados em seu código. Isso evita travamentos 
inesperados e fornece informações valiosas para depuração. Não suprima erros ou simplesmente registre-os sem uma resposta adequada.

```javascript
// Inadequate error handling
try {
    result = divide(x, y);
} catch (error) {
    console.error("An error occurred");
}

// Proper error handling
try {
    result = divide(x, y);
} catch (error) {
    if (error instanceof ZeroDivisionError) {
        console.error("Division by zero error:", error.message);
    } else if (error instanceof ValueError) {
        console.error("Invalid input:", error.message);
    } else {
        console.error("An unexpected error occurred:", error.message);
    }
}
```

### Teste

Escreva testes unitários para verificar a exatidão do seu código. O desenvolvimento orientado a testes (TDD) pode ajudá-lo a escrever um código mais limpo, forçando-o a considerar antecipadamente casos extremos e o comportamento esperado. Código bem testado é mais confiável e mais fácil de refatorar.

```javascript
// Example using JavaScript and the Jest testing framework
test('addition works correctly', () => {
    expect(add(2, 3)).toBe(5);
    expect(add(-1, 1)).toBe(0);
    expect(add(0, 0)).toBe(0);
});
```

### Refatoração

Refatore seu código regularmente. À medida que os requisitos mudam e sua compreensão do domínio do problema se aprofunda, ajuste seu código de acordo. A refatoração ajuda a manter o código limpo à medida que o projeto evolui. Não tenha medo de revisitar e melhorar o código existente quando necessário.

Suponha que você tenha uma função que calcula o preço total dos itens em um carrinho de compras com uma porcentagem fixa de desconto:

```javascript
function calculateTotalPrice(cartItems) {
    let totalPrice = 0;
    for (const item of cartItems) {
        totalPrice += item.price;
    }
    return totalPrice - (totalPrice * 0.1); // Apply a 10% discount
}
```

Inicialmente esta função calcula o preço total e aplica um desconto fixo de 10%. Porém, à medida que o projeto evolui, você percebe que precisa apoiar descontos variáveis. Para refatorar o código e torná-lo mais flexível, você pode introduzir um parâmetro de desconto:

```javascript
function calculateTotalPrice(cartItems, discountPercentage) {
    if (discountPercentage < 0 || discountPercentage > 100) {
        throw new Error("Discount percentage must be between 0 and 100.");
    }

    let totalPrice = 0;
    for (const item of cartItems) {
        totalPrice += item.price;
    }

    const discountAmount = (totalPrice * discountPercentage) / 100;
    return totalPrice - discountAmount;
}
```

Neste código refatorado:

- Adicionamos um parâmetro descontoPercentage à função calculaTotalPrice, permitindo especificar a porcentagem de desconto ao chamar a função.
- Realizamos a validação no parâmetro DiscountPercentage para garantir que ele esteja dentro de um intervalo válido (0 a 100%). Se não estiver dentro do intervalo, geramos um erro.
- O cálculo do desconto agora é baseado na percentagem de desconto fornecida, tornando a função mais flexível e adaptável às mudanças de requisitos.

Ao refatorar o código dessa forma, você melhorou sua flexibilidade e capacidade de manutenção. Você pode adaptar facilmente a função para lidar com diferentes cenários de desconto sem precisar reescrever toda a lógica. Isso demonstra a importância da refatoração regular do código à medida que seu projeto evolui e os requisitos mudam.

## Articles Reference

1. [Writing Clean Code: Best Practices and Principles](https://dev.to/favourmark05/writing-clean-code-best-practices-and-principles-3amh)
2. [How to Write Clean Code – Tips and Best Practices (Full Handbook)](https://www.freecodecamp.org/news/how-to-write-clean-code/) 
3. [10 Clean Coding Practices](https://medium.com/swlh/10-clean-coding-practices-e37ac283184d)
4. [Best Practices for Clean Code](https://gist.github.com/evaera/fee751d4e228dd262fe1174ba142a719)