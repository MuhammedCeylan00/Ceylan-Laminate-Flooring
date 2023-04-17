import 'package:ceylan_mobile_app/Customer.dart';
import 'package:ceylan_mobile_app/DatabaseAssistans.dart';

class Customersdao{

  Future<List<Customer>> allCustomers() async {
    var db = await DatabaseAssistans.databaseAccess();

    List<Map<String,dynamic>> maps = await db.query("Customers");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Customer(row["customer_id"], row["namesurname"], row["brandcolor"], row["meter"], row["meterprice"], row["description"],row["phone"]);
    });
  }

  Future<void> addCustomer(String customerName,String phone, String brand , String meter, String meterPrice,String description) async {
    var db = await DatabaseAssistans.databaseAccess();

    var infos = Map <String ,dynamic>();
    infos["namesurname"] = customerName;
    infos["phone"] = phone;
    infos["brandcolor"] = brand;
    infos["meter"] = meter;
    infos["meterprice"] = meterPrice;
    infos["description"] = description;

    await db.insert("Customers", infos);

  }

  Future<void> deleteCustomer(int customerId) async {
    var db = await DatabaseAssistans.databaseAccess();

    await db.delete("Customers",where: "customer_id=?",whereArgs: [customerId]);
  }

  Future<void> updateCustomer(int customerId,String customerName,String phone, String brand , String meter, String meterPrice,String description) async {
    var db = await DatabaseAssistans.databaseAccess();

    var infos = Map <String ,dynamic>();
    infos["namesurname"] = customerName;
    infos["phone"] = phone;
    infos["brandcolor"] = brand;
    infos["meter"] = meter;
    infos["meterprice"] = meterPrice;
    infos["description"] = description;

    await db.update("Customers",infos,where: "customer_id=?",whereArgs: [customerId]);
  }
}
