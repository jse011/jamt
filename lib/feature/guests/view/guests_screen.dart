
import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class GuestsScreen extends StatelessWidget {
  const GuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 45,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                color: AppColor.blueLight,
              ),
            ),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:AssetImage(AppImages.guestCard1),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16
                      ),
                      child:  const Text(
                        "Información de los invitados",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: AppFont.fontTwo),
                      ),

                    ),
                    //MyTabbedPage()
                    //Padding(padding: EdgeInsets.only(bottom: 500)),
                  ],
                )
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 50))
      ],
    );
  }
}

class MyTabbedPage extends StatelessWidget {
  const MyTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // número de pestañas
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0, // ocultar AppBar si solo usas TabBar
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'YourFontBold', // tu fuente personalizada si aplica
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              fontFamily: 'YourFontRegular',
            ),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            tabs: [
              Tab(text: 'Workshops'),
              Tab(text: 'Predicadores'),
              Tab(text: 'Alabanza'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(),     // debes crear este widget
            Container(),  // debes crear este widget
            Container(),      // debes crear este widget
          ],
        ),
      ),
    );
  }
}