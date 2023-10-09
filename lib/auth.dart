import 'package:mysql1/mysql1.dart';

class AuthService {
  final MySqlConnection _connection;

  AuthService(this._connection);

  Future<bool> authenticate(String cpf, String senha) async {
    final results = await _connection.query(
      'SELECT * FROM usuarios WHERE cpf = ? AND senha = ?',
      [cpf, senha],
    );

    return results.isNotEmpty;
  }
}
