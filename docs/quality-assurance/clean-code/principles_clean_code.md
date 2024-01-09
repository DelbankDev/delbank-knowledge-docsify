# Os Princípios do Código Limpo: DRY, KISS e YAGNI

Na busca por escrever código de alta qualidade, os desenvolvedores adotaram vários princípios de arquitetura e design. Dentre esses princípios, três se destacam pela capacidade de promover código limpo, sustentável e eficiente: DRY ( Don't Repeat Yourself ), KISS ( Keep It Simple, Stupid ) e YAGNI ( You Ain't Gonna Need It ). Compreender e aplicar esses princípios pode melhorar significativamente a legibilidade, a capacidade de manutenção e o desempenho de nossa base de código. Neste artigo, irei me aprofundar em cada princípio, explorando suas definições, benefícios e estratégias práticas de implementação.

## DRY
Don't' Repeat Yourself (DRY) é um acrônimo muito comum usado por programadores para denotar que os programas de software são criados para automatizar certas tarefas repetitivas que os humanos não desejam desperdiçar tempo e energia. Caso você esteja repetindo a mesma linha de comando em uma matriz de codificação, existem métodos disponíveis para reduzir ou eliminar completamente a repetição. Um exemplo é dado abaixo. Iniciantes em programação escreverão o seguinte programa se desejarem exibir uma tabuada de multiplicação de 7 em linhas diferentes:

```php
println(7 * 1);
println(7 * 2);
println(7 * 3);
println(7 * 4);
println(7 * 5);
println(7 * 6);
println(7 * 7);
println(7 * 8);
println(7 * 9);
println(7 * 10); 
```

Supondo que alguém deseje exibir a tabuada até sete vezes cem, isso adicionaria mais 90 linhas ao programa!

É aqui que o princípio DRY entra em cena. Por que repetir itens de linha em um programa quando você pode escrever o mesmo programa em três linhas usando o comando Loop para n número de repetições. Portanto, o exemplo acima pode ser escrito como abaixo:

```php
for (var i = 1; i < 11; i++)  {
    println(7 * i);
}
```

Portanto, você pode reduzir a repetição na codificação. Isso se aplica a todos os idiomas em todas as plataformas. Tudo que você precisa fazer é consultar conceitos básicos.

Existem outras aplicações do princípio DRY que ajudam a criar uma programação mais limpa.

- Evite duplicação em comentários de código: Freqüentemente, um desenvolvedor usaria o sinal //, * ou # para explicar a funcionalidade de um código e então iniciaria a codificação. Portanto, há uma duplicação conhecida na funcionalidade que se desvia do princípio DRY. Quando devido a uma alteração no requisito ou qualquer outro motivo, o código deve ser alterado, então o comentário também deve ser alterado de acordo. Isso pode ser evitado usando o layout do código no próprio programa. Portanto, não há duplicação e, portanto, há menor margem para erro ou omissão.
- Evite duplicação baseada em dados/lógica: você pode optar por desenvolver dados melhores ou código baseado em lógica para evitar duplicação. Por exemplo, se você deseja criar um programa de jogo onde o cursor deve se mover em 4 direções para encontrar um ponto para ganhar pontos. Você pode escrever quatro linhas de código para cada direção (Norte, Leste, Sul e Oeste) ou pode usar o comando move(direction) para finalizar o programa em um código de linha. Isto é o que afirma o princípio DRY.
- Evite a duplicação de algoritmos: Isso pode ser facilmente evitado analisando seu programa completo e seu objetivo. Por exemplo, você pode ter um programa para ir ao Hotel A - depois comer, dormir e dançar, depois ir para o Hotel B - depois comer, dormir e dançar, depois ir para o Hotel C... e assim por diante. Você deve ser capaz de ir à atividade do Hotel da seguinte maneira:

```php
public void GoToHotel*(Action activity)
{
    Eat();
    Sleep();
    Dance();
}
```

Isso ajuda na aplicação do princípio DRY ao algoritmo.

Essas etapas ajudam você a evitar a programação de copiar e colar.

O oposto de DRY é WET (escreva tudo duas vezes ou perca o tempo de todos ou gostamos de digitar). O próprio antônimo indica a utilidade do princípio DRY na codificação.

## KISS

O termo Keep it Simple, Stupid (KISS) foi cunhado pelo falecido Kelly Johnson, engenheiro aeronáutico da Lockheed Corporation (agora conhecida como Lockheed Martin). O termo foi usado por Kelly para explicar aos engenheiros o quão importante era manter o projeto de uma aeronave simples. A aeronave teve que ser reparada rapidamente em uma situação de combate e o homem em campo deveria ser capaz de consertar a aeronave com a ajuda de treinamento básico e design simples.

Este conceito é muito importante em software. Os programadores são sempre solicitados a evitar programação complexa ou criar dificuldades na compreensão do código. A chave é programar apenas o necessário, nem menos nem mais.

Como diz o famoso autor e piloto francês **Antoine de Saint-Exupéry**:

*A perfeição é alcançada não quando não há mais nada a acrescentar, mas quando não há mais nada a retirar*.

Algumas maneiras pelas quais um programador pode reduzir a complexidade:

- Os nomes das variáveis ​​em um programa devem servir bem ao seu propósito. Eles devem ser capazes de definir a variável corretamente
- O nome do método também deve estar de acordo com a finalidade para a qual o método é empregado
- Conforme mencionado em um exemplo anterior no princípio DRY, os comentários no método devem ser usados ​​somente quando o seu programa não for capaz de definir o método completamente
- As aulas devem ser projetadas de forma a assumir uma única responsabilidade
- Exclua processos e algoritmos redundantes conforme explicado durante o processo DRY

