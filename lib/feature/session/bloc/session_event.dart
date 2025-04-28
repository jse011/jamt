part of 'session_bloc.dart';

class SessionEvent extends Equatable {

  const SessionEvent();

  @override
  List<Object?> get props => throw UnimplementedError();

}

final class TabSelected extends SessionEvent {
  const TabSelected(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

}

final class OneSessionSelected extends SessionEvent {
  const OneSessionSelected(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

}

final class TwoSessionSelected extends SessionEvent {
  const TwoSessionSelected(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

}

final class OneSessionSave extends SessionEvent {
  final int refreshId;

  const OneSessionSave(this.refreshId);

  @override
  List<Object> get props => [refreshId];
}

final class TwoSessionSave extends SessionEvent {
  final int refreshId;
  const TwoSessionSave(this.refreshId);
  @override
  List<Object> get props => [refreshId];
}

final class OneSessionClose extends SessionEvent {
  final int refreshId;
  const OneSessionClose(this.refreshId);
  @override
  List<Object> get props => [refreshId];
}

final class TwoSessionClose extends SessionEvent {
  final int refreshId;
  const TwoSessionClose(this.refreshId);
  @override
  List<Object> get props => [refreshId];
}

final class SessionRegister extends SessionEvent {
  final int refreshId;
  const SessionRegister(this.refreshId);
  @override
  List<Object> get props => [refreshId];
}
