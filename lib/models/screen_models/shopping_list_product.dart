

class ShoppingListProduct{

  String title;
  List<String> variations;
  String rating;
  int orderNo;
  int price;
  String image;
  int originalPrice;
  int discount;
  String desc;

  ShoppingListProduct({required this.desc,required this.price,required this.title,required this.image,required this.rating,required this.discount,required this.orderNo,required this.originalPrice,required this.variations});
}