import 'dart:io';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String urlImage;
  final File fileImage;
  CircleImage.fromFile(this.fileImage) : this.urlImage = null;
  CircleImage.fromUrl(this.urlImage) : this.fileImage = null;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 100.5,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 90,
          backgroundColor: Colors.blueGrey[200],
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 89,
            backgroundImage: (fileImage != null)
                ? FileImage(fileImage)
                : (urlImage != null)
                    ? NetworkImage(urlImage) 
                    : null,
            child: (urlImage == null && fileImage == null)
                ? Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.black54,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
