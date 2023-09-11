enum ImMessageType {
  manual('MANUAL'),
  sona('INPUT'),
  startUpLine('PROLOGUE'),
  suggestion('SUGGEST');

  const ImMessageType(this.name);

  final String name;
}