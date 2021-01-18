
class User {
  String username, phoneNumber, email, userId, currentAddress;

  User.formFireBase(this.email, this.userId, document)
      : this.username = document['userName'],
        this.phoneNumber = document['phoneNumber'],
        this.currentAddress = document['currentAddress'];
}
