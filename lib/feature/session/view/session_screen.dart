import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/widget.dart';
import 'package:jamt/feature/session/session.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionBloc, SessionState>(
        listener: (context, state) {},
        builder: (context, state) {
              return Container(
                color: AppColor.purpleDark,
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
                            color: AppColor.blueLight,
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
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "SEMIPLANETARIAS",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: AppFont.fontTwo),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Elija dos Semiplanetarias para asistir:',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.textGrey
                                  )
                                ),
                                const SizedBox(height: 32),
                                if(state.saveOneSession.id != 0)
                                WorkshopSelectCard(
                                  title: "Semiplanetaria 1",
                                  value: state.saveOneSession.title,
                                  register: state.register,
                                  onClosePressed: (){
                                    context.read<SessionBloc>().add(OneSessionClose(DateTime.now().millisecondsSinceEpoch));
                                  },
                                ),
                                if(state.saveOneSession.id == 0)
                                WorkshopSelector(title: 'ELIGE TU SEMIPLANETARIA 1',
                                    selects: state.sessions.map((session){ return session.title;}).toList(),
                                    onChanged: (index){
                                      context.read<SessionBloc>().add(OneSessionSelected(index));
                                    },
                                  select: state.oneSelected,
                                  onPressed: (){
                                    context.read<SessionBloc>().add(OneSessionSave(DateTime.now().millisecondsSinceEpoch));
                                  },
                                ),
                                const SizedBox(height: 32),
                                if(state.saveTwoSession.id != 0)
                                  WorkshopSelectCard(
                                    title: "Semiplanetaria 2",
                                    value: state.saveTwoSession.title,
                                    register: state.register,
                                    onClosePressed: (){
                                      context.read<SessionBloc>().add(TwoSessionClose(DateTime.now().millisecondsSinceEpoch));
                                    },
                                  ),
                                if(state.saveTwoSession.id == 0)
                                WorkshopSelector(title: 'ELIGE TU SEMIPLANETARIA 2',
                                  selects: state.sessions.map((session){ return session.title;}).toList(),
                                  onChanged: (index){
                                    context.read<SessionBloc>().add(TwoSessionSelected(index));
                                  },
                                  select: state.twoSelected,
                                  onPressed: (){
                                    context.read<SessionBloc>().add(TwoSessionSave(DateTime.now().millisecondsSinceEpoch));
                                  },
                                ),
                                const SizedBox(height: 24),
                                if(!state.register)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    context.read<SessionBloc>().add(SessionRegister(DateTime.now().millisecondsSinceEpoch));
                                  },
                                  icon: const Icon(Icons.send, color: Colors.white,),
                                  label: const Text('REGISTRAR',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: AppFont.fontTwo,
                                          color: Colors.white
                                      )
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.blueLight, // Color sólido (puedes cambiarlo)
                                    minimumSize: const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // SIN bordes redondeados
                                    ),
                                  ),
                                ),
                                if(!state.register)
                                const SizedBox(height: 24),
                              ],
                            )
                        )
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 20
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: List.generate(state.tabs.length, (index) {
                                  final isSelected = state.selectedIndex == index;
                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<SessionBloc>().add(TabSelected(index));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.grey.shade100 : Colors.transparent,
                                          borderRadius: index == 0
                                              ? const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          )
                                              : index == state.tabs.length - 1
                                              ? const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          )
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.tabs[index].title,
                                            style: TextStyle(
                                              fontFamily: AppFont.fontTwo,
                                              fontSize: 12,
                                              color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      state.tabs[state.selectedIndex].title.toUpperCase(),
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: AppFont.fontTwo),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...List.generate(state.tabs[state.selectedIndex].session.length, (index) {
                                    var session = state.tabs[state.selectedIndex].session[index];
                                    return WorkshopCard(
                                      color: session.color,
                                      name: session.title,
                                      topic: session.topic,
                                      topic2: session.topic2,
                                      description: session.description,
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                          color: AppColor.blue,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Image.asset(AppImages.mainLogoWhite, height: 28),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Text(
                              "Un movimiento de celebración, inspiración, motivación y formación de jóvenes líderes, apuntando a un proceso de crecimiento integral de los jóvenes adventistas.",
                              style: TextStyle(
                                  color: AppColor.textGrey,
                                  fontSize: 13,
                                  height: 1.8,
                                  fontFamily: AppFont.font,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(12))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 200))
                  ],
                ),
              );
        });
  }
}