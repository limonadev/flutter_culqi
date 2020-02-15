enum CardType {
  Visa,
  MasterCard,
  AmericanExpress,
  DinersClub
}

class CulqiCard{
  String cardNumber;
  String cvv;
  int expirationMonth;
  int expirationYear;
  String email;

  CulqiCard({cardNumber, cvv, expirationMonth, expirationYear, email}){
    this.cardNumber = cardNumber;
    this.cvv = cvv;
    this.expirationMonth = expirationMonth;
    this.expirationYear = expirationYear;
    this.email = email;
  }

  bool isValid(){
    if( isCardNumberValid() &&
        isCardCvvValid()    &&
        isCardDateValid()){
      return true;
    }
    return false;
  }

  bool isCardNumberValid(){
    if(cardNumber == null) return false;

    return true;
  }

  bool isCardCvvValid(){
    if(cvv == null) return false;

    return true;
  }

  bool isCardMonthValid(){
    if(expirationMonth == null) return false;
    if((expirationMonth<1) || (expirationMonth>12)) return false;

    DateTime now = DateTime.now();
    if(isCardYearValid()){
      if(expirationYear == now.year){
        if(expirationMonth >= now.month) {
          return true;
        }
      }else if(expirationYear > now.year){
        return true;
      }
    }else{
      return false;
    }

    return false;
  }

  bool isCardYearValid(){
    if(expirationYear == null) return false;

    DateTime now = DateTime.now();
    if(expirationYear < now.year) return false;

    return true;
  }

  bool isCardDateValid(){
    if(isCardMonthValid() && isCardYearValid()){
      DateTime now = DateTime.now();

      if(expirationYear == now.year){
        if(expirationMonth >= now.month) {
          return true;
        }
      }else if(expirationYear > now.year){
        return true;
      }

    }
    return false;
  }
}