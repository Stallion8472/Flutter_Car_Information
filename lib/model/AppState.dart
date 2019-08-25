class AppState {
  String loggedInUser;
  String selectedVehicle;

  AppState(this.loggedInUser, this.selectedVehicle);

  factory AppState.fromJson(Map<String, dynamic> json){
    String userEmail = json['user'];
    String vehiclePath = json['vehicle'];

    return AppState(userEmail, vehiclePath);
  }
}