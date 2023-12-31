import 'package:flutter/material.dart';
import 'package:zon_gneapp/screens/House.dart';
import 'package:zon_gneapp/widgets/widget.dart';

class House {
  final String name;
  final String avatar;
  final double price;
  final String address;

  House(
      {required this.name,
      required this.avatar,
      required this.price,
      required this.address});
}

List<House> houses = [
  House(
    name: 'Overgne',
    avatar: 'images/maison.png',
    price: 4000000,
    address: '123 Rue Principale',
  ),
  House(
    name: 'Bourgeron',
    avatar: 'images/maison.png',
    price: 200000000,
    address: '123 Rue Principale',
  ),
  House(
    name: 'Montelegron',
    avatar: 'images/house.png',
    price: 23000000,
    address: '123 Rue Principale',
  ),
  House(
    name: 'Villas',
    avatar: 'images/house.png',
    price: 20000000,
    address: '123 Rue Principale',
  ),
  House(
    name: 'Ramoimon',
    avatar: 'images/house.png',
    price: 5000000,
    address: '123 Rue Principale',
  ),
  // Ajoutez d'autres maisons ici selon vos besoins
];

class HouseDetailsPage extends StatelessWidget {
  final House house;
  final List<House> allHouses;

  const HouseDetailsPage(
      {Key? key, required this.house, required this.allHouses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<House> otherHouses =
        allHouses.where((h) => h.name == house.name).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(house.name),
      ),
      body: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Options'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.event_available),
                      title: Text('Faire une réservation'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReservationServicePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text('Acheter'),
                      onTap: () {
                        // Action à effectuer lors de l'achat
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => housePage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(house.avatar),
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  'Prix : \$${house.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Adresse : ${house.address}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ), // Ajoutez d'autres détails spécifiques à la maison ic
                const SizedBox(height: 16),
                const Text(
                  'Autres maisons',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: otherHouses.length,
                  itemBuilder: (context, index) {
                    final otherHouse = otherHouses[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Options'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.event_available),
                                    title: Text('Faire une réservation'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationServicePage()),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.shopping_cart),
                                    title: Text('Acheter'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => housePage()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(otherHouse.avatar),
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Prix : \$${otherHouse.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              otherHouse.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Adresse : ${otherHouse.address}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HouseListPage extends StatefulWidget {
  final List<House> houses;

  HouseListPage({required this.houses});

  @override
  HouseListPageState createState() => HouseListPageState();
}

class HouseListPageState extends State<HouseListPage> {
  List<House> filteredHouses = [];

  @override
  void initState() {
    super.initState();
    filteredHouses = widget.houses;
  }

  void filterHouses(String searchQuery) {
    List<House> filteredList = widget.houses.where((house) {
      final String name = house.name.toLowerCase();
      final double price = house.price;

      final String query = searchQuery.toLowerCase();
      return name.contains(query) || price.toString().contains(query);
    }).toList();

    setState(() {
      filteredHouses = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Liste des maisons'),
          backgroundColor: Color(0xFF404040), // Couleur de fond de l'appbar
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  filterHouses(value);
                },
                decoration: InputDecoration(
                  labelText: 'Rechercher une maison',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHouses.length,
                itemBuilder: (context, index) {
                  final house = filteredHouses[index];
                  return ListTile(
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HouseDetailsPage(
                                house: house, allHouses: widget.houses),
                          ),
                        );
                        print('Image cliquée : ${house.name}');
                      },
                      child: Image.asset(house.avatar),
                    ),
                    title: Text(house.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prix : \$${house.price.toStringAsFixed(2)}'),
                        Text('Adresse : ${house.address}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
