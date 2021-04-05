import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './models/categories.dart';
import './models/product.dart';
import './models/purchase.dart';
import './models/testimonials.dart';

const DUMMY_CATEGORIES = const [
  ProductCategories(
      id: "1",
      title: "Home Decor",
      image: "assets/Images/decor.png",
      description:
          "These accessories include such items as curtains, sofa sets, cushions, tablecloths and decorative craft products, decorative wrought iron, and so on."),
  ProductCategories(
      id: "2",
      title: "Bags",
      image: "assets/Images/bag.png",
      description:
          "A bag is a kind of soft container. It can hold or carry things. It may be made from cloth, leather, plastic, or paper."),
  ProductCategories(
      id: "3",
      title: "Footwear",
      image: "assets/Images/footwear.png",
      description:
          "Footwear refers to garments worn on the feet, which originally serves to purpose of protection against adversities of the environment, usually regarding ground textures and temperature."),
  ProductCategories(
      id: "4",
      title: "Ethnic wear",
      image: "assets/Images/wardrobe.png",
      description:
          "Ethnic wear is the fashion equivalent of one's national heritage. You can tell how deeply rich and diverse a country is based on their ethnic wear."),
  ProductCategories(
      id: "5",
      title: "Jewelry",
      image: "assets/Images/jewelry.png",
      description:
          "Jewellery or jewelry consists of decorative items worn for personal adornment, such as brooches, rings, necklaces, earrings, pendants, bracelets, and cufflinks."),
  ProductCategories(
      id: "6",
      title: "Masks / Caps",
      image: "assets/Images/mask.png",
      description:
          "A mask is an object normally worn on the face, typically for protection. A cap is a kind of soft and flat headgear, usually with a visor."),
];

int avatarId = 0;

List<String> profileAvatar = [
  "assets/Images/Avatars/0.png",
  "assets/Images/Avatars/1.png",
  "assets/Images/Avatars/2.png",
  "assets/Images/Avatars/3.png",
  "assets/Images/Avatars/4.png",
  "assets/Images/Avatars/5.png",
  "assets/Images/Avatars/6.png",
  "assets/Images/Avatars/7.png",
  "assets/Images/Avatars/8.png",
  "assets/Images/Avatars/9.png",
  "assets/Images/Avatars/10.png",
  "assets/Images/Avatars/11.png",
  "assets/Images/Avatars/12.png",
  "assets/Images/Avatars/13.png",
  "assets/Images/Avatars/14.png",
  "assets/Images/Avatars/15.png",
  "assets/Images/Avatars/16.png",
  "assets/Images/Avatars/17.png",
  "assets/Images/Avatars/18.png",
  "assets/Images/Avatars/19.png",
  "assets/Images/Avatars/20.png",
];

