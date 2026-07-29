class Endpoints {
  Endpoints._();

  static const String characters = '/character';
  static const String characterDetail = '/character/';

  static String characterById(int id) => '/character/$id';
  static String searchCharacters(String name) =>
      '/character/?name=${Uri.encodeComponent(name)}';
}
