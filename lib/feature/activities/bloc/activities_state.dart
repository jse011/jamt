part of 'activities_bloc.dart';

final class ActivitiesState extends Equatable{

  final List<CardActivity> cardActivities;
  final CardActivity selectCardActivities;

  const ActivitiesState({
    this.selectCardActivities = const CardActivity(),
    this.cardActivities = const [
      CardActivity(
        title: "Mensajes Inspiracionales",
        body: "Temas sobre adoración auténtica, liderazgo joven y misión.",
        image: AppImages.activityImage1
      ),
      CardActivity(
        title: "Semiplenarias",
        body: "Espacios de capacitación diseñados para desarrollar habilidades en liderazgo, evangelismo y discipulado. Cada participante podrá <a href='workshop'>asistir a dos semiplenarias</a> durante el periodo asignado a esta actividad. <a href='workshop'>Haz clic aquí para elegir tus dos semiplenarias de capacitación.</a>"
      ),
      CardActivity(
        title: "Misión en Acción",
        body: "Lanzamiento de Misión Caleb con proyectos específicos de impacto social."
      ),
      CardActivity(
        title: "Adoración y Testimonio",
        body: "Experiencias de jóvenes comprometidos con la misión y la adoración. <a href='workshop'>Haz clic aquí para ver la información de los invitados.</a>"
      ),
      CardActivity(
        title: "Maranata Class",
        body: "Capacitación en el estudio bíblico y dinamismo de la Escuela Sabática Joven."
      ),
    ]
  });

  ActivitiesState copyWith({
    CardActivity? selectCardActivities,
    List<CardActivity>? cardActivities
  }) {
    return ActivitiesState(
      selectCardActivities: selectCardActivities ?? this.selectCardActivities,
      cardActivities: cardActivities ?? this.cardActivities,
    );
  }

  @override
  List<Object?> get props => [cardActivities, selectCardActivities];

}
