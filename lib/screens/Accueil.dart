import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';
import 'package:zon_gneapp/model/domain.dart';
import 'package:zon_gneapp/screens/House.dart';
import 'package:zon_gneapp/screens/Login.dart';
import 'package:zon_gneapp/screens/ecran.dart';
import 'package:zon_gneapp/screens/shupp.dart';
import 'package:zon_gneapp/service/api_service.dart';
import 'package:zon_gneapp/widgets/widget.dart';
import 'package:zon_gneapp/widgets/widget_recip.dart';

List<Domain> Domains = [
  Domain(id: 1, name: 'maps', icon: Icons.location_on_outlined),
  Domain(id: 2, name: 'house', icon: Icons.house_outlined),
  Domain(id: 3, name: 'filtre', icon: Icons.filter_list),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homes = [];

  getData() async {
    await ApiService().getAllHomes().then((value) {
      if (value.isEmpty) {
        print("hello");
      } else {
        setState(() {
          homes = value;
        });
      }
    });
    print(homes);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            gradient: LinearGradient(
              colors: [Color(0xFF707070), Color(0xFF404040)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text("Accueil"),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF707070), Color(0xFF404040)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      // Fonction pour choisir une nouvelle image
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/user.jpg'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Fakiss",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      "fakissjoli@gmail.com",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_2_outlined),
                title: Text('Profil'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Contrat'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlankPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Achat'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShuppPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Déconnexion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 100,
                ),
                itemCount: Domains.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Domain domain = Domains[index];
                  return GestureDetector(
                    onTap: () {
                      if (domain.name == 'maps') {
                        showMessage(context);
                        /*Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OffersPage(),
                          ),
                        );*/
                      } else if (domain.name == 'house') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => housePage(),
                          ),
                        );
                      } else if (domain.name == 'filtre') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HouseListPage(houses: houses),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            domain.icon,
                            color: Colors.blue,
                            size: 28,
                          ),
                          const SizedBox(
                            width: 16,
                            height: 8,
                          ),
                          Text(
                            domain.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: IntrinsicGridView.vertical(
                padding:
                    EdgeInsets.only(top: 16, bottom: 12, left: 12, right: 12),
                verticalSpace: 10,
                horizontalSpace: 5,
                children: [
                  for (var house in houses) ScientistWidget(house: house)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      // L'utilisateur a choisi une nouvelle image, vous pouvez mettre à jour l'avatar ici
      // La variable "imagePicked.path" contient le chemin de l'image sélectionnée
      // Implémentez votre logique pour mettre à jour l'avatar ici
    }
  }
}

class ScientistWidget extends StatelessWidget {
  final House house;

  const ScientistWidget({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HouseDetailsPage(house: house, allHouses: houses),
          ),
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
              image: AssetImage(house.avatar),
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              'Prix : \$${house.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
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
            ),
            const SizedBox(height: 8),
            Text(
              'Adresse : ${house.address}',
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
  }
}
