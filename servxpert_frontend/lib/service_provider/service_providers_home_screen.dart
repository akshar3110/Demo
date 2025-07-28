import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servxpert_frontend/jobApp/otp_verification.dart';
import 'package:servxpert_frontend/jobApp/reject_job.dart';
import '../widgets/bottom_navbar.dart';
import 'package:servxpert_frontend/auth/auth_service.dart';
import 'package:servxpert_frontend/userApp/Customers_home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:servxpert_frontend/services/account_status_service.dart';

class ServiceProvidersHomeScreen extends StatefulWidget {
  const ServiceProvidersHomeScreen({super.key});

  @override
  State<ServiceProvidersHomeScreen> createState() =>
      _ServiceProvidersHomeScreenState();
}

class _ServiceProvidersHomeScreenState
    extends State<ServiceProvidersHomeScreen> {
  List<Map<String, String>> serviceRequests = [
    {
      'order_id': '12345681',
      'title': 'Kitchen Cleaning Service 1',
      'address': 'Panjrapole, IIM Road, Nehrunagar, Ahmedabad 380015',
      'date': '29 March',
      'time': '7:00 PM'
    },
    {
      'order_id': '12345682',
      'title': 'Kitchen Cleaning Service 2',
      'address': 'Panjrapole, IIM Road, Nehrunagar, Ahmedabad 380015',
      'date': '29 March',
      'time': '7:30 PM'
    },
  ];

  List<Map<String, dynamic>> pendingRequests = [];
  List<Map<String, dynamic>> ongoingOrders = [];
  final _secureStorage = const FlutterSecureStorage();

  // Function to switch back to customer account using AccountStatusService
  Future<void> _switchToCustomer() async {
    try {
      final success = await AccountStatusService.switchToCustomerWithFlow(context);
      
      if (!success) {
        // The service already handles error messages
        print("Failed to switch to customer account");
      }
    } catch (e) {
      print("❌ Error switching to customer: $e");
      Fluttertoast.showToast(
        msg: "An error occurred while switching accounts",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              height: 130,
              color: Color(0xFF506C5C),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile button with account switching
                  GestureDetector(
                    onTap: _switchToCustomer,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_2_outlined, color: Colors.black),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Current Location',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Fredoka')),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.white, size: 14),
                          Text('Ahmedabad, Gujarat',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily: 'Fredoka')),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.notifications_none_outlined,
                        color: Colors.black),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Text('Services Booked',
                  style: TextStyle(fontSize: 14)),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFCDD4DA)),
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'New Requests'),
                  Tab(text: 'Pendings'),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  // TAB 1 - New Requests
                  ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: serviceRequests.length,
                    itemBuilder: (context, index) {
                      final request = serviceRequests[index];
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return true;
                        },
                        onDismissed: (direction) {
                          if (index >= serviceRequests.length) return;

                          final dismissedItem = serviceRequests[index];
                          final now = DateTime.now();
                          final formattedTime =
                          DateFormat('hh:mm a').format(now);

                          if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              pendingRequests.add({
                                'order_id': dismissedItem['order_id'],
                                'title': dismissedItem['title'],
                                'address': dismissedItem['address'],
                                'dateTime': now,
                                'statuses': [
                                  {
                                    'label': 'Requested',
                                    'formattedTime': dismissedItem['time'],
                                  },
                                  {
                                    'label': 'Accepted',
                                    'formattedTime': formattedTime,
                                  },
                                ],
                              });
                              serviceRequests.removeAt(index);
                            });

                            DefaultTabController.of(context).animateTo(1);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Accepted'),
                                  backgroundColor: Colors.green),
                            );
                          } else if (direction == DismissDirection.endToStart) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RejectJob()),
                            );

                            setState(() {
                              if (index < serviceRequests.length) {
                                serviceRequests.removeAt(index);
                              }
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFCDD4DA)),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(request['title'] ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(height: 5),
                              Text(request['address'] ?? '',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Request',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(formattedDate,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(formattedTime,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // TAB 2 - Pendings
                  ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: pendingRequests.length,
                    itemBuilder: (context, index) {
                      final pendingItem = pendingRequests[index];
                      final item = {
                        'order_id': pendingItem['order_id'],
                        'service': pendingItem['title'],
                        'address': pendingItem['address'],
                        'status': 'Accepted',
                        'date': pendingItem['dateTime'],
                        'amount': 500,
                      };

                      return GestureDetector(
                          onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => BookingDetail(booking: item),
                        //   ),
                        // );
                      },
                      child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFCDD4DA)),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['service'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            SizedBox(height: 2),
                            Text(item['address'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item['status'],
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: pendingItem['statuses']
                                      .map<Widget>((status) {
                                    return Row(
                                      children: [
                                        Text(status['label'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                        SizedBox(width: 10),
                                        Text(status['formattedTime'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OtpVerificationCloseJob(
                                          jobItem: item,
                                          onCloseJob: () {
                                            setState(() {
                                              pendingRequests.removeAt(index);
                                              ongoingOrders.add({
                                                ...item,
                                                'status': 'Closed',
                                                'date': DateTime.now(),
                                              });
                                            });

                                            // Navigator.pushReplacement(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (_) => MyBookings(
                                            //       allBookings: ongoingOrders,
                                            //       initialTabIndex: 2,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.red),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Close Job',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SansSerif',
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OtpVerificationStartWorking(
                                              jobItem: item,
                                              onStartWork: () {
                                                setState(() {
                                                  pendingRequests.removeAt(index);
                                                  ongoingOrders.add({
                                                    ...item,
                                                    'status': 'On Going',
                                                    'date': DateTime.now(),
                                                  });
                                                });

                                                // Navigator.pushReplacement(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (_) => MyBookings(
                                                //       allBookings: ongoingOrders,
                                                //       initialTabIndex: 0,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    backgroundColor: Colors.white,
                                    side: BorderSide(color: Colors.green),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'Start Work',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SansSerif',
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFFCDD4DA)),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  // open location
                                },
                                child: Text(
                                  'Get Location',
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    color: Colors.blue,
                                  ),
                                ),
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
          ],
        ),
      ),

    );
  }
}
