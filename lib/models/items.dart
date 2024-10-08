class Items{
  String title;
  String price;
  String imageUrl;
  Items(this.title,this.price,this.imageUrl);
  static List<Items> generateItems(){
    return[
      Items(
          "Glucose Blood Curve",
          "880 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "Glucose Tolerance Curve (GTT)",
          "735 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "T.B Film (3 Samples)",
          "380 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "T.B Film (5 Sample)",
          "735 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "Glucose 1/2 Hour Profile",
          "170 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "Glucose 1 Hour Profile",
          "190 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "Glucose 1/2 Hour Profile",
          "170 EGP",
          "assets/images/zw.png"
      ),
      Items(
          "Glucose 2 Hours Profile",
          "170 EGP",
          "assets/images/zw.png"
      ),
    ];
  }
}