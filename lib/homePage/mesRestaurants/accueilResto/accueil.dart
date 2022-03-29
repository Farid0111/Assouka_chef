

import 'dart:io';

import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AccueilHome extends StatefulWidget {
  Restaurant? resto ;
   AccueilHome({Key? key, required this.resto}) : super(key: key);



  @override
  State<AccueilHome> createState() => _AccueilHomeState();
}

class _AccueilHomeState extends State<AccueilHome> {
  List<Object> images = <Object>[];

  late Future<File> _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
     // images.add("Add Image");
     // images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(color: Colors.black,),


              SizedBox(
                height: 10.0,
              ),

              Container(
                  margin: EdgeInsets.all(15),
                  child: Text("Photo d'illustration du resto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),

              Container( margin: EdgeInsets.all(15),
                  child: buildGridView()),

              SizedBox(
                height: 10.0,
              ),

              informationWiget(info:  this.widget.resto!.registre_commerce!, titre: 'RCC'),
              informationWiget(info:  this.widget.resto!.date_ajout!, titre: 'Date de création'),
              informationWiget(info:  this.widget.resto!.localisation!, titre: 'Emplacement'),
              informationWiget(info:  this.widget.resto!.numero_telephone!, titre: 'Contacte'),
              informationWiget(info:  this.widget.resto!.slogant!, titre: 'Slogan'),



            ],
          ),
        ),

    );
  }

   Widget informationWiget ({ required String titre , required String info})
   {
     return Card(
       elevation: 10,
       margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),topRight: Radius.circular(25.0), ),
       ),
       // color: Colors.white,
       color: Colors.white
       ,
       child: ListTile(
         leading: const Icon(Icons.restaurant_menu_outlined/*, color: Colors.amber*/ , size: 30,),
         title: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(titre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

             SizedBox(
               height: 10.0,
             ),

             Text(
               info, style: TextStyle( fontSize: 15),),

             SizedBox(
               height: 10.0,
             ),

           ],

         ),

           trailing: IconButton(  icon: Icon(
             Icons.edit,
             //Icons.more_vert,
             color: Colors.black, size: 18,), onPressed: () {  },) ,
       ),
     );
   }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel? uploadModel = images[index] as ImageUploadModel?;
          return Card(

            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel!.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            color: Colors.grey,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
     // _imageFile =    ImagePicker.pickImage(source: ImageSource.gallery) as Future<File> ;
      _imageFile =    _picker.pickImage(source: ImageSource.gallery) as Future<File> ;
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel(imageUrl: '', isUploaded: false, uploading: false, imageFile: file);
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
}



//}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    required this.isUploaded,
    required this.uploading,
    required this.imageFile,
    required this.imageUrl,
  });
}
