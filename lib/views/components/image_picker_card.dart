import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scherben_boot/services/image_provider.service.dart';

class ImagePickerCard extends FormField<String?> {
  ImagePickerCard(ImageProviderService imageProviderService)
      : super(builder: (state) {
          return Card(
              child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.only(left: 10.0)),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final imagePath =
                              await imageProviderService.pickImage();
                          print(imagePath);
                          state.didChange(imagePath);
                        },
                        icon: Icon(Icons.image_search),
                        label: Text("Bild anfügen"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[500],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0)),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => state.didChange(null),
                        icon: Icon(Icons.delete),
                        label: Text("Bild entfernen"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[500],
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 10.0)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: state.value != null
                  ? Image.file(File(state.value!))
                  : Column(
                      children: [
                        Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey[400],
                        ),
                        Text(
                          "Kein Bild hinzugefügt",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    ),
            ),
          ]));
        });
}
