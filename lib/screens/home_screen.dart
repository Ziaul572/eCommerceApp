import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'second_screen.dart';
import 'count_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //Counter
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<dynamic> _products = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _products = data['products'];
          _isLoading = false;
        });
      } else {
        _showError('Failed to load products. Please try again later.');
      }
    } catch (error) {
      _showError('An error occurred while fetching products.');
    }
  }

  void _showError(String message) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product['thumbnail']),
              SizedBox(height: 10),
              Text('Price: \$${product['price']}'),
              SizedBox(height: 10),
              Text(product['description']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // void _generateProducts() {
  //   // Randomly generate 20 products
  //   final random = Random();
  //   final names = [
  //     'Laptop',
  //     'Phone',
  //     'Headphones',
  //     'Shoes',
  //     'Watch',
  //     'Camera',
  //     'Bag',
  //     'Chair',
  //     'Desk',
  //     'Book'
  //   ];
  //   for (int i = 0; i < 20; i++) {
  //     _products.add({
  //       'name': names[random.nextInt(names.length)],
  //       'price': (random.nextDouble() * 100).toStringAsFixed(2) // Random price
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: _selectedIndex == 0
          ? Column(
        children: [
          // Banner Section
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Welcome to Product Store!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Expanded GridView Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3 / 4, // Aspect ratio for the grid items
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return GestureDetector(
                    onTap: () {
                      _showProductDetails(context, product);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product['thumbnail'],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            product['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${product['price']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )
          : _screens[_selectedIndex], // Other screens
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(CupertinoIcons.home, 'Home', 0),
            buildNavBarItem(CupertinoIcons.list_bullet, 'My Task', 1),
            const SizedBox(width: 20),
            buildNavBarItem(CupertinoIcons.conversation_bubble, 'Message', 3),
            buildNavBarItem(CupertinoIcons.profile_circled, 'Profile', 4),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const ClipOval(
            child: Material(
              color: Color(0xFF7861FF),
              elevation: 50,
              child: InkWell(
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    CupertinoIcons.add_circled,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  static final List<Widget> _screens = [
    Container(),
    CountScreen(),
    SecondScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    //Set States
    setState(() {
      _selectedIndex = index;
    });
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         "Home ",
  //       ),
  //       automaticallyImplyLeading: false,
  //       centerTitle: false,
  //       //leading: const BackButton(),
  //     ),
  //     body: _screens[_selectedIndex],
  //     bottomNavigationBar: BottomAppBar(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           buildNavBarItem(CupertinoIcons.home, 'Home', 0),
  //           buildNavBarItem(CupertinoIcons.list_bullet, 'My Task', 1),
  //           const SizedBox(width: 20),
  //           buildNavBarItem(CupertinoIcons.conversation_bubble, 'Message', 3),
  //           buildNavBarItem(CupertinoIcons.profile_circled, 'Profile', 4),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //         onPressed: () {},
  //         child: const ClipOval(
  //           child: Material(
  //             color: Color(0xFF7861FF),
  //             elevation: 50,
  //             child: InkWell(
  //               child: SizedBox(
  //                 width: 56,
  //                 height: 56,
  //                 child:
  //                 Icon(
  //                   CupertinoIcons.add_circled,
  //                   size: 28,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //   );
  // }

  Widget buildNavBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? const Color(0xFF7861FF)
                : Colors.black87,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color(0xFF7861FF)
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
