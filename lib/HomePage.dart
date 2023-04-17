import 'package:ceylan_mobile_app/AllCustomersPage.dart';
import 'package:ceylan_mobile_app/Customer.dart';
import 'package:ceylan_mobile_app/Customersdao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> viewCustomer() async {
    var liste = await Customersdao().allCustomers();
    print("selam");
    for (Customer k in liste) {
      var totalPrice = double.parse(k.meter) * double.parse(k.meterprice);
      print("*********");
      print("customer name: ${k.namesurname}");
      print("customer name: ${k.phone}");
      print("customer name: ${k.meter}");
      print("customer name: ${k.meterprice}");
      print("customer name: ${k.brandcolor}");
      print("customer name: ${k.description}");

    }
  }

  Future<void> addCustomer(String name, String phone, String brand,
      String meter, String price, String description) async {
    await Customersdao()
        .addCustomer(name, phone, brand, meter, price, description);
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final brandController = TextEditingController();
  final meterController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  void _refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ceylan Parke'),
        leading: Icon(Icons.person),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AllCustomers(),
                  ),
                );              },
              icon: const Icon(Icons.view_list))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 60, 20, 100),
                child: Text(
                  "Müşteri bilgileri",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Ad Soyad'),
                onChanged: (value) {},
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(hintText: 'Telefon'),
                onChanged: (value) {},
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(hintText: 'Marka-Renk'),
                onChanged: (value) {},
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: meterController,
                decoration: const InputDecoration(hintText: 'Metrekare'),
                onChanged: (value) {},
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(hintText: 'Metrekare fiyatı'),
                onChanged: (value) {},
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Açıklama'),
                onChanged: (value) {},
                maxLines: 5,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      brandController.text.isEmpty ||
                      meterController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Uyarı',
                            style: TextStyle(color: Colors.red),
                          ),
                          content:
                              const Text('Lütfen tüm alanları doldurunuz.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Tamam'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    addCustomer(
                        nameController.text,
                        phoneController.text,
                        brandController.text,
                        meterController.text,
                        priceController.text,
                        descriptionController.text);
                    viewCustomer();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bilgi'),
                          content: const Text(
                              'Müşteri başarılı bir şekilde kaydedildi.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Tamam'),
                              onPressed: () {
                                nameController.text="";
                                phoneController.text="";
                                brandController.text="";
                                meterController.text="";
                                priceController.text="";
                                descriptionController.text="";

                                Navigator.of(context).pop();
                                _refreshPage();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Bilgileri Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
