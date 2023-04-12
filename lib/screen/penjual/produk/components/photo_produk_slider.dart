
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Photos.dart';
import 'package:idaman/models/slide_model.dart';
import 'package:idaman/screen/photo/photo_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../main.dart';

typedef void NewCallback(String val);
typedef void DelCallback(String val);

class PhotoProdukSlider extends StatefulWidget {
  const PhotoProdukSlider({
    Key? key,
    required this.images,
    required this.parentId,
    required this.newPath,
    required this.delPhotoId
  }) : super(key: key);

  final List<PhotoModel> images;
  final String parentId;
  final NewCallback newPath;
  final DelCallback delPhotoId;

  static bool isApiCallProcess = false;
  @override
  _PromoSliderState createState() => _PromoSliderState();
}

List<SlideData> slides = [];
List<Widget> imageSliders = [];


class _PromoSliderState extends State<PhotoProdukSlider> {
  XFile? imageFile;
  File? croppedImage;

  void initState(){
    buildSliders(context);
    addNewBtn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _current = 0;
    final CarouselController _controller = CarouselController();
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason)
              {
                setState(() {
                  _current = index;
                });
              }
          ),
        ),
      ],
    );
  }

  addNewBtn(){
    imageSliders.add(
        Container(
            child: GestureDetector(
              onTap: () async{
                if(await Permission.camera.status.isDenied){
                  MyApp.useCamera(
                      context,
                      "Akses Kamera",
                      "Aplikasi ini memerlukan akses kamera untuk mengmbil gambar aktual. \n\nGambar aktual anda akan tersedia secara publik atau sebagian dan tersimpan dalam server kami sebagai pendataan.",
                          () {
                        Navigator.pop(context);
                      },
                          () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      }
                  );
                }else{
                  getImage(ImageSource.camera);
                }
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/open_camera.png",
                          fit: BoxFit.cover,
                          width: 1000.0,
                          height: 300,
                        ),
                      ],
                    )),
              ),
            )
        )
    );
  }

  buildSliders(BuildContext context){
    imageSliders = widget.images
        .map((item) => Container(
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(
            context,
            PhotoViewScreen.routeName,
            arguments: PhotoViewArguments(
              photo: item.file,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  if(item.type=="network")
                  Image.network(
                    item.file,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 300,
                  ),
                  if(item.type=="file")
                    Image.file(
                      File(item.file),
                      fit: BoxFit.cover,
                      width: 1000.0,
                      height: 300,
                    ),
                ],
              )),
        ),
      ),
    )).toList();

    setState(() {});
  }

  void getImage(ImageSource source) async {
        try {
          final pickedImage = await ImagePicker().pickImage(source: source);
          if (pickedImage != null) {
            CroppedFile? cropped = await ImageCropper().cropImage(
                sourcePath: pickedImage.path,
                compressFormat: ImageCompressFormat.jpg,
                compressQuality: 100
            );
            croppedImage = File((await cropped?.path)!);
            String selPhoto = (await cropped?.path)!;
            widget.images.add(PhotoModel(
                id: "0",
                parent_id: widget.parentId,
                file: selPhoto,
                parent: "produk",
                utama: "0",
                type: "file",
                created_at: DateTime.now().toString()
            ));

            setState(() {
              widget.newPath(selPhoto);
              buildSliders(context);
              addNewBtn();
            });
          }
        } catch (e) {
          print("take camera " + e.toString());
          imageFile = null;
          setState(() {});
        }
      }
}


