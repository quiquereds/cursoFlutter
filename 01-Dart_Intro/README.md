# Introducción a Dart

Dart es un lenguaje orientado del lado del cliente optimizado para aplicaciones.

- Optimizado para UI
- Permite el Hot Reload

## Características de Dart

- Futures
- Async/Await
- Código non-blocking
- Streams
- Todo código ejecuta una función inicial "main

## Sintáxis importante

- **dynamic:** Comodín de dato (se recomienda evitar  lo más posible su uso)
- **void:** No espera ningún valor de retorno
- **var:** variable
- **string:** Cadena de caracteres
- **final:** Variables que no permiten el cambio de su valor una vez asignado en tiempo de ejecución
- **late final:** Delegación de asignación tardía
- **const:** Variables que no permiten el cambio de su valor en tiempo de construcción/compilación
- **${ }:** Inyección de valores/Interpolación

## Inicialización de variables

### Inicialización de variable sin tipo de dato ímplicito

```dart
var myName = "Quique Rojas";
```
> El compilador de Dart asume que se trata de un String de forma automática.


### Inicialización de variable con tipo de dato ímplicito

```dart
String myName = "Quique Rojas";
```
> [!TIP]
> Se recomienda declarar variables de esta manera para mejorar la legibilidad del código.
>

### Inicialización de variables en tiempo de ejecución

```dart
final String myName = "Quique Rojas";
```
> [!WARNING]
> Estas variables no permiten el cambio de su valor una vez asignado en tiempo de ejecución

Así mismo, es posible crear una delegación de asignación tardía, esto le dice a Dart que dicha variable tendrá un valor al momento de utilizarse, como si fuese una promesa, es responsabilidad del desarrollador asegurar que eso se cumpla.

```dart
// Variable de asignación tardía (no tiene valor aún, pero lo tendrá)
late final String myName;
```

### Inicialización de variables en tiempo de construcción
```dart
const String myName = "Quique Rojas";
```
> [!WARNING]
> Estas variables no permiten el cambio de su valor una vez compilada la aplicación, **su uso aumenta el rendimiento de la aplicación**.

## Interpolación de Strings

Al momento de mostrar datos en pantalla, puede ser útil interpolar en una cadena de texto valores de otras variables, o incluso, acceder a un método en específico de un objeto.

Para interpolar una variable dentro de una cadena:
```dart
String myName = "Quique Rojas"

// Interpolación
print("¡Hola $myName!")

// -> ¡Hola Quique Rojas!
```

Para interpolar un método de un objeto dentro de una cadena:

```dart
String myName = "Quique Rojas"

// Interpolación
print("¡Hola ${myName.toUpperCase()}!")

// -> ¡Hola QUIQUE ROJAS!

```

## Tipos de datos

### Strings

Cadena de caracteres

```dart
String pokemon = "Pikachu";
```

### Enteros

Cualquier número que sea elemento del conjunto numérico de los enteros $\mathbb{Z} = \{...,-3,-2,-1,0,1,2,3, ...\}$

```dart
int health = 24;
// No recibe decimales
```

### Booleanos

Aceptan valores verdero o falso. Sin embargo, Dart siempre está pendiente del *Null Safety*, por lo cual, las variables que se declaren como booleanas pueden ser nulas.

```dart
bool isAlive = true; // True
bool isAlive = false; // False

// Null Safety (?)
bool? isAlive; // Null

```

### Listas

Tipo de dato que representa una secuencia ordenada de valores, donde **el mismo valor puede estar presente más de una vez**.

En Dart, además de poder inicializar una lista sin mencionar implícitamente el tipo de dato interno...

```dart
var abilities = ['latigo', 'pararayos'];
```
> Dart asume que se trata de una lista de strings `List<String>`

Se pueden declarar listas de estas dos formas adicionales:

```dart
List<String> abilities = ['latigo', 'pararayos'];

var abilities = <String>['latigo', 'pararayos'];
```
> [!NOTE]
> El valor entre las llaves menor que (<) y mayor que (>) específican el tipo de dato interno.