// List<Product> DUMMY_PRODUCTS = [
//   Product(
//     id: "1",
//     categorie: "1",
//     title: "Mason Jar",
//     description:
//         "Made with thick paper using oragami hang these in your house to make it more attractive.",
//     price: 300,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/71g8DjIys%2BL._SL1100_.jpg",
//   ),
//   Product(
//     id: "2",
//     categorie: "1",
//     title: "Buddha Statue",
//     description:
//         "Made with clay and sand. Put this in your house to attract good luck.",
//     price: 900,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/715ceYF6trL._SL1500_.jpg",
//   ),
//   Product(
//     id: "3",
//     categorie: "1",
//     title: "Home dangler",
//     description: "Pleasant voice made with non fungal wood.",
//     price: 200,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/61uzBgdClDL._SX679_.jpg",
//   ),
//   Product(
//     id: "4",
//     categorie: "1",
//     title: "Table Cloth",
//     description: "Made with soft cotton and washable cloth.",
//     price: 400,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/71G4eHgGZpL._SL1500_.jpg",
//   ),
//   Product(
//     id: "5",
//     categorie: "2",
//     title: "Jute bag",
//     description: "Soft jute and reusable.",
//     price: 250,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/71XfNVxg4lL._SL1500_.jpg",
//   ),
//   Product(
//     id: "6",
//     categorie: "2",
//     title: "Cloth bag",
//     description: "Environment friendly.",
//     price: 150,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/61cggErKUWL._SL1500_.jpg",
//   ),
//   Product(
//     id: "7",
//     categorie: "2",
//     title: "Degradable Plastic bag",
//     description: "colorful and customized  color combination available.",
//     price: 150,
//     imageUrl:
//         "https://5.imimg.com/data5/XO/PS/MY-3012345/biodegradable-poly-bag-500x500.jpg",
//   ),
//   Product(
//     id: "8",
//     categorie: "3",
//     title: "Boots",
//     description: "",
//     price: 2500,
//     imageUrl:
//         "https://5.imimg.com/data5/HP/XE/UB/IOS-41170061/product-jpeg-500x500.png",
//   ),
//   Product(
//     id: "9",
//     categorie: "3",
//     title: "Shoes",
//     description: "",
//     price: 1700,
//     imageUrl:
//         "https://assets.ajio.com/medias/sys_master/root/h0e/h57/14092954894366/-473Wx593H-460455972-black-MODEL.jpg",
//   ),
//   Product(
//     id: "10",
//     categorie: "3",
//     title: "Sandals",
//     description: "",
//     price: 700,
//     imageUrl:
//         "https://cdn.shopclues.com/images1/thumbnails/108211/640/1/150233513-108211965-1593399195.jpg",
//   ),
//   Product(
//     id: "11",
//     categorie: "3",
//     title: "Slippers",
//     description: "",
//     price: 900,
//     imageUrl:
//         "https://www.businessinsider.in/thumb/msid-78561989,width-640,resizemode-4/Master.jpg",
//   ),
//   Product(
//     id: "12",
//     categorie: "3",
//     title: "Traditional footwear",
//     description: "",
//     price: 600,
//     imageUrl:
//         "https://5.imimg.com/data5/HL/EB/MY-11817536/light-yellow-typical-kolhapuri-chappal-with-red-gonda-500x500.jpg",
//   ),
//   Product(
//     id: "13",
//     categorie: "3",
//     title: "Socks",
//     description: "",
//     price: 300,
//     imageUrl:
//         "https://m.media-amazon.com/images/I/914PNhis22L._SX679._SX._UX._SY._UY_.jpg",
//   ),
//   Product(
//     id: "14",
//     categorie: "4",
//     title: "Silk Kurta",
//     description: "",
//     price: 1300,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/91oBJh0h5iL._UL1500_.jpg",
//   ),
//   Product(
//     id: "15",
//     categorie: "4",
//     title: "Cotton Kurta",
//     description: "",
//     price: 1200,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/81D2g29IidL._UY550_.jpg",
//   ),
//   Product(
//     id: "16",
//     categorie: "4",
//     title: "Cotton polyester mix kurta",
//     description: "",
//     price: 1500,
//     imageUrl:
//         "https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/2376734/2018/1/17/11516172966195-HERENOW-Men-Shirts-8361516172966195-1.jpg",
//   ),
//   Product(
//     id: "17",
//     categorie: "5",
//     title: "Earings",
//     description: "",
//     price: 400,
//     imageUrl:
//         "https://cdnv2.vajor.com/pub/media/catalog/product/cache/a310508f44447a44c46cc981f9b80bad/v/j/vj19jwlcf09auga.jpg.jpg",
//   ),
//   Product(
//     id: "17",
//     categorie: "5",
//     title: "Bracelets",
//     description: "",
//     price: 250,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/81xhqH5fANL._AC_UL1500_.jpg",
//   ),
//   Product(
//     id: "18",
//     categorie: "5",
//     title: "Nose Ring",
//     description: "",
//     price: 450,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/319AqOgSPvL.jpg",
//   ),
//   Product(
//     id: "19",
//     categorie: "5",
//     title: "Footlet",
//     description: "",
//     price: 150,
//     imageUrl:
//         "https://ik.imagekit.io/bfrs/tr:w-400,h-400,pr-true,cm-pad_resize,bg-FFFFFF/image_karizmajewels/data/eretrtgrterr-2.jpg",
//   ),
//   Product(
//     id: "20",
//     categorie: "5",
//     title: "Piercing Tops",
//     description: "",
//     price: 4450,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/71gC3hCabfL._UL1500_.jpg",
//   ),
//   Product(
//     id: "21",
//     categorie: "6",
//     title: "Sun Cap",
//     description: "",
//     price: 200,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/41Ay7uc6VrL.jpg",
//   ),
//   Product(
//     id: "22",
//     categorie: "6",
//     title: "Winter Cap",
//     description: "",
//     price: 450,
//     imageUrl:
//         "https://contents.mediadecathlon.com/p1414831/ad0dc265fe1277b50f53cabdec2379f3/p1414831.jpg",
//   ),
//   Product(
//     id: "23",
//     categorie: "6",
//     title: "Baby Caps",
//     description: "",
//     price: 180,
//     imageUrl:
//         "https://cdn.fcglcdn.com/brainbees/images/products/438x531/8574916a.jpg",
//   ),
//   Product(
//     id: "24",
//     categorie: "6",
//     title: "Sun Hat",
//     description: "",
//     price: 270,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/71tKXRvS9IL._AC_UL1500_.jpg",
//   ),
//   Product(
//     id: "25",
//     categorie: "6",
//     title: "N95 Mask",
//     description: "",
//     price: 500,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/61vHbl-gTvL._UL1500_.jpg",
//   ),
//   Product(
//     id: "26",
//     categorie: "6",
//     title: "Plain Mask",
//     description: "",
//     price: 100,
//     imageUrl: "https://cdn.shopify.com/s/files/1/1195/0530/products/blk2.jpg",
//   ),
//   Product(
//     id: "27",
//     categorie: "6",
//     title: "Stylish Mask",
//     description: "",
//     price: 250,
//     imageUrl:
//         "https://images-na.ssl-images-amazon.com/images/I/61oHQJaTbwL._SL1000_.jpg",
//   ),
// ];

