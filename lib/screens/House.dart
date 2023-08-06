import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class housePage extends StatefulWidget {
  const housePage({Key? key}) : super(key: key);

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<housePage> {
  final List<String> paymentMethods = [
    'Carte de crédit',
    'PayPal',
    'Virement bancaire',
    'Chèque',
    'Espèces'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF707070),
            ),
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Votre Agence",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nos Informations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Nom de l'agence : ATAKORA",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Adresse : 123 Rue Principale,lomé , Togo",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Téléphone : +228 22453225",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Email : groupeatakorasarl.com",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Nos services",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text("Vente de biens immobiliers"),
                    ),
                    ListTile(
                      leading: Icon(Icons.business),
                      title: Text("Location de biens immobiliers"),
                    ),
                    ListTile(
                      leading: Icon(Icons.receipt),
                      title: Text("Gestion de biens immobiliers"),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Moyens de paiement",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        for (var method in paymentMethods)
                          ListTile(
                            leading: Icon(Icons.payment),
                            title: Text(method),
                          ),
                      ],
                    ),
                    // Ajoutez d'autres éléments en fonction de vos besoins
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationServicePage extends StatefulWidget {
  const ReservationServicePage({Key? key}) : super(key: key);

  @override
  _ReservationServicePageState createState() => _ReservationServicePageState();
}

class _ReservationServicePageState extends State<ReservationServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phoneNumber;
  DateTime? _arrivalDate;
  int? _stayDuration;

  void _resetForm() {
    _formKey.currentState?.reset();
    _name = null;
    _email = null;
    _phoneNumber = null;
    _arrivalDate = null;
    _stayDuration = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service de Réservation'),
        backgroundColor: const Color(0xFF707070),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: 'Nombre de réservations : 0',
                // Supprimé la référence à la liste
                child: Text(
                  'Service de Réservation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Contact: +123456789',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'E-mail : groupeatakora@example.com',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Formulaire de réservation'),
                        content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Nom',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre nom';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value;
                                  },
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Adresse e-mail',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre adresse e-mail';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value;
                                  },
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Numéro de téléphone',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre numéro de téléphone';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _phoneNumber = value;
                                  },
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Date d\'arrivée',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir la date d\'arrivée';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Convertir la chaîne de date en objet DateTime si nécessaire
                                    _arrivalDate = DateTime.parse(value!);
                                  },
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Durée du séjour (en jours)',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir la durée du séjour';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _stayDuration = int.parse(value!);
                                  },
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      // Envoyer les données de réservation vers l'API
                                      _submitReservation();
                                    }
                                  },
                                  child: Text('Réserver'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Réserver maintenant'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var baseUrl = "http://192.168.1.82:8000/api";

  void _submitReservation() async {
    var route = "/Admin/houses";
    // Construire le corps de la requête avec les données de réservation
    Map<String, dynamic> reservationData = {
      "name": _name,
      "email": _email,
      "phoneNumber": _phoneNumber,
      "arrivalDate": _arrivalDate.toString(),
      "stayDuration": _stayDuration,
    };

    // Convertir les données en JSON
    String jsonData = jsonEncode(reservationData);

    // URL de l'API de réservation (remplacez cette URL par celle de votre API)
    String apiUrl = "https://votre-api.com/reservations";

    try {
      // Envoyer la requête POST à l'API
      http.Response response = await http.post(
        Uri.parse(baseUrl + route),
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      // Vérifier le statut de la réponse
      if (response.statusCode == 200) {
        // La réservation a été effectuée avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Réservation effectuée !'),
          ),
        );

        // Réinitialiser le formulaire
        _resetForm();
      } else {
        // La réservation a échoué, afficher un message d'erreur si nécessaire
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('La réservation a échoué.'),
          ),
        );
      }
    } catch (e) {
      // Erreur lors de l'envoi de la requête
      print('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur est survenue lors de la réservation.'),
        ),
      );
    }
  }
}
