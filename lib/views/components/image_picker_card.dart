import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scherben_boot/services/image_provider.service.dart';

class ImagePickerCard extends FormField<String?> {
  ImagePickerCard(
      {required ImageProviderService imageProviderService,
      required FormFieldSetter<String?> onSaved})
      : super(
            onSaved: onSaved,
            builder: (state) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: state.value != null
                            ? LimitedBox(
                                maxHeight: 200,
                                child: Image.file(
                                  File(state.value!),
                                ),
                              )
                            : Column(
                                children: [
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey[400],
                                    size: 100,
                                  ),
                                  Text(
                                    "Kein Bild hinzugefügt",
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
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
                          ElevatedButton.icon(
                            onPressed: () => state.didChange(null),
                            icon: Icon(Icons.delete),
                            label: Text("Bild entfernen"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
}
