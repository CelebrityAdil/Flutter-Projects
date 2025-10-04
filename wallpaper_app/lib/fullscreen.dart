import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:wallpaper_app/wallpaper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class Fullscreen extends StatefulWidget {
  final String ImageUrl;
  const Fullscreen({super.key, required this.ImageUrl});
  @override
  _fullscreenwidget createState() => _fullscreenwidget();
}

class _fullscreenwidget extends State<Fullscreen> {
  Future<void> setWallpaper() async {
    try {
      // Download to a File
      File file = await DefaultCacheManager().getSingleFile(widget.ImageUrl);

      // Pass file.path (String) and the int constant
      final result = await WallpaperManagerPlus().setWallpaper(
        file,
        WallpaperManagerPlus.homeScreen, // use the package constant
      );

      debugPrint("Wallpaper set: $result");
    } catch (e) {
      debugPrint("Error setting wallpaper: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(child: Image.network(widget.ImageUrl))),
            InkWell(
              onTap: () {
                setWallpaper();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
