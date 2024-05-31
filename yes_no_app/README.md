# Consejos de Flutter

### Mostrar widget mientras se carga una imagen
En el widget `Image.network` existe una propiedad para mostrar un widget mientras la imagen se carga, esto con el objeto de no mostrar un espacio en blanco por una n cantidad de segundos y hacer una interfaz mucho más estética. 

```dart
Image.network(
    'https://yesno.wtf/assets/no/23-5fe6c1ca6c78e7bf9a7cf43e406fb8db.gif',

    /// Hacemos que las dimensiones de la imagen sean proporcionales y no
    /// ocupen todo el ancho y alto de la pantalla
    width: size.width * 0.7,
    height: 150,
    // Ajustamos la imagen al ClipRRect
    fit: BoxFit.cover,
    // Mostrar widget mientras se carga la imágen
    loadingBuilder: (context, child, loadingProgress) {
        /// Creamos un bloque if para determinar si la imagen ya cargó
        /// y determinar qué devolver
        if (loadingProgress == null) {
            // Si el contenido ya cargó, se regresa el child
            return child;
        }
        // Si no ha cargado, se regresa un container
        return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Te están enviando una imagen'),
        );
    },
),
```

# Gestor de Estado

En Flutter, el BuildContext proporciona información sobre cómo está nuestra aplicación, cuál es la estructura del árbol de widgets y el estado (o no) de los widgets. Recordemos que el único widget que tiene estado, es el Stateful Widget y es el que puede decirle a Dart que se vuelva a renderizar para mostrar algún cambio en el UI de la aplicación.

Cuando uno de estos widgets requiere conocer información de sus padres en el árbol de widgets, o mejor dicho, para que exista una comunicación en el árbol, estos tienen que recorrer todo el árbol de widgets para recabar la información que necesita, creando un grave problema de ineficiencia.

Es aquí cuando entran los gestores de estado, los cuales nos permiten manejar de forma centralizada todos los datos que se requieren saber en una estructura de árbol de widgets. 

