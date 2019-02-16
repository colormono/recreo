# Figus

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

## Enlaces útiles
* [Thermal Printer technical details](https://www.adafruit.com/product/597)
* [Thermal Printer manual](https://cdn-shop.adafruit.com/datasheets/CSN-A2+User+Manual.pdf)
* [Thermal Printer tutorial](https://learn.adafruit.com/mini-thermal-receipt-printer)
* [Printing bitmap hacking](https://learn.adafruit.com/mini-thermal-receipt-printer/hacking)
* [Tutorial PatagoniaTec](https://saber.patagoniatec.com/2014/09/mini-impresora-termina-uart-arduino-argentina-ptec-qr-codigo-barras/)
* [Tutorial para usar con la Raspberry](http://pikiosk.tumblr.com/post/38866317521/printing-with-raspberry)