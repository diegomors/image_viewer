# Image Viewer

This project shows a implementation of conditional import to make able to use 'dart:html' and 'dart:io' in the same project, in another words make possible to use some specific Web plataform resources in projects that needs to run on Web and Mobile too. 

Also shows a implementation for a image viewer that's able to renderer png, jpg and svg, using a standardized call, switching to use `flutter_svg` library when is needed in mobile devices, but always using `ImageElement` in web platform.

## Notes

- Image.Network doesn't support SVG files
- SvgPicture.network has no error state handler