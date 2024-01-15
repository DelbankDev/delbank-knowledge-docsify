# Revisando código C#/.NET <!-- {docsify-ignore-all} -->

## C# - Padrões de codificação e convenções de nomenclatura

| Object Name        | Notation   | Length | Plural | Prefix | Suffix | Abbreviation | Char Mask   | Underscores |
|:-------------------|:-----------|-------:|:-------|:-------|:-------|:-------------|:------------|:------------|
| Namespace name     | PascalCase |     32 | Yes    | Yes    | No     | No           | [A-z][0-9]  | No          |
| Class name         | PascalCase |     32 | No     | No     | Yes    | No           | [A-z][0-9]  | No          |
| Constructor name   | PascalCase |     32 | No     | No     | Yes    | No           | [A-z][0-9]  | No          |
| Method name        | PascalCase |     32 | Yes    | No     | No     | No           | [A-z][0-9]  | No          |
| Method arguments   | camelCase  |     32 | Yes    | No     | No     | Yes          | [A-z][0-9]  | No          |
| Local variables    | camelCase  |     20 | Yes    | No     | No     | Yes          | [A-z][0-9]  | No          |
| Constants name     | PascalCase |     20 | No     | No     | No     | No           | [A-z][0-9]  | No          |
| Field name Public  | PascalCase |     20 | Yes    | No     | No     | Yes          | [A-z][0-9]  | No          |
| Field name Private | _camelCase |     20 | Yes    | No     | No     | Yes          | _[A-z][0-9] | Yes         |
| Properties name    | PascalCase |     20 | Yes    | No     | No     | Yes          | [A-z][0-9]  | No          |
| Delegate name      | PascalCase |     32 | No     | No     | Yes    | Yes          | [A-z]       | No          |
| Enum type name     | PascalCase |     32 | Yes    | No     | No     | No           | E[A-z]      | No          |

##### 1. Use PascalCasing para nomes de classes e métodos:

```csharp
public class ClientActivity
{
  public void ClearStatistics()
  {
    //...
  }

  public void CalculateStatistics()
  {
    //...
  }
}
```

***Why: consistent with the Microsoft's .NET Framework and easy to read.***

##### 2. Use camelCasing para argumentos de método e variáveis ​​locais:

```csharp
public class UserLog
{
  // Use maximum 7 parameters in a method.
  public void Add(LogEvent logEvent)
  {
    int itemCount = logEvent.Items.Count;
    // ...
  }
}
```

***Why: consistent with the Microsoft's .NET Framework and easy to read.***

##### 3. Não use notação húngara ou qualquer outra identificação de tipo em identificadores

```csharp
// Correct
int counter;
string name;    
// Avoid
int iCounter;
string strName;
```

***Por que: consistente com o .NET Framework da Microsoft e o IDE do Visual Studio torna a determinação de tipos muito
fácil (através de dicas de ferramentas). Em geral, você deseja evitar indicadores de tipo em qualquer identificador.***

##### 4. Não use Screaming Caps para constantes ou variáveis ​​somente leitura:

```csharp
// Correct
public const string ShippingType = "DropShip";
// Avoid
public const string SHIPPINGTYPE = "DropShip";
```

***Por que: consistente com o .NET Framework da Microsoft. As letras maiúsculas chamam muita atenção.***

##### 5. Use nomes significativos para variáveis. O exemplo a seguir usa seattleCustomers para clientes localizados em Seattle:

```csharp
var seattleCustomers = from customer in customers
  where customer.City == "Seattle" 
  select customer.Name;
```

***Por que: consistente com o .NET Framework da Microsoft e fácil de ler.***

##### 6. Evite usar abreviações. Exceções: abreviações comumente usadas como nomes, como Id, Xml, Ftp, Uri.

```csharp    
// Correct
UserGroup userGroup;
Assignment employeeAssignment;     
// Avoid
UserGroup usrGrp;
Assignment empAssignment; 
// Exceptions
CustomerId customerId;
XmlDocument xmlDocument;
FtpHelper ftpHelper;
UriPart uriPart;
```

***Por que: consistente com o .NET Framework da Microsoft e evita abreviações inconsistentes.***

##### 7. Do use PascalCasing or camelCasing (Depending on the identifier type) for abbreviations 3 characters or more (2 chars are both uppercase when PascalCasing is appropriate or inside the identifier).:

```csharp  
HtmlHelper htmlHelper;
FtpTransfer ftpTransfer, fastFtpTransfer;
UIControl uiControl, nextUIControl;
```