A seguir estão as vantagens de aplicar o princípio KISS na codificação:

- É vital aplicar o princípio KISS quando você estiver trabalhando na modificação de uma base de código existente. Ajuda a limpar o código e torná-lo mais legível e editável
- A aplicação deste princípio ajuda a manter a continuidade no desenvolvimento de um código quando o programador muda.
- O princípio KISS aumenta a eficiência durante o teste automatizado do código.
- Menos chances de erros durante a codificação.

O exemplo a seguir na linguagem de programação **SWIFT do iOS** dá uma prévia da aplicação do princípio KISS:

Temos um programa para exibir a cor azul se uma lógica fornecida for bem-sucedida, caso contrário, exibirá a cor vermelha.

```swift
if isSuccess {
    label.textColor = .blue
} else {
    label.textColor = .red
}
```

Esta mesma lógica pode ser escrita usando um operador ternário e, portanto, o princípio **KISS** é aplicado aqui:

```swift
label.textColor = isSuccess ? .blue : .red
```

Embora o uso de operadores ternários possa tornar o código complexo em alguns casos, no exemplo acima, eles tornaram o código mais leve, mais fácil de entender e compactado em uma linha em vez de quatro linhas.

Mais algumas maneiras são sugeridas no SWIFT pelas quais você pode remover a complexidade e aplicar o princípio KISS em seu código, são fornecidas abaixo:

- Uso da propriedade computada no lugar do método complexo como alternativa adequada. Propriedades computadas podem ser definidas como um tipo especial de propriedade que não armazena nenhum valor. Em vez disso, eles são usados ​​para calcular um valor com base em outras propriedades.
- Uso de açúcares sintáticos como firstIndex(where: ), fechamentos finais, if-let, etc., para evitar escrever códigos detalhados.
- Uso de funções de ordem superior que recebem uma ou duas outras funções como argumentos e retornam uma função mais simples como resultado. FlatMap, Reduce e Sorted são exemplos de funções de ordem superior que adicionam simplicidade a um código de acordo com o Princípio KISS

## YAGNI (você não vai precisar disso)

Em termos simples, YAGNI como princípio significa a remoção de funcionalidades ou lógicas desnecessárias. O fundador da prática de programação extrema (XP), Ron Jefferies, coloca isso da seguinte maneira:

> *Sempre implemente as coisas quando você realmente precisar delas, nunca quando você apenas prevê que você precisa deles.*

Freqüentemente, os programadores têm a tendência de ignorar o futuro e sobrecarregar o programa com lógica, algoritmos, métodos e códigos desnecessários que nunca serão usados. Alguns fazem isso como uma exigência de negócios e outros com medo de não poder incorporá-lo mais tarde, quando surgir uma determinada situação. Algumas situações em que um programador deve considerar seguir o YAGNI são:

- Se você for solicitado a validar os campos de e-mail e senha por meio de um programa, não há necessidade de adicionar codificação para validar também o campo de nome. Você pode nunca precisar disso.
- Se um programador for solicitado a vincular diferentes bancos de dados de pacientes com câncer de um hospital a uma aplicação de saúde, o desenvolvedor não deverá considerar os hospitais que já estão fechados. Eles podem nunca abrir e o banco de dados de pacientes já deve ter sido transferido para hospitais ativos.
- Alguns programadores podem criar abstrações mesmo quando têm apenas um caso bem definido, antecipando a adição de casos. Então, eles escrevem códigos desnecessários e fazem suposições sobre casos futuros. Isto deve ser evitado.
- Uso da lógica If-else mesmo que a parte "else" sempre seja negativa em todos os cenários de teste encontrados.

Existem alguns motivos pelos quais os programadores optam por violar o YAGNI:

- Falta de compreensão da função ou negócio. Às vezes, os programadores não estão cientes dos cenários de negócios completos. Por exemplo, um programador de software de força de vendas desenvolve lógica acomodativa para oito unidades de negócios diferentes em uma organização, conforme declarado em seu documento de missão. Mas ele/ela pode não estar ciente de que 3 deles podem ter sido fechados. Assim, as exceções e regras consideradas para as unidades fechadas são desperdiçadas.
- Muita visão do futuro. Isso pode ser devido à negligência das equipes de negócios na transmissão de cenários dos quais talvez nunca precisem. É sempre aconselhável planejar cenários para ter ou ter que ter, mas é tolice programar, posso exigir um dia cenários do tipo.
- Em alguns casos em que é muito caro alterar a codificação no futuro ou não é aconselhável perturbar uma lógica já complicada, os desenvolvedores podem optar por violar o princípio YAGNI.

A chave para detectar códigos YAGNI e eliminá-los no próprio estágio de desenvolvimento é uma habilidade que só vem com experiência.

## Articles Reference

1. [Key principles in Software – DRY, KISS, YAGNI, SOLID and other Acronyms](https://geeksprogramming.com/key-principles-in-software-and-acronyms/)
2. [DRY, KISS & YAGNI Principles](https://henriquesd.medium.com/dry-kiss-yagni-principles-1ce09d9c601f) 
3. [How do you balance between following the DRY principle and avoiding over-abstraction in your code?](https://www.linkedin.com/advice/0/how-do-you-balance-between-following-dry-principle)
4. [The Principles of Clean Code: DRY, KISS, and YAGNI](https://www.linkedin.com/pulse/principles-clean-code-dry-kiss-yagni-rajnish-kumar/)