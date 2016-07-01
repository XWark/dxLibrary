dxLibrary
=========

Descripción: Librería dx para Multi Thef Auto  - San Andreas:
  
Funciones
=========

element dxDrawButton(string  text = “”, float posX = 0, float posY = 0, float sizeX = 100,  float sizeY = 50, color color = tocolor(255,255,255,255), font = "default", float textScale =  1, image image = false)

Argumentos
==========

text: Crea el texto inserto en el boton
posX: Posición absoluta en el eje x
posY: Pocision absoluta en el eje y
sizeX: Tamaño del boton en el eje x
sizeY: Tamaño del boton en el eje y
color: Color del boton, del tipo tocolor(red,blue,green,alpha)
Font: Fuente del texto tipo dx.
"default": Tahoma
"default -bold": Tahoma 
Bold"clear": Verdana
"arial": Anal
"sans": Microsoft Sans Serif
"pricedown": Pricedown (GTA's theme text)
"bankgothic": Bank Gothic Medium
"diploma": Diploma Regular
"beckett": Beckett Regular
textScale: Tamaho del texto.
image: elemento tipo imagen, el cual 	debe ser declarado en el meta.xml
  
OPP
===

bool element.isCursorInside()
-Retorna true si el cursor esta sobre el botón
  
bool element.isClicked()
-Retorna true si el botón es clickeado

bool element.isVisible()
-Retorna true si el botón está activo y visible.
  
void element.setVisible(bool value)
-Asigna un valor para hacer el botón activo y visible.(por defecto se crea visible)