***Why: consistent with the Microsoft's .NET Framework. Caps would grab visually too much attention.***

##### 8. Não use sublinhados em identificadores. Exceção: você pode prefixar campos privados com um sublinhado:

```csharp 
// Correct
public DateTime clientAppointment;
public TimeSpan timeLeft;    
// Avoid
public DateTime client_Appointment;
public TimeSpan time_Left;
// Exception (Class field)
// Always try to use camelCase terminology prefix with underscore
private DateTime _registrationDate;
```

***Porquê: consistente com o .NET Framework da Microsoft e torna o código mais natural de ler (sem 'calúnias'). Também
evita o estresse do sublinhado (incapacidade de ver o sublinhado).***

##### 9. Use nomes de tipos predefinidos (aliases C#) como `int`, `float`, `string` para declarações locais, de parâmetros e de membros e ao acessar os membros estáticos do tipo, como `int.TryParse` ou `string.Join`.

```csharp
// Correct
string firstName;
int lastIndex;
bool isSaved;
string commaSeparatedNames = string.Join(", ", names);
int index = int.Parse(input);
// Avoid
String firstName;
Int32 lastIndex;
Boolean isSaved;
string commaSeparatedNames = String.Join(", ", names);
int index = Int32.Parse(input);
```

***Por que: consistente com o .NET Framework da Microsoft e torna a leitura do código mais natural.***

##### Use o tipo implícito var para declarações de variáveis ​​locais. Exceção: tipos primitivos (int, string, double, etc) utilizam nomes predefinidos.

```csharp 
var stream = File.Create(path);
var customers = new Dictionary();
// Exceptions
int index = 100;
string timeSheet;
bool isCompleted;
```

***Por que: elimina a confusão, especialmente com tipos genéricos complexos. O tipo é facilmente detectado com as dicas
de ferramentas do Visual Studio.***

##### 11. Use substantivos ou frases nominais para nomear uma classe.

```csharp 
public class Employee
{
}

public class BusinessLocation
{
}

public class DocumentCollection
{
}
```

***Por que: consistente com o .NET Framework da Microsoft e fácil de lembrar.***

##### 12. Use prefixo interfaces com a letra I. Os nomes das interfaces são substantivos (frases) ou adjetivos.

```csharp     
public interface IShape
{
}

public interface IShapeCollection
{
}

public interface IGroupable
{
}
```

***Por que: consistente com o .NET Framework da Microsoft.***

##### 13. Nomeie os arquivos de origem de acordo com suas classes principais. Exceção: nomes de arquivos com classes parciais refletem sua origem ou propósito, por exemplo, designer, generated, etc.

```csharp 
// Located in Task.cs
public partial class Task
{
}

// Located in Task.generated.cs
public partial class Task
{
}
```

***Motivo: consistente com as práticas da Microsoft. Os arquivos são classificados em ordem alfabética e as classes
parciais permanecem adjacentes.***

##### 14. Organize os namespaces com uma estrutura claramente definida:

```csharp 
// Examples
namespace Company.Technology.Feature.Subnamespace
{
}

namespace Company.Product.Module.SubModule
{
}

namespace Product.Module.Component
{
}

namespace Product.Layer.Module.Group
{
}
```

***Por que: consistente com o .NET Framework da Microsoft. Mantém uma boa organização de sua base de código.***

##### 15. Alinhe verticalmente as chaves:

```csharp 
// Correct
class Program
{
  static void Main(string[] args)
  {
    //...
  }
}
```

***Porquê: A Microsoft tem um padrão diferente, mas os desenvolvedores preferem esmagadoramente colchetes alinhados
verticalmente.***

##### 16. Declare todas as variáveis ​​de membro no topo de uma classe, com variáveis ​​estáticas em maior topo.

```csharp 
// Correct
public class Account
{
  public static string BankName;
  public static decimal Reserves;      
  public string Number { get; set; }
  public DateTime DateOpened { get; set; }
  public DateTime DateClosed { get; set; }
  public decimal Balance { get; set; }     

  // Constructor
  public Account()
  {
    // ...
  }
}
```

***Por que: prática geralmente aceita que evita a necessidade de procurar declarações de variáveis.***

##### 17. Use nomes singulares para enumerações. Exceção: enumerações de campos de bits.

