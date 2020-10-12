import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum_app/database/moor_db.dart';
import 'package:museum_app/server_connection/graphqlConf.dart';
import 'package:museum_app/server_connection/http_query.dart';
import 'package:photo_view/photo_view.dart';

import 'SizeConfig.dart';

class ImageCaroussel extends StatefulWidget {
  final List<String> imagePaths;

  //const ImageCaroussel.fromImages(this.images, {Key key}) : imagePaths = const <String>[], super(key: key);

  ImageCaroussel.fromStrings(this.imagePaths, {Key key}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCaroussel> {
  int _currentImage = 0;
  List<Image> _images = List<Image>();

  var _copy;

  @override
  void initState() {
    _initList();
    super.initState();
  }

  @override
  dispose() {
    _images.clear();
    super.dispose();
  }

  _initList() async {
    String token = await MuseumDatabase().accessToken();
    bool connected = await GraphQLConfiguration.isConnected(token);
    if (!connected) return;
    _images.clear();
    for (var s in widget.imagePaths) {
      _images.add(Image.network(
        HttpQuery.imageURLPicture(s),
        //GraphQLConfiguration().imageURLProfile("5e7e091dbef4a100e3735722"),
        headers: {"Authorization": "Bearer $token"},
        fit: BoxFit.contain,
        width: horSize(100, 100),
        //height: 50.toDouble(),
      ));
    }
    _copy = widget.imagePaths;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePaths == null || widget.imagePaths.isEmpty) return Container();
    //print(widget.imagePaths);
    var tag = DateTime.now().toString();
    if (_copy != widget.imagePaths) {
      _initList();
      _copy = widget.imagePaths;
      _currentImage = 0;
      return Container();
    }

    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
          //enlargeCenterPage: true,
          onPageChanged: (index, reason) => setState(() => _currentImage = index),
          viewportFraction: 1.0,
          height: verSize(50, 68.5),
          enableInfiniteScroll: false,
        ),
        items: _images
            .map(
              (img) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => _ImageDetail(tag, img.image))),
                child: Hero(
                  transitionOnUserGestures: true,
                  child: Container(
                    color: Colors.white.withOpacity(.3),
                      child: img,
                  ),
                  tag: tag,
                ),
              ),
            )
            .toList(),
      ),
      // Dot Indicator
      widget.imagePaths.length > 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imagePaths.length,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImage == index
                        ? Colors.black
                        : Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            )
          : Container(),
    ]);
  }
}

//color: Colors.green,
//height: verSize(52, 68.5),
//margin: EdgeInsets.symmetric(horizontal: 16),
//height: SizeConfig.safeBlockVertical * 40,
//width: SizeConfig.safeBlockHorizontal * 100,
//decoration: BoxDecoration(
//borderRadius: BorderRadius.all(Radius.circular(20.0)),
//border: Border.all(color: Colors.black),
//image: DecorationImage(image: img, fit: BoxFit.cover),
//),
//_ImageDetail("A", img))),
//onTap: () => _imagePopup(widget.stop.imgs[_currentImage]),
/*Image(
                        //height: verSize(57, 68.5),
                        width: horSize(100, 100),
                        image: img.image,
                        fit: BoxFit.cover)*/

/*Positioned(
                      top: 7,
                      right: 23,
                      height: SizeConfig.safeBlockVertical * 6,
                      width: SizeConfig.safeBlockVertical * 6,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(0),
                        color: Colors.black.withOpacity(0.3),
                        child: Icon(Icons.zoom_out_map,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          _imagePopup(widget.stop.imgs[_currentImage]);
                        },
                      ),*/

class _ImageDetail extends StatelessWidget {
  final ImageProvider _img;
  final _tag;

  _ImageDetail(this._tag, this._img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        //onVerticalDragEnd: (a)=>print(a.primaryVelocity),
        child: Stack(
          children: [
            PhotoView(
              heroAttributes: PhotoViewHeroAttributes(
                  tag: _tag, transitionOnUserGestures: true),
              imageProvider: _img,
              maxScale: 3.0,
              minScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 35,
              left: 7,
              height: SizeConfig.safeBlockVertical * 6,
              width: SizeConfig.safeBlockVertical * 6,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.all(0),
                color: Colors.black.withOpacity(0.3),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
