import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/pages/checkOut.dart';

class FoodSelectionPage extends StatefulWidget {
  final Map<String, dynamic> place;

  FoodSelectionPage({required this.place});

  @override
  _FoodSelectionPageState createState() => _FoodSelectionPageState();
}

class _FoodSelectionPageState extends State<FoodSelectionPage> {
  List<Map<String, dynamic>> selectedItems = [];
  double totalPrice = 0;

  List<String> categories = ["All", "Snacks", "Drinks", "Meals", "Desserts"];
  String selectedCategory = "All";

  // 🔥 Firestore Query (your structure)
  Stream<QuerySnapshot> getFoodItems() {
    var query = FirebaseFirestore.instance
        .collection('food_items')
        .where("place_id",
            isEqualTo: widget.place["name"].toString().trim());

    if (selectedCategory != "All") {
      query = query.where("category", isEqualTo: selectedCategory);
    }

    return query.snapshots();
  }

  // 🔥 Update Quantity with full validation
  void updateQuantity(Map<String, dynamic> foodItem, int change) {
    setState(() {
      int index =
          selectedItems.indexWhere((item) => item["id"] == foodItem["id"]);

      int currentCount = index != -1 ? selectedItems[index]["count"] : 0;

      // 🚫 Prevent adding if out of stock
      if (foodItem["quantity"] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Item is out of stock")),
        );
        return;
      }

      // 🚫 Prevent exceeding stock
      if (change > 0 && currentCount >= foodItem["quantity"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No more stock available")),
        );
        return;
      }

      if (index != -1) {
        selectedItems[index]["count"] += change;

        if (selectedItems[index]["count"] <= 0) {
          selectedItems.removeAt(index);
        }
      } else if (change > 0) {
        selectedItems.add({
          ...foodItem,
          "name": foodItem["name"].toString().trim(),
          "count": 1
        });
      }

      // 🔁 Recalculate total
      totalPrice = selectedItems.fold(
          0, (sum, item) => sum + (item["price"] * item["count"]));
    });
  }

  // 🔥 Safe count getter
  int getCount(String id) {
    final item = selectedItems.firstWhere(
      (item) => item["id"] == id,
      orElse: () => {"count": 0},
    );
    return item["count"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.place['name']} Menu"),
      ),
      body: Column(
        children: [
          // 🔵 Category Selector
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedCategory == category
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 🍔 Food List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getFoodItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No items available"));
                }

                List<Map<String, dynamic>> foodList =
                    snapshot.data!.docs.map((doc) {
                  return {
                    "id": doc.id,
                    "name": doc["name"].toString().trim(),
                    "image": doc["image"],
                    "quantity": doc["quantity"],
                    "price": doc["price"],
                  };
                }).toList();

                return ListView.builder(
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    var item = foodList[index];
                    int count = getCount(item["id"]);

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              // 🖼 Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item["image"],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Icon(Icons.fastfood, size: 50),
                                ),
                              ),

                              SizedBox(width: 15),

                              // 📄 Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(item["name"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),

                                    Text("₹${item["price"]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green)),

                                    Text("Available: ${item["quantity"]}",
                                        style: TextStyle(
                                            color: Colors.grey)),

                                    if (item["quantity"] == 0)
                                      Text("Out of Stock",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),

                              // ➕➖ Controls
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove,
                                        color: Colors.red),
                                    onPressed: count > 0
                                        ? () => updateQuantity(item, -1)
                                        : null,
                                  ),

                                  Text("$count",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),

                                  IconButton(
                                    icon: Icon(Icons.add,
                                        color: Colors.green),
                                    onPressed: (item["quantity"] == 0 ||
                                            count >= item["quantity"])
                                        ? null
                                        : () => updateQuantity(item, 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // 🧾 Checkout Box
          if (selectedItems.isNotEmpty)
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Items: ${selectedItems.length}",
                          style: TextStyle(color: Colors.white)),
                      Text("₹${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(
                            selectedItems: selectedItems,
                            totalPrice: totalPrice,
                          ),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          selectedItems = List.from(result);
                          totalPrice = selectedItems.fold(
                            0,
                            (sum, item) =>
                                sum + (item["price"] * item["count"]),
                          );
                        });
                      }
                    },
                    child: Text("Checkout",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}