```csharp 
// Correct
public enum Color
{
  Red,
  Green,
  Blue,
  Yellow,
  Magenta,
  Cyan
} 

// Exception
[Flags]
public enum Dockings
{
  None = 0,
  Top = 1,
  Right = 2, 
  Bottom = 4,
  Left = 8
}
```

***Por que: consistente com o .NET Framework da Microsoft e torna a leitura do código mais natural. Sinalizadores
plurais porque enum pode conter vários valores (usando 'OR' bit a bit).***

##### 18. Não especifique explicitamente um tipo de enum ou valores de enums (exceto campos de bits):

```csharp 
// Don't
public enum Direction : long
{
  North = 1,
  East = 2,
  South = 3,
  West = 4
} 

// Correct
public enum Direction
{
  North,
  East,
  South,
  West
}
```

***Por que: pode criar confusão ao confiar em tipos e valores reais.***

##### 19. Não use um sufixo "Enum" em nomes de tipos de enum, use o prefixo 'E':

```csharp     
// Don't
public enum CoinEnum
{
  Penny,
  Nickel,
  Dime,
  Quarter,
  Dollar
} 

// Correct
public enum ECoin
{
  Penny,
  Nickel,
  Dime,
  Quarter,
  Dollar
}
```

***Por que: Queremos ;).***

##### 20. Não use sufixos "Flag" ou "Sinalizadores" no tipo enum nomes:

```csharp 
// Don't
[Flags]
public enum DockingsFlags
{
  None = 0,
  Top = 1,
  Right = 2, 
  Bottom = 4,
  Left = 8
}

// Correct
[Flags]
public enum Dockings
{
  None = 0,
  Top = 1,
  Right = 2, 
  Bottom = 4,
  Left = 8
}
```

***Por que: consistente com o .NET Framework da Microsoft e consistente com a regra anterior de nenhum indicador de tipo
em identificadores.***

##### 21.Use o sufixo EventArgs na criação das novas classes contendo as informações do evento:

```csharp 
// Correct
public class BarcodeReadEventArgs : System.EventArgs
{
}
```

***Por que: consistente com o .NET da Microsoft Estrutura e fácil de ler.***

##### 22. Nomeie os manipuladores de eventos (delegados usados ​​como tipos de eventos) com o sufixo "EventHandler", conforme mostrado no exemplo a seguir:

```csharp 
public delegate void ReadBarcodeEventHandler(object sender, ReadBarcodeEventArgs e);
```

***Por que: consistente com o .NET Framework da Microsoft e fácil de ler.***

##### 23. Do not create names of parameters in methods (or constructors) which differ only by the register:

```csharp 
// Avoid
private void MyFunction(string name, string Name)
{
  //...
}
```

***Why: consistent with the Microsoft's .NET Framework and easy to read, and also excludes possibility of occurrence of
conflict situations.***

##### 24. Do use two parameters named sender and e in event handlers. The sender parameter represents the object that raised the event. The sender parameter is typically of type object, even if it is possible to employ a more specific type.

```csharp
public void ReadBarcodeEventHandler(object sender, ReadBarcodeEventArgs e)
{
  //...
}
```

***Why: consistent with the Microsoft's .NET Framework and consistent with prior rule of no type indicators in
identifiers.***

##### 25. Use o sufixo Exception na criação das novas classes contendo as informações sobre a exceção:

```csharp 
// Correct
public class BarcodeReadException : System.Exception
{
}
```

***Por que: consistente com o .NET Framework da Microsoft e fácil de ler.***

##### 26. Use o prefixo Any, Is, Have ou palavras-chave semelhantes para o identificador booleano:

```csharp 
// Correct
public static bool IsNullOrEmpty(string value) {
    return (value == null || value.Length == 0);
}
```

***Por que: consistente com o .NET Framework da Microsoft e fácil de ler.***

### Referências <!-- {docsify-ignore} -->

1. [MSDN General Naming Conventions](http://msdn.microsoft.com/en-us/library/ms229045(v=vs.110).aspx)
2. [DoFactory C# Coding Standards and Naming Conventions](http://www.dofactory.com/reference/csharp-coding-standards)
3. [MSDN Naming Guidelines](http://msdn.microsoft.com/en-us/library/xzf533w0%28v=vs.71%29.aspx)
4. [MSDN Framework Design Guidelines](http://msdn.microsoft.com/en-us/library/ms229042.aspx)
5. [Common C# Coding Conventions](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
6. [Github C# Coding Style](https://github.com/dotnet/runtime/blob/main/docs/coding-guidelines/coding-style.md)
