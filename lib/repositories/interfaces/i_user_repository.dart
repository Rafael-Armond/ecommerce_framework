abstract class IUserRepository {
  Future<bool> authenticateUser(String email, String password);
  Future<bool> registerUser(String email, String password);
  Future<void> singOutUser();
}
