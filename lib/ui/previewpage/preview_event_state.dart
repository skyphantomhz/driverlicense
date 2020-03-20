class ViewState {
  ViewState._();
  factory ViewState.event(Event event) = PreviewEventState;
}

class PreviewEventState extends ViewState {
  PreviewEventState(this.event) : super._();
  final Event event;
}

enum Event { TIME_OUT, NORMAL }