### Dynamic

 Dynamic es un tipo de dato especial en Dart, debido a que se le conoce como un dato comodín, ya que permite que se le asigne cualquier valor, sin embargo, y aunque esto pueda sonar cómodo, realmente se convierte en un serio problema si se abusa de él, ya que incluso desde el principio representa un valor nulo.

 ```dart
// Dynamic puede tomar cualquier valor

// Puede ser un string...
dynamic errorMessage = '404 Error'; // -> 404 Error

// Puede ser un booleano...
errorMessage = true; // -> true

// Una lista...
errorMessage = [1, 2, 3, 4, 5, 6]; // -> [1, 2, ...]

// Un set...
errorMessage = {1, 2, 3 ,4 ,5, 6};

// Una función...
errorMessage = () => true;

// O un valor nulo
errorMessage = null
```

Sin embargo, a pesar de que se le asigne por ejemplo, un String, Dart no va a asumir que ahora el tipo de dato es String, sino que se va a quedar en dynamic, lo que puede interferir con las restricciones y la lógica de la aplicación.
 
 > [!WARNING]
 >Es muy importante hacer uso de este tipo de dato cuando realmente es necesario, por ejemplo, cuando se hace una petición a un servidor de internet y este devuelve respuestas de diversos tipos de datos.

### Mapas

Un mapa representa una estructura de dato de tipo contenedor ya que almacena elementos en pares clave-valor. Dentro de sus beneficios destacan: 

- Almacenan claves únicas, es decir, no puede haber una clave repetida.
- La búsqueda de valores es muy rápida.
- Hay un valor para cada clave.

Los mapas son muy útiles a la hora de agrupar información relacionada a un mismo objeto o a la hora de mapear las respuestas de una petición a un servidor:

```dart
  final Map<String, dynamic> pokemon = {
    'name': 'Charmander',
    'hp': 100,
    'isAlive': true,
    'abilities': ['Ember', 'Scratch', 'Growl'],
    'sprites': {
      'front':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      'back':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png'
    }
  };
```
> [!NOTE]
> Para los mapas, resulta útil utilizar el tipo de dato `dynamic` para el valor dentro de las llaves <>, porque como se mencionó, los valores de las claves no siempre tienen el mismo tipo de dato.

#### Extraer valores de los mapas

La manera más sencilla de extraer información de un mapa es utilizando la notación cuadrada haciendo referencia al objeto y a la clave que estamos buscando.

En el mapa anterior, si se quisiese extraer el nombre del pokemon la consulta quedaría:

```dart
print(pokemon['name']) // -> Charmander
```

En una consulta más compleja donde se desee extraer la URL del back sprite del pokemon:

```dart
print(pokemon['sprite']['back']) // -> https://raw.git...
```

### Set
Los sets pueden entenderse como un tipo de lista, pero la principal diferencia es que dentro de este tipo de datos, los valores son únicos, es decir, no puede incluir ningún elemento repetido.

```dart
var Set numbers = {1,2,3,4,5,6,7,8} 
// No hay elementos repetidos
```

> [!TIP]
> Los sets pueden resultar útiles a la hora de limpiar listas con valores duplicados.

## Funciones

Las funciones y los parámetros pueden entenderse como las distintas formas que existen para enviar y utilizar valores.

```dart
// Función principal
void main() {
  // Llamamos a la función de saludo
  print(greatEveryone()); // -> ¡Hola a todos!
}

// Función de saludo
String greatEveryone() {
  // Devolvemos el saludo
  return '¡Hola a todos!'
}
```
> [!TIP]
> Dart también maneja los *lambda functions* o funciones de flecha, donde, si no hay cuerpo de la función, en lugar de usar llaves, se puede usar la flecha gorda `=>` seguida del retorno.

### Funciones con parámetros

Las funciones se pueden crear recibiendo parámetros, o mejor dicho, información útil que ayuden al manejo o cálculo de los datos, como lo siguiente:

```dart
// Función principal
void main(){
  // Enviamos a(20) y b(10) a la función
  addTwoNumbers(20,10); // -> 30
}

/// Función de suma de dos números
/// recibimos a y b de parámetros
int addTwoNumbers(int a, int b){
  // Devolvemos la suma de a + b
  return a + b;
}
```

### Funciones con parámetros opcionales

Se pueden crear funciones que tengan parámetros opcionales, para ello, el parámetro que se desea poner opcional se envuelve en corchetes y  se le establece un valor inicial.

