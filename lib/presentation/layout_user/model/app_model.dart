class AppModel {
  final String name, image,description, category;
  final double rating;
  final int review, price;
  List<String> size;
  bool isCheck;

  AppModel(
      {required this.name,
      required this.image,
      required this.description,
      required this.category,
      required this.rating,
      required this.review,
      required this.price,
      required this.size,
      required this.isCheck,
      });
}

List<AppModel> EcommerceApp=[
  AppModel(
      name: "Panadol Advance",
      image: "assets/images/categories/Medications.png",
      description: "WHY PANADOL ADVANCE TABLETS: Panadol Advance with the patented Optizorb Technology is unique in its paracetamol disintegration that starts within 5 minutes after taking the tablet, provides 5 times faster dissolution than standard paracetamol.\nWHAT ARE PANADOL ADVANCE TABLETS: Tabletswith Optizorb technology, designed to provide advanced absorption compared to regular Panadol tablets, that can start to relieve the pain in as little as 15 minutes.\nWHO CAN USE PANADOL ADVANCE: Suitable forchildren above 6 years old and adults, who are experiencing various symptoms of pain and fever and need to get rid of this in a fast way.\nAVAILABLE FORMATS OF PANADOL ADVANCE:Panadol Advance Tablets are film-coated tablets with 500 mg of paracetamol, that can be found in a pack of 24 tablets.\n They are easy to swallow due to their shape, leaving no bitter aftertaste.\nHOW WILL PANADOL ADVANCE BENEFIT YOU:Panadol Advance treats symptoms associated with headache, toothache, muscular aches, cold and flu symptoms, period pains, fever as well as arthritis.",
      category: "Medications",
      rating: 4.9,
      review: 136,
      price: 31,
      size: [
        "S",
        "L",
      ],
      isCheck: false),
  AppModel(
      name: "Iphone",
      image: "assets/images/categories/mobiles.png",
      description: "Iphone Has Very Good",
      category: "Phone",
      rating: 4.9,
      review: 136,
      price: 31,
      size: [
        "Pro",
        "ProMax",
      ],
      isCheck: true,
  ),
  AppModel(
      name: "T-Shirt Over Size",
      image: "assets/images/categories/T-shirt.png",
      description: "T-Shirt Has Very Good",
      category: "Fashion",
      rating: 4.9,
      review: 136,
      price: 250,
      size: [
        "M",
        "L",
        "XL",
        "XXL",
        "XXXL",
      ],
      isCheck: true),
  AppModel(
      name: "T-Shirt Over Size",
      image: "assets/images/categories/T-shirt.png",
      description: "T-Shirt Has Very Good",
      category: "Fashion",
      rating: 4.9,
      review: 136,
      price: 250,
      size: [
        "M",
        "L",
        "XL",
        "XXL",
        "XXXL",
      ],
      isCheck: true),
];