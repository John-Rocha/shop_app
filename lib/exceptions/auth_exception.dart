class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'O endereço de e-mail já está sendo usado por outra conta.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloquedo. Tente mais tarde.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado! ',
    'INVALID_PASSWORD': 'A senha é inválida!',
    'USER_DISABLED': 'A conta de usuário foi desativada!',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação';
  }
}
