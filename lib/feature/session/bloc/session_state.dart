part of 'session_bloc.dart';

class SessionState extends Equatable {

  final List<SessionTab> tabs;
  final int selectedIndex;
  final int oneSelected;
  final int twoSelected;
  final List<SessionSelected> sessions;
  final SessionSelected saveOneSession;
  final SessionSelected saveTwoSession;
  final bool register;

  const SessionState({
    this.oneSelected = 0,
    this.twoSelected = 0,
    this.register = false,
    this.saveOneSession = const SessionSelected(),
    this.saveTwoSession = const SessionSelected(),
    this.sessions = const [
      SessionSelected(
        id: 0,
        title: "SELECCIONE"
      ),
      SessionSelected(
          id: 1,
          title: "ALVA Y ALVA"
      ),
      SessionSelected(
          id: 2,
          title: "SALÓN AZUL"
      ),
      SessionSelected(
          id: 3,
          title: "TEATRÍN"
      ),
      SessionSelected(
          id: 4,
          title: "CARPA MOVÍL"
      )
    ],
    this.tabs = const [
      SessionTab(
        title: "Semiplenaria 1",
        session: [
          SessionCard(
            title: 'ALVA Y ALVA',
            topic2: 'Sábado 8:40 HS',
            color: Colors.blue
          ),
          SessionCard(
              title: 'E. FORGA',
              topic2: 'Sábado 8:40 HS',
              color: Colors.red
          ),
          SessionCard(
              title: 'SALÓN AZUL',
              topic2: 'Sábado 8:40 HS',
              color: Colors.yellow
          ),
          SessionCard(
              title: 'TEATRÍN',
              topic2: 'Sábado 8:40 HS',
              color: Colors.green
          ),
          SessionCard(
              title: 'CARPA MOVÍL',
              topic2: 'Sábado 8:40 HS',
              color: Colors.orange
          )
        ]
      ),
      SessionTab(
          title: "Semiplenaria 2",
          session: [
            SessionCard(
                title: 'ALVA Y ALVA',
                topic2: 'Sábado 15:30 HS',
                color: Colors.orange
            ),
            SessionCard(
                title: 'E. FORGA',
                topic2: 'Sábado 15:30 HS',
                color: Colors.yellow
            ),
            SessionCard(
                title: 'SALÓN AZUL',
                topic2: 'Sábado 15:30 HS',
                color: Colors.red
            ),
            SessionCard(
                title: 'TEATRÍN',
                topic2: 'Sábado 15:30 HS',
                color: Colors.green
            ),
            SessionCard(
                title: 'CARPA MOVÍL',
                topic2: 'Sábado 15:30 HS',
                color: Colors.blue
            )
          ]
      )
    ], this.selectedIndex = 0});

  SessionState copyWith({
    List<SessionTab>? tabs,
    int? selectedIndex,
    int? oneSelected,
    int? twoSelected,
    SessionSelected? saveOneSession,
    SessionSelected? saveTwoSession,
    bool? register,
  }){
    return SessionState(
        selectedIndex: selectedIndex??this.selectedIndex,
        tabs: tabs??this.tabs,
        oneSelected: oneSelected??this.oneSelected,
        twoSelected: twoSelected??this.twoSelected,
        saveOneSession: saveOneSession??this.saveOneSession,
        saveTwoSession: saveTwoSession??this.saveTwoSession,
        register: register??this.register
    );
  }


  @override
  List<Object?> get props => [tabs, selectedIndex, oneSelected, twoSelected, saveOneSession, saveTwoSession, register];

}
