part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
   const NavigationState._({
    this.initial = false,
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.destination = Destination.tabHome,
    this.forceUpdate = 0,
    this.destinations = const [
      Destination.tabHome,
      Destination.profile,
      Destination.sessions,
      Destination.qr,
      Destination.guests,
      Destination.organization,
      Destination.bulletins,
      Destination.health,
      Destination.news,
      Destination.videos,
      Destination.trivia,
      Destination.map,
      Destination.menu,
    ]
  });

  const NavigationState.unknown() : this._();

  const NavigationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user, destination: Destination.tabHome, initial: true);

  const NavigationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;
  final List<Destination> destinations;
  final Destination destination;
  final bool initial;
  final int forceUpdate;

  NavigationState copyWith({
    AuthenticationStatus? status,
    User? user,
    List<Destination>? destinations,
    Destination? destination,
    bool? initial,
    int? forceUpdate
  }) {
    return NavigationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        destinations: destinations ?? this.destinations,
        destination: destination ?? this.destination,
        initial: initial?? this.initial,
        forceUpdate: forceUpdate?? this.forceUpdate
    );
  }

  @override
  List<Object> get props => [status, user, destinations, destination, initial, forceUpdate];
}