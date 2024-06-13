import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _hasNewNotifications = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFEFEF),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: const Color(0xFF564FA1),
                  padding: const EdgeInsets.only(top: 50, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications, color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => SecondScreen())
                                ).then((_) {
                                  setState(() {
                                    _hasNewNotifications = false;
                                  });
                                });
                              },
                            ),
                            if (_hasNewNotifications)
                              Positioned(
                                right: 11,
                                top: 11,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD4B150),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFF564FA1),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Column(
                  children: [
                    TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Color(0xFFD4B150), width: 4.0),
                      ),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Color(0xFFD4B150),
                      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: 'Received'),
                        Tab(text: 'Sent'),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: TabBarView(
                          children: [
                            NotificationsList(type: 'Received'),
                            Center(child: Text('No Sent Notifications')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  final String type;

  const NotificationsList({Key? key, required this.type}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final previousTransaction = index > 0 ? transactions[index - 1] : null;
        final bool isNewDate = previousTransaction == null || previousTransaction['date'] != transaction['date'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isNewDate)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  transaction['date']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction ID: ${transaction['transactionId']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Date: ${transaction['date']} : ${transaction['time']}'),
                  Text('Amount: ${transaction['amount']}'),
                  Text('Status: ${transaction['status']}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text('This is the second screen.'),
      ),
    );
  }
}
const List<Map<String, String>> transactions = [
  {
    'date': 'May 28, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  {
    'date': 'May 24, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  {
    'date': 'May 24, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  {
    'date': 'May 26, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  {
    'date': 'May 27, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  {
    'date': 'May 29, 2024',
    'transactionId': '1234567890',
    'time': '08:00 am',
    'amount': '\$2,500.00',
    'status': 'Successful'
  },
  // Add more transactions if needed
];
