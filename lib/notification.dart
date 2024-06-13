import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _hasNewNotifications = true;
  late IO.Socket socket;
  List<Map<String, String>> transactions = [];

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io('https://qr-based-mobile-wallet.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected to the server');
    });

    socket.on('payment_completed', (data) {
      setState(() {
        transactions.add({
          'date': data['date'],
          'transactionId': data['transactionId'],
          'time': data['time'],
          'amount': '\$${data['amount']}',
          'status': data['status']
        });
        _hasNewNotifications = true;
      });
    });

    socket.on('disconnect', (_) {
      print('Disconnected from the server');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

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
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4B150),
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
                child: Column(
                  children: [
                    const TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(color: Color(0xFFD4B150), width: 4.0),
                      ),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Color(0xFFD4B150),
                      tabs: [
                        Tab(text: 'Transaction'),
                        Tab(text: 'Payment'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          transactions.isEmpty
                              ? const Center(child: Text('No transactions'))
                              : ListView.builder(
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction = transactions[index];
                                    return ListTile(
                                      title: Text('Transaction ID: ${transaction['transactionId']}'),
                                      subtitle: Text('Date: ${transaction['date']} \nTime: ${transaction['time']} \nAmount: ${transaction['amount']} \nStatus: ${transaction['status']}'),
                                    );
                                  },
                                ),
                          const Center(child: Text('Payment Page')),
                        ],
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

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text('Second Screen Content'),
      ),
    );
  }
}