List<Product> _productList = [];

List<Testimonial> testimonials = [];

List<Purchase> _purchases = [];

List cartItems = [];

Future<void> fetchAndSetProducts() async {
  var url =
      'https://firestore.googleapis.com/v1/projects/rk-fleamarket/databases/(default)/documents/allProducts/';
  try {
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    var data = extractedData["documents"];
    final List<Product> loadedProduct = [];
    for (int i = 0; i < data.length; i += 1) {
      loadedProduct.add(Product(
        id: data[i]["name"].substring(data[i]["name"].length - 20),
        userId: data[i]["fields"]["userId"]["stringValue"],
        categorie: data[i]["fields"]["categorie"]["stringValue"],
        title: data[i]["fields"]["title"]["stringValue"],
        description: data[i]["fields"]["description"]["stringValue"],
        price: double.parse(data[i]["fields"]["price"]["integerValue"]),
        imageUrl: data[i]["fields"]["imageUrl"]["stringValue"],
      ));
    }

    _productList = loadedProduct;
  } catch (error) {
    print(error);
  }
}

Future<void> fetchAndSetTestimonials() async {
  var url =
      'https://firestore.googleapis.com/v1/projects/rk-fleamarket/databases/(default)/documents/testimonials/';
  try {
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    var data = extractedData["documents"];

    final List<Testimonial> loadedTestimonials = [];
    for (int i = 0; i < data.length; i += 1) {
      loadedTestimonials.add(Testimonial(
          rating: int.parse(data[i]["fields"]["rating"]["integerValue"]),
          comment: data[i]["fields"]["comment"]["stringValue"]));
    }

    testimonials = loadedTestimonials;
  } catch (error) {
    print(error);
  }
}

Future<void> fetchAndSetCartItems(User firebaseUser) async {
  var url =
      'https://firestore.googleapis.com/v1/projects/rk-fleamarket/databases/(default)/documents/cart/${firebaseUser.uid}/';
  try {
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    var data = extractedData["fields"]["products"]["arrayValue"]["values"];
    for (int i = 0; i < data.length; i += 1) {
      cartItems.add(data[i]["stringValue"]);
    }
  } catch (error) {
    print(error);
  }
}

