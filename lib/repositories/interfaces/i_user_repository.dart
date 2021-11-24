abstract class IUserRepository {
  Future<void> authenticateUser(String email, String password);
  Future<bool> registerUser(String email, String password);
  Future<void> singOutUser();
}