```dart
// Función principal
void main(){
  // Enviamos solo a
  addTwoNumbers(20); // -> 20 + 0(b nulo) = 30
  // Enviamos a y b
  addTwoNumbers(20, 10) // 20 + 10 = 30
}

int addTwoNumbers(int a, [int b = 0]) {
  /// Si b es nulo, la operación sería a + 0, en
  /// cambio, si b tiene valor se hace válida
  /// la operación a + b.
  return a + b;
}
```

### Funciones con parámetros con nombre

Hasta el momento, se han utilizado parámetros obligatorios y posicionales, sin embargo, Dart ofrece una manera especial de ponerle nombre a los parámetros que se envían para mejorar la comprensión de las funciones y para ayudar a asegurar que se pasen los parámetros correctos.

Para ello, se colocan entre llaves y dentro del paréntesis los parámetros que recibe una función, de la siguiente manera:

```dart
// Función principal
void main(){
  // Llamamos a la función de saludo
  greetEveyone(name: 'Quique Rojas'); // -> Hola Quique Rojas
}

/// La palabra reservada ´required´ obliga a que siempre se debe pasar ese parámetro
String greetEveryone({required String name, String message = 'Hola'}) {
  return '$message $name';
}
```
> [!NOTE]
> Al llamar a la función, también se puede sobreescribir `message`, representa un tipo de parámetro opcional (debido a que se le asigna un valor por defecto), pero se puede pasar otro mensaje al llamar a la función.

## Clases

Las clases son como un molde para hacer galletas, representan un concepto sumamente vinculado a la Programación Orientada a Objetos, y que ayudan, a crear tantos objetos o galletas a partir de este molde dentro de un programa.

Dentro de una clase se encuentran atributos (propiedades) y métodos (funciones), así como otros elementos de ayuda como constructores, getters y setters que ayudan a obtener información, inicializar un objeto o modificar un objeto de manera segura.

Un constructor hace referencia a una función encargada de inicializar objetos.

```dart
void main() {
  // Creamos un objeto a partir del molde Hero
  final Hero wolverine = Hero(name: 'Logan', power: 'Regeneración');
  print(wolverine);
  // Accedemos a las propiedades
  print(wolverine.name); // -> Logan
  print(wolverine.power); // -> Regeneración
}

class Hero {
  // Atributos
  String name;
  String power;

  // Inicialización de clase (constructor)
  Hero({required this.name, required this.power});
}

```
> [!TIP]
> Si se desea tener un atributo opcional, dentro del constructor se elimina la palabra `required` y se asigna un valor inicial al atributo que será opcional.
>

### @override

La anotación *override* ayuda a sobreescribir el comportamiento de métodos, un ejemplo muy claro de su utilidad es cuando se desea mostrar las propiedades de un objeto sin la necesidad de acceder directamente a cada uno de ellos, ya que al utilizar el método `toString`, únicamente devolverá una instancia del objeto sin revelar su información.

```dart
// Sobreescribimos el comportamiento del método toString
@override
String toString() {
  return '$name - $power';
}
```

### Constructores con nombre

En Dart se pueden crear constructores por nombre que ayuden a crear o inicializar un objeto de diversas formas, por ejemplo, si se hace una petición HTTP, comúnmente se nos regresa la respuesta en forma de JSON el cual no podemos utilizar así nada más para crear un objeto, entonces, es necesario tener un constructor que extraiga la información que queremos del JSON y la pase a objeto.

```dart
// Ejemplo de respuesta HTTP
  final Map<String, dynamic> rawJson = {
    'name': 'Thor',
    'power': 'Truenos',
    'isAlive': true,
  };
```
Para pasar este tipo de dato a un objeto, debemos contar con un constructor dentro de la clase que lo pase a objeto:

```dart
// Constructor por nombre
  Hero.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'No name found',
        power = json['power'] ?? 'No power found',
        isAlive = json['isAlive'] ?? 'Not found';
```

Con esto, dentro de nuestra función principal podremos pasar `rawJson` a un objeto `Hero` utilizando el constructor `Hero.fromJson`:

```dart
// Creamos un objeto a partir del JSON simulado
final Hero thor = Hero.fromJson(rawJson);
// -> Thor, Truenos, isAlive: Siuu 
```

