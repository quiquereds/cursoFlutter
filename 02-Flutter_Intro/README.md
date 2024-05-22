# Introducción a Flutter

Flutter representa un *Software Development Kit (SDK)* portable de código abierto. Permite crear aplicaciones compiladas de forma nativa con un solo código base mediante la utilización de widgets.

## Directorios importantes

Al crear un proyecto de Flutter, autómaticamente se crean una serie de directorios y archivos que son importantes para la propia configuración de la aplicación o su compilación. Es importante conocer la finalidad de cada directorio para la realización de configuraciones específicas a la hora de exportar la aplicación o trabajar con API Keys.

### Directorio Dart Tool (.dart_tool)

Es una carpeta utilizada por PUB, un administrador de paquetes para Dart a través del CLI y su fin es para darle seguimiento a nuestros paquetes.

Este directorio rara vez tiene que tocarse.

### Directorio Idea (.idea)

Incluye las configuraciones para trabajar con el IDE IntelliJ IDEA


### Directorio Android

Es una carpeta macro que representa propiamente la aplicación de Android, es una carpeta donde si se suele meter mano para la firma de la aplicación (con el fin de poder exportarla en Google Play), para integrar paquetes, para indicar permisos o accesos de la aplicación, entre muchas otras cosas.

### Directorio de iOS

Al igual que con el directorio de Android, esta carpeta representa el proyecto de iOS y se manipula para lo mismo como sucede con Android (firmas, permisos, paquetes, etc).

### Directorios Web, Linux, macOS y Windows

Como sucede con todas las anrteriores, también son carpetas macro de configuración y código nativo del propio SO y que se manipulan para firmas, permisos, accesos, etc.

### Directorio LIB

Este directorio es el principal de todo proyecto de Flutter, ya que aquí dentro va todo el código propiamente de la aplicación, por ende, también toda la arquitectura de la app, reglas de negocio, código para UI, etc.

### Directorio Test

Es una carpeta donde se generan todos los tests de la aplicación.

### Archivo Git Ignore

Es una archivo que le dice a Git (herramienta de control de versiones) todo lo que se tiene que excluir del control de versiones, o mejor dicho, lo que NO debe subirse al repositorio remoto porque es innecesario o por contener información sensible (ej. secretos de APIs).

### Archivo METADATA

Es un elemento que le da seguimiento a las propiedades del proyecto de Flutter y permite al desarrollador hacer comparaciones y análisis del proyecto.

### Archivo Analysis Options

Es un archivo que puede ser manipulado por el desarrollador para configurar el analyzer si este es muy estricto o no cumple con nuestros estándares.

El analyzer se encarga de la revisión de todo el código de Dart, mostrar advertencias, errores y ocuparse del formato del código.

### Archivos PubSpec

El archivo `pubspec.lock` permite al desarrollador darle seguimiento a las versiones de los paquetes que está utilizando nuestra aplicación. No se configura manualmente.

Por otro lado `pubspec.yaml` si es un archivo muy importante, ya que es de propia configuración de la aplicación, dentro se puede configurar aspectos  como el nombre del proyecto, descripción, versiones, dependencias, dependencias de desarrollo, estilos de diseño y los recursos de la aplicación (imágenes, iconos, fuentes, etc).