import 'package:ceylan_mobile_app/CustomerDetailPage.dart';
import 'package:ceylan_mobile_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:ceylan_mobile_app/Customer.dart';
import 'package:ceylan_mobile_app/Customersdao.dart';

class AllCustomers extends StatefulWidget {
  const AllCustomers({Key? key}) : super(key: key);

  @override
  State<AllCustomers> createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  late List<Customer> _customerList = [];
  late List<Customer> _filteredCustomerList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCustomers();
  }

  Future<void> _getCustomers() async {
    List<Customer> customers = await Customersdao().allCustomers();
    setState(() {
      _customerList = customers;
      _filteredCustomerList = customers;
    });
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _filteredCustomerList = _customerList.where((customer) =>
          customer.namesurname.toLowerCase().contains(searchText.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteriler'),
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }, icon: Icon(Icons.keyboard_arrow_left)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchTextChanged,
              decoration: InputDecoration(
                  hintText: 'Müşteri ismi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: _filteredCustomerList.length,
                itemBuilder: (BuildContext context, int index) {
                  Customer customer = _filteredCustomerList[index];
                  return Card(
                    child: ListTile(
                      title: Text(customer.namesurname),
                      subtitle: Text(customer.phone),
                      trailing: IconButton(
                        icon: Icon(Icons.info_rounded),
                        color: Colors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomerDetail(customer: customer)),
                          );
                        },
                      ),
                      onTap: () {
                        // kartın kendisine tıklanınca yapılacak işlemi burada yazabilirsiniz
                      },
                    ),
                  );
                },
              ),
          )
        ],
      ),
    );
  }
}
