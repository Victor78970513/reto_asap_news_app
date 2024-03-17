# NEWSAPP (ASAP)

# LIBRERIAS A EXPLICAR

## Image_Picker
La librería image_picker ofrece una forma sencilla de seleccionar imágenes de la galería del dispositivo o tomar fotos con la cámara. Decidí utilizar esta librería para permitir a los usuarios de NewsApp adjuntar imágenes a sus artículos locales.

## internet_connection_checker_plus
La librería internet_connection_checker_plus facilita la comprobación del estado de la conexión a Internet del dispositivo. Al integrar esta librería, pude verificar la disponibilidad de conexión a Internet antes de realizar operaciones que requieren acceso a la red, como cargar noticias desde un servidor remoto. Esto mejoró la experiencia del usuario al proporcionar retroalimentación sobre la conectividad de manera proactiva.

## Dartz
Dartz es una librería de Dart que proporciona clases para trabajar con valores opcionales y gestionar errores de manera más elegante. Opté por usar Dartz para mejorar el manejo de errores en mi código y hacerlo más robusto. Además, su uso de tipos de datos funcionales como Either me permitió expresar de manera más clara el flujo de datos y los posibles resultados de mis operaciones asíncronas.

## path_provider
 path_provider fue fundamental para la inicialización de Hive como base de datos local. Esta librería proporciona métodos para obtener rutas de directorios específicos en el sistema de archivos del dispositivo, lo que permitió a NewsApp acceder al directorio de almacenamiento interno y persistir los datos de Hive de manera eficiente.


# BASE DE DATOS LOCAL (HIVE)
 #### Rendimiento: Hive es una base de datos de alto rendimiento, optimizada para dispositivos móviles. Su diseño liviano y eficiente garantiza tiempos de acceso rápidos y una experiencia fluida para los usuarios.

 #### Facilidad de uso: Hive ofrece una API sencilla y fácil de entender, lo que simplifica el proceso   de integración en la aplicación. La sintaxis declarativa y los métodos intuitivos facilitan la manipulación de datos y la gestión de consultas.

 #### Portabilidad y persistencia: Hive almacena los datos localmente en el dispositivo del usuario, lo que garantiza la disponibilidad de la información incluso cuando no hay conexión a Internet. Además, su capacidad para persistir los datos en el sistema de archivos del dispositivo garantiza la integridad de los datos incluso después de reinicios o actualizaciones de la aplicación.