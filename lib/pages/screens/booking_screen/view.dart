import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/pages/screens/booking_screen/card_view.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

class BookingView extends GetView<BookingController> {
  String tourId;
  String name;
  String phoneNumber;

   BookingView({required this.tourId,
     required this.name,
     required this.phoneNumber,
     Key? key}) : super(key: key);
   final controller = Get.put<BookingController>(BookingController());
  String? _selectedMonth;
  String? _selectedPersons;
  final _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  final _persons = ["1", "2", "3", "4","5", "6","7","8","9","10"];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    nameController.text=name.toString();
    phoneController.text=phoneNumber.toString();
     return Scaffold(
       backgroundColor: Colors.white,
       // appBar: AppBar(title: Text('Booking Page')),
       body: SafeArea(
         child: Container(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: ListView(
               children: [
                 Image.asset('assets/images/booking.jpg'),
                 SizedBox(height: 16),
                 TextField(
                   // controller: controller.state.nameController,
                   controller: nameController,
                   decoration: InputDecoration(labelText: 'Name'),
                 ),
                 SizedBox(height: 16),
                 TextField(
                   // controller: controller.state.phoneController,
                   controller: phoneController,
                   decoration: InputDecoration(labelText: 'Phone Number'),
                   keyboardType: TextInputType.phone,
                 ),
                 SizedBox(height: 16),
                 Obx((){
                   return DropdownButton<String>(
                     isExpanded: true,
                     hint: Text(controller.state.personString.value),
                     value: _selectedPersons,
                     onChanged: (String? value) {
                       controller.state.personString.value=value!;
                     },
                     items: _persons.map((String value) {
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                       );
                     }).toList(),
                   );
                 }),
                 SizedBox(height: 16),
                 Obx((){
                   return DropdownButton<String>(
                     isExpanded: true,
                     hint: Text(controller.state.monthString.value),
                     value: _selectedMonth,
                     onChanged: (String? value) {
                       controller.state.monthString.value=value!;
                     },
                     items: _months.map((String value) {
                       return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value),
                       );
                     }).toList(),
                   );
                 }),
                 SizedBox(height: 32.h),
                 ElevatedButton(
                   onPressed: () async{
                     await controller.fetchDetails(tourId);
                     final booking = BookingModel(
                         uid: controller.state.uid,
                         name: name,
                         phoneNumber: phoneNumber,
                         CompanyName: controller.state.companyName,
                         CompanyId: controller.state.companyId,
                         tourTitle: controller.state.tourTitle,
                         tourId: tourId,
                         pricePerPerson: controller.state.pricePerPerson,
                         tourImage: controller.state.tourImgae,
                     );
                     controller.addBookings(booking);
                     // Handle booking logic here
                   },
                   child: Text('Book Now'),
                 ),

                 SizedBox(height: 10.h),
                 ElevatedButton(
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Colors.green),
                   ),
                   onPressed: () {
                    Get.to(() => PaymentView(),);
                     // Handle booking logic here
                   },
                   child: Text('Your Cards'),
                 ),
               ],
             ),
           ),
         ),
       ),
     );
  }
}
