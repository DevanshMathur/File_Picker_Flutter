import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FilePickerResult? result;
  PlatformFile? file;
  FileType fileType = FileType.unknown;
  String mimeType = "";
  String? name;
  bool isLoading = false;
  bool isFilePicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("File Picker"),
        ),
        body: isLoading
            ? progressWidget()
            : !isFilePicked
            ? pickButton()
            : previewDocument());
  }

  void pickFile() async {
    isLoading = true;
    result = await FilePicker.platform.pickFiles();
    isLoading = false;
    if (result == null) {
      // if user don't pick any thing then do nothing just return.
      isFilePicked = false;
      isLoading = false;
    } else {
      //now do something with file selected
      isFilePicked = true;
      file = result!.files.first;
      name = file?.name;
      mimeType = lookupMimeType(name ?? '') ?? '';
      fileType = getFileType(mimeType);
    }
    setState(() {});
  }

  Widget pickButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: pickFile,
        icon: const Icon(Icons.upload),
        label: const Text("Pick Document"),
      ),
    );
  }

  Widget previewDocument() {
    return Center(
      child: Column(
        children: [
          Text("name :- ${name ?? "null"}"),
          Text("mimeType :- $mimeType"),
          Text("fileType :- $fileType"),
          loadImage(fileType),
        ],
      ),
    );
  }

  Widget progressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  FileType getFileType(String? file) {
    List<String> imageExtension = [];
    if(file != null) {
      String type = file.split('/')[0];
      String type1 = file.split('/')[1];
      if (type == "image") {
        return FileType.image;
      } else if (type == "video") {
        return FileType.video;
      } else if (type == "text") {
        return FileType.doc;
      } else if (type == "application") {
        if (type1 == "pdf") {
          return FileType.pdf;
        } else {
          return FileType.doc;
        }
      } else {
        return FileType.unknown;
      }
    } else {
      return FileType.unknown;
    }
  }

  Widget loadImage(FileType fileType) {
    switch (fileType) {
      case FileType.image:
        return file != null ? Image.memory(file!.bytes!) : Container();
      case FileType.video:
        return Image.asset('assets/images/video_icon.jpg');
      case FileType.pdf:
        return Image.asset('assets/images/pdf_icon.png');
      case FileType.doc:
      case FileType.unknown:
        return Image.asset('assets/images/doc_icon.png');
    }
  }
}

enum FileType {
  image,
  video,
  doc,
  pdf,
  unknown,
}
