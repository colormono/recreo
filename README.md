# Figus

![Figus Render v1](./docs/02_Figus_v01.jpg)

**Dibujos con ploter conducido por código. Papel y Tinta.**

Colección de imágenes generadas mediante distintos algoritmos y materializadas con un plotter de corte y dibujo. A modo “álbum de figuritas” están organizadas según la curva de complejidad de sistemas de arte generativo propuesta en el paper “What is generative art?” (Galanter, 2003). Una recopilación de ejercicios que recorren la transición del orden al caos con algoritmos propios y reinterpretaciones de referentes como Sol Lewitt, Daniel Shiffman, Marius Watz y Golan Levin. A la selección que es montada sobre la pared la acompaña un álbum con 12 variaciones a escala para cada uno de estos “equipos”.

- Symmetry and Tiling: Sol Lewitt, Islamic Art
- L-Systems and Fractals: Marius Watz
- Genetic Systems and A-Life: Daniel Shiffman
- Chaotic Systems: Robert Hodgin, Golan Levin
- Randomization: Frieder Nake, Georg Nees, Karl Otto.

Generative math: Dealunay, Voronoi

---

## Indice

- [Instrucciones](#instrucciones)
- [Flujo de trabajo](#flujo-de-trabajo)
- [Hardware](#hardware)
- [Código](#código)
  - [Drivers](#drivers)
  - [Librerías](#librerías)
  - [Desarrollo](#desarrollo)
  - [Ejemplos](#ejemplos)
  - [API](#api)
- [Enlaces útiles](#enlaces-útiles)

---

## Instrucciones

Como montar la obra

### Desarrollo

```
# Install the CLI tool globally
npm install canvas-sketch-cli -g

# Make a new folder to hold all your generative sketches
mkdir my-sketches

# Move into that folder
cd my-sketches

# Scaffold a new 'sketch.js' file and open the browser
canvas-sketch sketch.js --new --open
```

While in the browser, hit `Cmd + S` or `Ctrl + S` to export a high-resolution PNG of your artwork to your `~/Downloads` folder.

Some other commands to try:

```
# Start the tool on an existing file and change PNG export folder
canvas-sketch src/foobar.js --output=./tmp/

# Start a new sketch from the Three.js template
canvas-sketch --new --template=three --open

# Build your sketch to a sharable HTML + JS website
canvas-sketch src/foobar.js --build

# Develop with "Hot Reloading" instead of full page reload
canvas-sketch src/foobar.js --hot
```

For more features and details, see the [canvas-sketch Documentation](https://github.com/mattdesl/canvas-sketch/blob/master/docs/README.md).

1. En la carpeta `src` se encuentren los proyectos
2. Ingresar al proyecto y ejecutar `canvas-sketch sketch.js --open`

### Configuración

## API

Endpoints consumidos por el dispositivo:

| Endpoint            | Verb | Description                                        |
| ------------------- | ---- | -------------------------------------------------- |
| `/v1/recreo`        | GET  | If set to true, the result will also include cats. |
| `/v1/recreo/estado` | GET  | If set to true, the result will also include cats. |
| `/v1/recreo/estado` | PUT  | If set to true, the result will also include cats. |

**[Documentación API](https://colormono.com/recreo/api/reference/)**

## Flujo de trabajo

![Columpio v1](./docs/workflow.jpg)

## Hardware

Lista de componentes utilizados

- NodeMCU 1.0 (ESP-12E Module)
- Modulo Display 4 digitos Catalex
- Modulo 1 Relay
- Modulo 1 Led RGB
- Timbre 220v
- Fuente de alimentación para protoboard 5v, 3.3v
- Fuente de alimentación 5v 2amp

## Código

Para poder compilar el código y subirlo al microcontrolador es requerido que estén instalados los drivers y las librerías listadas a continuación.

### Drivers

- [CP210x USB to UART Bridge VCP Drivers](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers) - Driver para dispositivos chinos
- [Driver CH340 MacOS](https://www.geekfactory.mx/download/driver-ch340-macos/) - Driver alternativo para dispositivos chinos

### Librerías

Las versiones de las librerías utilizadas al momento de desarrollo del proyecto se encuentran en el directorio `/libraries`.

- https://github.com/chrvadala/transformation-matrix
- https://www.npmjs.com/package/delaunay-triangulate

### Ejemplos

En el directorio `/examples` se encuentran sketchs con posibles soluciones a los ditstintos problemas, atacándolos por separado.

## Enlaces útiles

- [canvas-sketch](https://github.com/mattdesl/canvas-sketch) - A framework for making generative artwork in JavaScript and the browser by Matt DesLauriers.
- [canvas-sketch Documentation](https://github.com/mattdesl/canvas-sketch/blob/master/docs/README.md)
- [canvas-sketch Cheat Sheet](https://github.com/mattdesl/workshop-generative-art/blob/master/docs/cheat-sheet.md)
- [Generative Art Workshop with Canvas-Sketch](https://github.com/mattdesl/workshop-generative-art)
- [canvas-sketch-util](https://github.com/mattdesl/canvas-sketch-util) - Utilities for generative art in Canvas, WebGL and JavaScript.
- [Math as code](https://github.com/Jam3/math-as-code) - Reference to ease developers into mathematical notation by showing comparisons with JavaScript code.
- [Linear Interpolation](https://mattdesl.svbtle.com/linear-interpolation)
- [generative artistry by tim holman](https://generativeartistry.com/)

### Penplotter

- [Pen Plotter Art & Algorithms, Part 1](https://mattdesl.svbtle.com/pen-plotter-1) - Article by Matt DesLauriers
- [Pen Plotter Art & Algorithms, Part 2](https://mattdesl.svbtle.com/pen-plotter-2) - Article by Matt DesLauriers

### AR

### 3D and Shaders

### Thermal Printer

- [Thermal Printer technical details](https://www.adafruit.com/product/597)
- [Thermal Printer manual](https://cdn-shop.adafruit.com/datasheets/CSN-A2+User+Manual.pdf)
- [Thermal Printer tutorial](https://learn.adafruit.com/mini-thermal-receipt-printer)
- [Printing bitmap hacking](https://learn.adafruit.com/mini-thermal-receipt-printer/hacking)
- [Tutorial PatagoniaTec](https://saber.patagoniatec.com/2014/09/mini-impresora-termina-uart-arduino-argentina-ptec-qr-codigo-barras/)
- [Tutorial para usar con la Raspberry](http://pikiosk.tumblr.com/post/38866317521/printing-with-raspberry)

TRABAJANDO CON:

MODELO: CP437 VERSION 2.69
BAUDRATE: 19200
DEGREE: 29
VOLTAGE: 7.5
HEAT DOT=80
ON=1300
OFF=100

Bitmap Printing
This printer can print out bitmaps, which can add a touch of class to a receipt with your logo or similar.
The first step is to get the logo prepared. The printer can only do monochrome (1-bit) images, and the maximum width is 384 pixels.

The Adafruit_Thermal library folder that you previously downloaded contains a sub-folder called processing. Inside that is a sketch called bitmapImageConvert.pde. Load this into Processing and press RUN (the triangle button).

You’ll be prompted to select an image using the system’s standard file selection dialog. The program runs for just a brief instant, and will create a new file alongside the original image file. For example, if you selected an image called “adalogo.png”, there will be a new file called “adalogo.h” in the same location. This file contains code to add to your Arduino sketch. You shouldn’t need to edit this file unless you want to change the variable names within.

To get this file into your Arduino sketch, select “Add File…” from the Sketch menu. This will add a new tab to your code. Your original code is still there under the leftmost tab.

Next, in the tab containing the main body of your code, add an “include” statement to reference the new file:
`#include "adalogo.h"`

Check the A_printertest example sketch if you’re not sure how to include the code properly.

If the source image was called adalogo.png, then the resulting .h file (adalogo.h) will contain three values called adalogo_width, adalogo_height and adalogo_data, which can be passed directly and in-order to the printBitmap() function, like this:
`printBitmap(adalogo_width, adalogo_height, adalogo_data);`
