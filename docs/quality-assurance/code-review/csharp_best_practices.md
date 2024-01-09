# C# - Guia de boas práticas

3. Use programação assíncrona usando C# async await where application, pois melhora tremendamente o desempenho

https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/

4. Use os novos recursos da linguagem C#, por exemplo, use o operador nameof para obter os nomes das propriedades/métodos em vez de codificá-los

if (IsNullOrWhiteSpace(sobrenome))

throw new ArgumentException(mensagem: “Não pode ficar em branco”, paramName: nameof(lastName));

5. Todos os não utilizados precisam ser removidos. A limpeza de código desnecessário é sempre uma boa prática.usings

6. A verificação ' nulo ' precisa ser executada sempre que aplicável para evitar a exceção de referência nula em tempo de execução, use o novo recurso do C# 6.0 “Operadores nulos condicionais” para isso, um exemplo conforme fornecido abaixo

var primeiro = pessoa?.PrimeiroNome;

Para obter mais explicações sobre isso, consulte o link abaixo

https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-6

7. Siga as práticas recomendadas ao escrever código, seguindo o princípio SOLID e os padrões de design de software

https://www.c-sharpcorner.com/UploadFile/damubetha/solid-principles-in-C-Sharp/

https://www.dofactory.com/net/design-patterns

8. Escreva componentes fracamente acoplados, siga o conceito de injeção de dependência, extremamente importante, ajuda ao fazer testes de unidade também

https://www.dotnetcurry.com/software-gardening/1284/dependency-injection-solid-principles

9. Reutilização de código : extraia um método se o mesmo trecho de código estiver sendo usado mais de uma vez ou se você espera que seja usado no futuro. Crie alguns métodos genéricos para tarefas repetitivas e coloque-os em uma classe relacionada para que outros desenvolvedores comecem a usá-los assim que você os intimar. Desenvolva controles de usuário para funcionalidades comuns para que possam ser reutilizados em todo o projeto.