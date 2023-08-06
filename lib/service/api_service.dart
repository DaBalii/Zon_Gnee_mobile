
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zon_gneapp/model/maison.dart';

class ApiService {
  var baseUrl = "http://192.168.1.82:8000/";

  Future getAllHomes()async{
    var route ="api/Admin/houses";
    var url =   Uri.parse(baseUrl+route);
    var response = await http.get(url);
    if(response.statusCode==200){
      List jsonResponse = jsonDecode(response.body);
      var listOfHomes = [];
      jsonResponse.forEach((home) {
        listOfHomes.add(Maison.fromMap(home, baseUrl));
      });
      print(jsonResponse);
      return listOfHomes;
    }else{
      return [];
    }
  }
  Future login (String email,String password) async {
    var route = "api/Admin/connexion";
    var url = Uri.parse(baseUrl+route);
    var data = jsonEncode({'email': email,'password': password});
    var response = await http.post(url, body:data, headers: {'content-type': 'application/json'} );
print(data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return {
        "code":response.statusCode,
        "data":jsonResponse
      };
    } else {
      print(response.body);
      return {
        "code":response.statusCode,
        "data":response.body
      };
    }
  }
  Future registerUser(String name,String prenom, String email, String tel, String password, String password_confirmation) async {
    var route = "api/Admin/inscription";

    var url = Uri.parse(baseUrl+route);
    var data = jsonEncode({
      'name': name,
      'prenom': prenom,
      'email': email,
      'tel': tel,
      'password': password,
      'password_confirmation':password_confirmation
    });

    var response = await http.post(url, body:data , headers: {'content-type': 'application/json'});
    print(data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return {
        "code":response.statusCode,
        "data":jsonResponse
      };
    } else {
      print(response.body);
      return {
        "code":response.statusCode,
        "data":response.body
      };
    }
  }

  Future userReservation(String reservname, String address, int num_tel,DateTime date_arr,int duration) async {
    var route = "api/reservations/create";

    var url = Uri.parse(baseUrl+route);
    var data = {
      'address': address,
      'name': reservname,
      'num_tel': num_tel,
      'date_arr': date_arr,
      'duration': duration
    };
    var response = await http.post(url, body: data, headers: {'content-type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print(response.body);
    }
  }
}