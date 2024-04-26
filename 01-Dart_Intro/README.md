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

- dynamic: Comodín de dato (se recomienda evitar  lo más posible su uso)
- void: No espera ningún valor de retorno
- var: variable
- string: Cadena de caracteres
- final: Variables que no permiten el cambio de su valor una vez asignado en tiempo de ejecución
- late final: Delegación de asignación tardía
- const: Variables que no permiten el cambio de su valor en tiempo de construcción/compilación
- ${ } : Inyección de valores/Interpolación

## Inicialización de variables

### Inicialización de variable son tipo de dato ímplicito

```dart
var myName = "Quique Rojas"
```
> El compilador de Dart asume que se trata de un String de forma automática.


### Inicialización de variable con tipo de dato ímplicito

```dart
String myName = "Quique Rojas"
```
> Se recomienda declarar variables de esta manera para mejorar la legibilidad del código.

### Inicialización de variables en tiempo de ejecución

```dart
final String myName = "Quique Rojas"
```
> .[!TIP].
> Estas variables no permiten el cambio de su valor una vez asignado en tiempo de ejecución