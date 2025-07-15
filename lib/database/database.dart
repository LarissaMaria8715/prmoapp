
class DataBase {
  static List<String> emails = [
    'joao@gmail.com',
    'maria@gmail.com',
    'ana@exemplo.com',
  ];

  static List<String> passwords = [
    '123456',
    'abcdef',
    'senha123',
  ];

  bool validateUser(String email, String password) {
    for (int i = 0; i < emails.length; i++) {
      if (emails[i] == email && passwords[i] == password) {
        return true;
      }
    }
    return false;
  }

  void addUser(String email, String password) {
    emails.add(email);
    passwords.add(password);
  }
}