List<ProductCategories> fetchAllCategories() {
  return DUMMY_CATEGORIES;
}

Future<void> addProduct(
  User firebaseUser,
  FirebaseFirestore firestoreInstance,
  Product temp,
) async {
  // DUMMY_PRODUCTS.insert(0, temp);

  try {
    firestoreInstance.collection("allProducts").add({
      "userId": firebaseUser.uid,
      "categorie": temp.categorie,
      "description": temp.description,
      "imageUrl": temp.imageUrl,
      "price": temp.price,
      "title": temp.title,
    }).then((value) {
      fetchAndSetProducts();
    });
  } catch (error) {
    print(error);
  }
}

Future<void> addToCart(
  User firebaseUser,
  FirebaseFirestore firestoreInstance,
) async {
  try {
    firestoreInstance
        .collection("cart")
        .doc(firebaseUser.uid)
        .set({"products": FieldValue.arrayUnion(cartItems)}).then((value) {});
  } catch (error) {
    print(error);
  }
}

List<Product> fetchProducts(String catId) {
  List<Product> categoryList =
      _productList.where((element) => element.categorie == catId).toList();
  return categoryList;
}

List<Product> fetchAllProducts() {
  return _productList;
}

List<Testimonial> fetchAllTestimonials() {
  return testimonials;
}

List<Product> fetchYourProducts(String id) {
  List<Product> productList =
      _productList.where((element) => element.userId == id).toList();

  return productList;
}

int getTotalProducts() {
  return _productList.length;
}

Product getProduct(String id) {
  return _productList.firstWhere((element) => element.id == id);
}

int getTestimonialsLength() {
  return testimonials.length;
}

void addToCartItems(String id) {
  cartItems.add(id);
}

List<Product> getProductsFromCart() {
  List<Product> products = [];
  for (int i = 0; i < cartItems.length; i++) {
    products
        .add(_productList.firstWhere((element) => element.id == cartItems[i]));
  }
  return products;
}

Future<void> removeFromCart(
  User firebaseUser,
  FirebaseFirestore firestoreInstance,
) async {
  try {
    cartItems = [];
    firestoreInstance
        .collection("cart")
        .doc(firebaseUser.uid)
        .delete()
        .then((value) {});
  } catch (error) {
    print(error);
  }
}

Future<void> purchaseProducts(
  User firebaseUser,
  FirebaseFirestore firestoreInstance,
  String time,
) async {
  try {
    firestoreInstance
        .collection("user")
        .doc(firebaseUser.uid)
        .collection("purchase")
        .doc()
        .set({
      "amount": getTotal(),
      "products": FieldValue.arrayUnion(cartItems),
      "time": time,
    }).then((value) {});
  } catch (error) {
    print(error);
  }
}

double getTotal() {
  List<Product> products = getProductsFromCart();
  double sum = 0;
  for (int i = 0; i < products.length; i++) {
    sum += products[i].price;
  }
  return sum;
}

void clearCartOnLogout() {
  cartItems.clear();
}

Future<void> fetchAndSetAvatarID() async {
  final response = await FirebaseFirestore.instance
      .collection("userAvatar")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get();
  avatarId = response.data()["avatar"];
}

Future<void> fetchAndSetPurchasedProducts() async {
  final snapshot = await FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("purchase").orderBy("time",descending: true)
      .get();
  var temp = [];
  snapshot.docs.forEach((element) {
    temp.add(element.id);
  });
  List<Purchase> tempPurchases = [];
  temp.forEach((element) async {
    final value = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("purchase")
        .doc(element)
        .get();
    tempPurchases.add(Purchase(
        amount: value.data()["amount"],
        products: value.data()["products"],
        time: value.data()["time"]));
  });
  _purchases = tempPurchases;

}

List<Purchase> getMyPurchases() {
  return _purchases;
}

Purchase getLatestPurchase() {
  Purchase temp;
  try {
    temp = _purchases[0];
  } catch (_) {
    temp = null;
  }
  return temp;
}

void updateAvatarId(int id) {
  FirebaseFirestore.instance
      .collection("userAvatar")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .set({"avatar": id});
  avatarId = id;
}
