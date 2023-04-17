import 'package:ceylan_mobile_app/AllCustomersPage.dart';
import 'package:ceylan_mobile_app/Customer.dart';
import 'package:ceylan_mobile_app/Customersdao.dart';
import 'package:ceylan_mobile_app/HomePage.dart';
import 'package:flutter/material.dart';
class CustomerDetail extends StatefulWidget {
  final Customer customer;

  const CustomerDetail({Key? key, required this.customer}) : super(key: key);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  Future<void> deleteCustomer() async {
    await Customersdao().deleteCustomer(widget.customer.customer_id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.namesurname),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Telefon: ${widget.customer.phone}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(color: Colors.grey,width: 350,height: 2,),
            const SizedBox(height: 10),
            Text('Marka ve Renk:  ${widget.customer.brandcolor}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(color: Colors.grey,width: 350,height: 2,),
            const SizedBox(height: 10),
            Text('Toplam metrekare:  ${widget.customer.meter}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(color: Colors.grey,width: 350,height: 2,),
            const SizedBox(height: 10),
            Text('1 Metrekare fiyatı:  ${widget.customer.meterprice}₺',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(color: Colors.grey,width: 350,height: 2,),
            const SizedBox(height: 10),
            Text('Toplam Tutar:  ${double.parse(widget.customer.meter)*double.parse(widget.customer.meterprice)}₺',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            Container(color: Colors.grey,width: 350,height: 2,),
            const SizedBox(height: 10),
            Text('Açıklama:  ${widget.customer.description}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
            // Diğer bilgileri de burada gösterebilirsiniz
            SizedBox(height: 50,),
            Row(
              children: [
                ElevatedButton(
                  child: Text('Düzenle'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String updatedName = widget.customer.namesurname;
                        String updatedPhone = widget.customer.phone;
                        String updatedBrandColor = widget.customer.brandcolor;
                        String updatedMeter = widget.customer.meter;
                        String updatedMeterPrice = widget.customer.meterprice;
                        String updatedDescription = widget.customer.description;
                        return AlertDialog(
                          title: Text('Bilgileri Düzenle'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Ad Soyad',
                                ),
                                onChanged: (text) {
                                  updatedName = text;
                                },
                                controller: TextEditingController(text: widget.customer.namesurname),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Telefon',
                                ),
                                onChanged: (text) {
                                  updatedPhone = text;
                                },
                                controller: TextEditingController(text: widget.customer.phone),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Marka ve Renk',
                                ),
                                onChanged: (text) {
                                  updatedBrandColor = text;
                                },
                                controller: TextEditingController(text: widget.customer.brandcolor),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Toplam metrekare',
                                ),
                                onChanged: (text) {
                                  updatedMeter = text;
                                },
                                controller: TextEditingController(text: widget.customer.meter),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: '1 Metrekare fiyatı',
                                ),
                                onChanged: (text) {
                                  updatedMeterPrice = text;
                                },
                                controller: TextEditingController(text: widget.customer.meterprice),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Açıklama',
                                ),
                                onChanged: (text) {
                                  updatedDescription = text;
                                },
                                controller: TextEditingController(text: widget.customer.description),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text('İptal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Kaydet'),
                              onPressed: () {
                                Customersdao().updateCustomer(widget.customer.customer_id,updatedName,updatedPhone,
                                    updatedBrandColor,updatedMeter,updatedMeterPrice,updatedDescription
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>  HomePage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  child: Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    deleteCustomer();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bilgi'),
                          content: const Text(
                              'Müşteri bilgileri başarılı bir şekilde silindi.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Tamam'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AllCustomers(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
