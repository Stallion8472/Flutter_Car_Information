class HelperFunctions{
  static String enumToString(String type){
    var serviceString = type.substring(type.toString().indexOf('.') + 1);
    var serviceTypeLetterCodeUnits = serviceString.codeUnits;
    
    var serviceAsString = "";
    serviceAsString += serviceString[0].toUpperCase();
    for (var i = 1; i < serviceTypeLetterCodeUnits.length; i++) {
      if(serviceTypeLetterCodeUnits[i] < 90){
        serviceAsString += ' ' + serviceString[i].toUpperCase(); 
      }
      else{
        serviceAsString += serviceString[i]; 
      }
    }
    return serviceAsString;
  }
}