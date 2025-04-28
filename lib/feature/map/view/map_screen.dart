
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/zoom_image_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.blue2,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 65,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  color: AppColor.yellow,
                ),
              ),
              Positioned.fill(
                child:  BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 17, sigmaY: 17),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage(AppImages.homeStands),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                          ),
                          Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                color: Colors.black.withOpacity(0.2),
                                )
                              )
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                              child: Text("Mapas",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppFont.fontTwo,
                                    fontSize: 36
                                ),))
                        ],
                      ),
                    ],
                  )
              )
            ],
          ),
          const SizedBox(height: 4),
          _MapItem(
            imagePath: AppImages.map1, // Mapa general
            thumbnailPath:  AppImages.map1Thumbnail,
            title: 'Mapa General',
          ),
          const SizedBox(height: 24),
          _MapItem(
            imagePath: AppImages.map2, // Mapa general
            thumbnailPath: AppImages.map2Thumbnail,
            title: 'Otro Mapa',
          ),
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.only(bottom: 200))
        ],
      ),
    );
  }
}

class _MapItem extends StatelessWidget {
  final String thumbnailPath;
  final String imagePath;
  final String title;

  const _MapItem({
    required this.thumbnailPath,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      // Navegar a la pantalla de zoom al hacer clic
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ZoomImageScreen(imagePath: imagePath, title: title),
        ),
      );
    },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage(imagePath),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Image.asset(
                thumbnailPath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: AppFont.fontTwo,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black38,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

