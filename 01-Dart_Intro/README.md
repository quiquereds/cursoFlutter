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

### Inicialización de variable son tipo de dato ímplicito

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