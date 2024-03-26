# Introdução ao Spring Boot

O **Spring Boot** é um framework para desenvolvimento de aplicações [Java](/desenvolvimento/roadmap-java/) que conta com
um vasto ecossistema e visa simplificar o processo de criação de soluções robustas e altamente escaláveis. Ele foi
criado como uma extensão do [Spring Framework](https://spring.io/projects/spring-framework), para facilitar a
configuração e o desenvolvimento de aplicações Java, fornecendo um conjunto de recursos e funcionalidades prontos para
uso.

Essa documentação irá abordar os principais conceitos que alguém que está começando a trabalhar com o Spring Boot deve
conhecer, tendo em mente o que é utilizando nas aplicações Java do **Delbank**. Para um guia mais detalhado e com uma
sequência de aprendizado bem definida, recomendamos o seguinte
roadmap [Spring Boot Developer](https://roadmap.sh/spring-boot), do site [roadmap.sh](https://roadmap.sh/).

## Por que usar o Spring Boot?

No passado, com o amplo uso do Spring Framework e o crescimento do ecossistema Spring, os desenvolvedores precisavam
configurar manualmente várias partes do ambiente de execução, incluindo servidores de aplicação e uma variedade de
dependências. O Spring Boot foi projetado para eliminar essa complexidade, fornecendo uma abordagem de _"convenção ao
invés configuração"_, que permite aos desenvolvedores se concentrarem mais na lógica de negócios e menos na configuração
técnica. Daí o termo "Boot", para passar a noção de uma inicialização rápida.

O desenvolvedor ainda pode customizar as configurações da aplicação à vontade, caso queira, mas o conjunto de
configurações padrão do Spring Boot é suficiente para a maioria dos casos, o que acelera o desenvolvimento e reduz a
curva de aprendizado.

O Spring Boot não se limita apenas ao desenvolvimento em Java, mas também oferece suporte para outras linguagens
baseadas na JVM, como _Kotlin_ e _Groovy_. Além disso, proporciona flexibilidade no gerenciamento de dependências,
permitindo que os desenvolvedores escolham entre _Maven_ e _Gradle_ para suas configurações de projeto.

Ainda pensando na agilidade para começar um novo projeto, os desenvolvedores podem utilizar
o [Spring Initializr](https://start.spring.io/), um site oficial que gera o boilerplate inicial de projetos Spring Boot,
fornecendo modelos de projeto prontos para uso e configurações personalizáveis.

Além dessas características, podemos citar também:

- **Facilidade de Configuração:** Quando há a necessidade de alguma configuração adicional, o Spring Boot a simplifica
  por
meio de anotações e autoconfiguração. Ele detecta automaticamente a maioria das configurações necessárias com base nas
dependências incluídas no projeto.

- **Ecossistema Rico:** O Spring Boot faz parte do ecossistema Spring, que oferece uma ampla gama de módulos e
  ferramentas
para diversas necessidades de desenvolvimento, como web, dados, segurança, integração e muito mais.

- **Versatilidade:** O Spring Boot é agnóstico em relação à camada de apresentação, permitindo que você desenvolva
aplicações web, RESTful, workers, ou até mesmo batch e integrações.

- **Comunidade Ativa:** Assim como outras tecnologias populares, o Spring Boot possui uma comunidade ativa de
desenvolvedores, o que significa que há ampla documentação, suporte e recursos disponíveis online.

Em resumo, o Spring Boot é uma escolha popular para o desenvolvimento de aplicações Java devido à sua abordagem de
configuração mínima, produtividade aprimorada e integração perfeita com o ecossistema Spring.

## O Ecossistema Spring

O ecossistema do Spring oferece uma variedade de frameworks que complementam o Spring Boot, fornecendo funcionalidades
adicionais para diferentes aspectos do desenvolvimento de aplicações. Alguns dos principais frameworks desse
ecossistema incluem:

- **Spring Core**: O Spring Core é o coração do Spring Framework, fornecendo funcionalidades fundamentais como injeção
  de dependências e gerenciamento de ciclo de vida de objetos.

- **Spring Web**: O Spring Web é um framework para desenvolvimento de aplicações web baseados no padrão MVC
  (Model-View-Controller), permitindo a construção de interfaces web robustas e escaláveis.

- **Spring Data JPA**: O Spring Data JPA é uma abstração de acesso a dados que simplifica o desenvolvimento de
  aplicações que utilizam o JPA (Java Persistence API) para interagir com bancos de dados relacionais. Seguindo a
  filosofia de configuração mínima, o ORM padrão do Spring Boot é o _Hibernate ORM_. Além do JPA, o Spring Data oferece
  também o Spring Data MongoDB, Spring Data Redis, entre outros.

- **Spring Data JDBC**: O Spring Data JDBC é uma alternativa ao JPA que oferece um modelo de programação simples e
  eficiente para acessar bancos de dados relacionais usando JDBC (Java Database Connectivity), sem a complexidade
  intrínseca de um ORM. Em termos de usabilidade, o Spring Data JDBC lembra bastante
  o [Dapper](https://github.com/DapperLib/Dapper), do .NET.

- **Spring AMQP**: O Spring AMQP é um framework para integração com sistemas de mensageria baseados em AMQP (Advanced
  Message Queuing Protocol), como o RabbitMQ, permitindo a comunicação assíncrona entre aplicações.

- **Spring Security**: O Spring Security é um framework de segurança que fornece recursos abrangentes para autenticação,
  autorização e proteção contra vulnerabilidades de segurança em aplicações Spring.

Esses são apenas alguns dos principais frameworks do ecossistema do Spring, cada um projetado para atender a diferentes
necessidades de desenvolvimento e oferecer soluções robustas e escaláveis para os desenvolvedores.

## Injeção de Dependências

No ecossistema do Spring, um **Bean** é um objeto gerenciado pelo **container Spring**, responsável por criar,
configurar e injetar esses objetos em outras partes da aplicação. A injeção de dependências é um dos princípios
fundamentais do Spring, sendo realizada pelo container Spring automaticamente.

A injeção de dependências permite que os Beans dependam uns dos outros de forma desacoplada, promovendo uma arquitetura
flexível e de fácil manutenção. Isso significa que as classes não precisam instanciar explicitamente suas dependências;
em vez disso, elas são fornecidas pelo container Spring durante a inicialização da aplicação.

Os Beans são geralmente definidos e configurados por meio de anotações, XML ou classes de configuração Java. As
anotações mais comuns usadas para definir Beans
incluem `@Component`, `@Service`, `@Repository`, `@RestController`, `@Configuration` e `@Bean`. Cada uma dessas
anotações tem um propósito específico e permite ao desenvolvedor definir Beans de maneira clara e concisa.

A injeção de dependências no Spring pode ser feita por meio de construtores, métodos setters ou diretamente em atributos
de um objeto. O Spring fornece várias maneiras de configurar a injeção de dependências, como `@Autowired`, `@Qualifier`
e `@Resource`.

Em resumo, os Beans no Spring são objetos gerenciados pelo container Spring, e a injeção de dependências é um mecanismo
que permite que esses objetos dependam uns dos outros de forma desacoplada, promovendo uma arquitetura flexível e
modular.

## Os Proxies do Spring

O Spring faz uso extensivo de _proxies_ para implementar funcionalidades como injeção de dependências, transações de
bancos de dados, cacheamento, controle de acesso, e muitos outros. Os proxies são objetos que atuam como intermediários
entre o código cliente e o objeto alvo, permitindo que o Spring adicione comportamentos adicionais aos objetos alvo sem
modificá-los diretamente. Ou seja, entre a chamada de um método, por exemplo, e a execução do método em si, o Spring
pode adicionar diversos comportamentos intermediários.

Métodos anotados com `@Transactional`, `@Cacheable`, `@Async`, `@Scheduled`, entre outros, são exemplos de
funcionalidades implementadas por meio de proxies no Spring. Esses proxies interceptam as chamadas aos métodos anotados
e executam o comportamento adicional antes ou depois da execução do método alvo.

**IMPORTANTE:** Para que esses proxies funcionem corretamente, o Spring Boot, em sua configuração padrão, requer que o
método anotado seja chamado de fora da classe que o contém. Caso contrário, o Spring não conseguirá interceptar a
chamada e aplicar o comportamento adicional.

Embora os proxies sejam poderosos e ofereçam uma maneira elegante de estender o comportamento dos objetos alvo, eles
podem dificultar a depuração em certos cenários. Isso ocorre porque as camadas adicionais de abstração entre o
código cliente e o objeto alvo podem dificultar o rastreio do fluxo de execução do programa durante a depuração.

## Spring Boot na Prática

Os tópicos a seguir darão exemplos de como implementar alguns dos principais componentes de uma aplicação Spring Boot,
com trechos de código e explicações detalhadas.

### Configurações

As classes de configuração no Spring Boot são usadas para definir Beans e configurar o comportamento da aplicação desde
sua inicialização. Elas são anotadas com `@Configuration` e podem conter métodos anotados com `@Bean` para definir Beans
específicos, que serão adicionados ao container Spring. Através da injeção de dependências, esses beans podem tanto ser
utilizados diretamente pelo desenvolvedor, quanto por alguma biblioteca da aplicação.

No exemplo a seguir, a classe `BeanValidatorConfig` define um Bean do tipo `LocaleResolver`, para que as mensagens
de validação geradas automaticamente pelo Java, nas respostas de requisições HTTP, sejam exibidas em português do
Brasil.

```java
@Configuration
public class BeanValidatorConfig {

    @Bean
    public LocaleResolver localeResolver() {
        return new FixedLocaleResolver(new Locale("pt", "BR"));
    }

}
```

### Controllers

Os _Rest Controllers_ são classes responsáveis por receber requisições HTTP e retornar respostas adequadas. Eles são
anotados com `@RestController` e seus métodos são anotados com `@GetMapping`, `@PostMapping`, `@PutMapping` ou
`@DeleteMapping`, dependendo do tipo de requisição que desejam tratar.

No exemplo a seguir, a classe `UserController` é um Rest Controller que recebe requisições para buscar usuários por ID e
retornar uma resposta com o usuário encontrado.

```java
@RestController
@RequestMapping("/users")
public class UserController {

    private UserService userService;
    
    publis UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public User getUserById(@PathVariable Long id) {
        var user = userService.getUserById(id);
        return user;
    }

}
```

Perceba que nesse exemplo, a classe `UserController` recebe um objeto do tipo `UserService` no construtor, que é
injetado automaticamente pelo Spring. Isso é possível porque a classe `UserService` é um Bean.

### Services

As classes de serviço (_Service_) são responsáveis por implementar a lógica de negócios da aplicação. Elas são anotadas
com `@Service` e podem conter métodos que realizam operações específicas, como buscar usuários no banco de dados, criar
novos registros, atualizar informações, entre outras.

No exemplo a seguir, a classe `UserService` é um serviço que contém a lógica para buscar usuários no banco de dados.

```java
@Service
public class UserService {

    private UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUserById(Long id) {
        return userRepository.findById(id)
            .orElseThrow(() -> new UserNotFoundException("User not found"));
    }

}
```

### Repositories

Os repositórios (_Repositories_) são interfaces que estendem a interface `JpaRepository` do Spring Data JPA. Eles são
responsáveis por realizar operações de leitura e escrita no banco de dados, como buscar registros, salvar novos
registros, atualizar informações, entre outras.

No exemplo a seguir, a interface `UserRepository` é um repositório que estende a interface `JpaRepository` e define
métodos para buscar usuários no banco de dados.

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findById(Long id);

}
```

Como o Spring Data JPA fornece implementações padrão para os métodos definidos na interface `JpaRepository`, não é
necessário implementar esses métodos manualmente. O Spring Boot gera automaticamente as consultas SQL apropriadas com
base nos nomes dos métodos definidos na interface.

### Entities

As entidades (_Entities_) são classes que representam as tabelas do banco de dados. Elas são anotadas com `@Entity` e
podem conter atributos que representam as colunas da tabela, bem como métodos para acessar e modificar esses atributos.

No exemplo a seguir, a classe `User` é uma entidade que representa a tabela de usuários no banco de dados.

```java
@Entity
@Table(name = "users", schema = "dbo")
public class User {

    @Id
    private UUID id;
    
    private String name;

    @Column(name = "emailAddress")
    private String email;

    // Getters e Setters

}
```

A anotação `@Id` é usada para indicar a chave primária da entidade, enquanto a anotação `@Column` é usada para mapear o
atributo para uma coluna específica no banco de dados. Se o nome do atributo for o mesmo que o nome da coluna, não é
necessário usar a anotação `@Column`.

### Scheduled Tasks

Implementar tarefas agendadas (_Scheduled Tasks_, ou _jobs_) com o Spring Boot é bem mais simples do que em frameworks
de outras linguagens. Basta criar um método e anotá-lo com `@Scheduled`. Esses jobs podem ser configurados para executar
em horários específicos, como a cada minuto, a cada hora, ou em um horário específico do dia. Isso é feito por meio de
uma expressão cron.

No exemplo a seguir, o método `syncDailyReports` da classe `ReportService` é executado todos os dias às 8h da manhã.

```java
@Component
public class ReportService {

    @Scheduled(cron = "0 0 8 * * *")
    @SchedulerLock(name = "syncDailyReports")
    public void syncDailyReports() {
        LockAssert.assertLocked();
        // Lógica para sincronizar relatórios diários
    }
}
```

Em um ambiente distribuído, pode ser importante garantir que um job seja executado por somente uma instância do serviço
por vez. Para isso, é possível utilizar a anotação `@SchedulerLock` e o comando `LockAssert.assertLocked()`, ambos da
biblioteca [ShedLock](https://github.com/lukas-krecan/ShedLock), que registra travas temporárias em um banco de dados
compartilhado por todas as instâncias a aplicação, para evitar problemas de concorrência.

### RabbitMQ

Implementar um consumidor de filas do RabbitMQ com o Spring Boot é tão simples quanto implementar um job. Basta criar
um método e anotá-lo com `@RabbitListener`, passando a lista de filas que ele deve escutar. Uma vez configurado, o
Spring Boot se encarregará de fazer a conversão automática das mensagens recebidas para o tipo de objeto esperado, bem
como a emissão do ACK ou NACK, ao fim do processamento.

No exemplo a seguir, o método `processMessage` da classe `MessageConsumer` é um consumidor de mensagens da
fila `orders`.

```java
@Component
public class MessageConsumer {

    @RabbitListener(queues = "orders")
    public void processMessage(Order order) {
        // Lógica para processar a mensagem
    }

}
```

### Testes

O Spring Boot oferece suporte para testes unitários e de integração, permitindo que os desenvolvedores testem suas
aplicações de forma eficaz e confiável. Os testes podem ser escritos usando as bibliotecas JUnit e Mockito, e o Spring
Boot fornece anotações específicas para simplificar a configuração dos testes.

No exemplo a seguir, a classe `UserServiceTest` é um teste unitário para a classe `UserService`, que verifica se o
método
`getUserById` retorna um usuário válido quando o ID é válido.

```java
@SpringBootTest
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @MockBean
    private UserRepository userRepository;

    @Test
    public void testGetUserById() {
        var mock = new User();
        mock.setId(69);
        mock.setName("John Doe");
        mock.setEmail("john.doe@delbank.com.br");
        
        when(userRepository.findById(69)).thenReturn(Optional.of(mock));
        
        var result = userService.getUserById(1L);
        
        assertEquals(mock, result);
        verify(userRepository, times(1)).findById(1L);
    }
}
```

Nesse exemplo, a anotação `@SpringBootTest` é usada para inicializar uma versão simplificada do contexto da aplicação
durante a execução do teste. A anotação `@MockBean` é usada para criar um mock do repositório `UserRepository`, que
será injetado no serviço `UserService` durante o teste.

## Conclusão

O Spring Boot é uma ferramenta poderosa e versátil para o desenvolvimento de aplicações Java, oferecendo um conjunto
abrangente de recursos e funcionalidades prontos para uso. Com sua abordagem de configuração mínima e integração
perfeita com o ecossistema Spring, o Spring Boot permite que os desenvolvedores criem aplicações robustas e escaláveis
de forma rápida e eficiente.

Este guia é apenas uma introdução a esse vasto ecossistema, mas há muito mais a ser explorado. Para conhecer outras
soluções do Spring, basta visitar a lista de projetos no [site oficial](https://spring.io/projects). E como mencionado
anteriormente, o roadmap [Spring Boot Developer](https://roadmap.sh/spring-boot) é um bom ponto de partida para quem
deseja se aprofundar nessa tecnologia.
