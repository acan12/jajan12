abstract class EventObserver {
  void notify(ViewEvent event);
}

abstract class ViewEvent {
  ViewEvent(this.qualifier);
  String qualifier;

  @override
  String toString() {
    return 'ViewEvent(qualifier : $qualifier';
  }
}