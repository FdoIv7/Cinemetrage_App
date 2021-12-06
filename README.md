# Cinemetrage_App

Aplicación para prueba técnica.

# Capas de la aplicación

La aplicación sigue la arquitectura MVVM:

- El grupo **View** está compuesto por las clases de los ViewControllers, de los cuales existen por el momento **HomeViewController** y **MovieDetailViewController**. Ambos son parte de un Navigation Controller.
  - El grupo **View** también cuenta con un subgrupo **CollectionViewCells** en el cual se encuentran los archivos para la creación de celdas para los collectionViews personalizadas.
  - También se encuentran en este grupo las vistas del **Storyboard** y los archivos xib

- En el grupo **API** econtramos el archivo **MoviesAPIService**, el cual adpota el protocolo **MoviesProtocol** para así poder hacer los llamados del API
- El grupo **ViewModels** consta de los respectivos ViewModels, en este caso **MovieViewModel**,
- También contamos con el grupo **Model** en donde encontramos las siguientes estructuras, las cuales son estructuras formadas con primitive types para la creación de nuestro modelo con base la respuesta del API:
  - Estas estructuras son:
    - **MoviesProtocol**
    - **Movie** 
    - **Movie+Stub**
  
- La interacción entre los **Model** y las **Views** se da por medio de los **ViewModels**, creando instancias del **ViewModel** que se necesite en el **ViewController** necesario. Implementamos **MovieAPIService** en nuestro **MovieViewModel** para poder obtener la información de los servicios REST.
- También contamos con el grupo **Resources**, donde hay algunos JSONs para pruebas referentes al cache **(Por Implementar)**

# Resposabilidades de las Clases

- **MoviesAPIService**: Clase encargada de hacer los llamados al API. Implementa el protocolo **MovieProtocol**
- **ImageWrapper**: Clase encargada de hacer el cache de las imagenes **(Por implementar)**
- **PosterCollectionViewCell**: Clase encargada de actualizar la UI de de las **PosterCollectionViewCell** gracias a la respuesta que obtenemos del servicio REST
- **HomeViewController**: Nuestro ViewController principal,  en este mostramos las películas por categoría a los usuarios, creamos una instancia de **MovieViewModel** para poder acceder a los métodos del consumo de los servicios REST. Asignamos las respuestas decodificadas de a arreglos de **Movies** y las mostramos en su respectiva CollectionView
- **MovieDetailViewController**: Clase encargada de mostrar el detalle de la película que pasamos desde el **HomeViewController** por medio del método prepareForSegue. En esta clase nos encargamos de actualizar la imagen de backDrop de la película seleccionada, así como mostrar una breve descripción de la misma. 
- **MoviesProtocol**: Protocolo que designa los métodos para consumir los servicios REST
- **Movie**: Estructura básica para poder crear nuestros propios objetos Movie. Sus propiedades fueron declaradas con base a la respuesta del servicio REST y cuentan con sus respectivas CodingKeys para su decodificación
  - También encontramos la estructura de **MovieResponse** la cual consta de un arreglo de **Movie** para obtener el valor de la key **results**
- **Movie+Stub**: Clase encargada de leer archivos localmente para pruebas offline, cache **(Por Implementar)**

# Principio de resposabilidad única

Este principio indica que cada clase debe tener una responsabilidad y un solo propósito. Esto significa que cada clase tiene un trabajo, entonces, solo tiene una razón para ser cambiada. No queremos que varios objectos sepan de otros comporatmientos que no tienen nada que ver estos. Por lo que delegamos una tarea a cada una de estas. De esta manera, los errores son más fáciles de encontrar.

# “Buen” código o código limpio

1. Código que sea fácil de leer y comprender, nombrando correctamente variables, constantes y funciones. Para que cualquier persona que llegue a trabajar con el, pueda entenderlo, mantenerlo y mejorarlo, muchas veces no seremos nosotros mismos quienes trabajaran con ese código meses después de haberlo creado, e inclusive si fueramos nosotros, tener todo en orden, hará mucho más fácil retomarlo.
2. Un buen código, tiene un buen "layout", tiene tener un orden desde las variables locales hasta clases y extensiones de estas. Debe tener una buena arquitectura, unos buenas y ordenadas bases
3. El buen código no busca hacer todo desde cero, siempre buscará maneras de optimizar, desde métodos totalmente reusables hasta implementar librerías de terceros. Trabajar inteligentemente, si algo ya existe, hay que reusarlo.
4. El código bien hecho debe ser reutilizable y modular, haciendo usos de generic types y fuciones genéricas podemos crear una sola función que cumpla el mismo propósito con distintos objetos.
5. Tener un buen diseño, existe muchos patrones de diseño, ya probados por miles de desarrolladores y funcionan, cuando se elige uno, hay que respetaarlo.
6. El buen código también creo debe utilizar todos los métodos y funciones que nos facilitan los environments, si ya existe alguna función, no hay necesidad de crear la nuestra.
7. El código bien diseñado es totalmente fácil de expandir, nunca sabemos si querremos más funcionalidad en el futuro, así que tenemos que diseñarlo bien desde el inicio, lo que me lleva mi último punto de vista.
8. El buen "coder", es bueno en lápiz y papel, diseñar todo primero y saber como va a funcionar, que se necesitara y que problemas pueden existir antes de comenzar a escribir código.
