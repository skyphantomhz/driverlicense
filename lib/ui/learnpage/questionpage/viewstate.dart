class ViewState {
  ViewState._();
  factory ViewState.event(Event event) = EventState;
}

class EventState extends ViewState {
  EventState(this.event) : super._();
  final Event event;
}

enum Event { TIME_OUT, NORMAL }
