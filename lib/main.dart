import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CoworkingHome(),
      title: "Aluguel de Salas de Coworking",
    );
  }
}

// Coworking Home Screen

class CoworkingHome extends StatelessWidget {
  const CoworkingHome({super.key});

  // Custom Style Text
  static const TextStyle customStyleHeader =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle customStyle =
      TextStyle(fontSize: 16, decoration: TextDecoration.underline);
  static const imageUrlProps =
      "https://coworkingbrasil.org/wp-content/uploads/cache/2021/09/WhatsApp-Image-2021-09-30-at-11_54_12-1/2389376907.jpeg";

  @override
  Widget build(BuildContext context) {
    // Screen Dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aluguel de Salas de Coworking'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        backgroundColor: Colors.green,
        child: ListView(
          children: const [
            ListTile(
              title: Text('Opção 1'),
            ),
            ListTile(
              title: Text('Opção 2'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Olá, reserve sua sala agora',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                CoworkingRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Sala 1",
                  address: "Av. Exemplo, 123",
                  capacity: "10 pessoas",
                  price: "R\$ 50,00/hora",
                ),
                CoworkingRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Sala 2",
                  address: "Rua Amostra, 456",
                  capacity: "8 pessoas",
                  price: "R\$ 40,00/hora",
                ),
                CoworkingRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Sala 3",
                  address: "Praça Teste, 789",
                  capacity: "12 pessoas",
                  price: "R\$ 60,00/hora",
                ),
                CoworkingRoomCard(
                  imageUrl: imageUrlProps,
                  roomName: "Sala 4",
                  address: "Av. Exemplo, 123",
                  capacity: "10 pessoas",
                  price: "R\$ 50,00/hora",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoworkingRoomCard extends StatelessWidget {
  final String imageUrl;
  final String roomName;
  final String address;
  final String capacity;
  final String price;

  const CoworkingRoomCard({
    Key? key,
    required this.imageUrl,
    required this.roomName,
    required this.address,
    required this.capacity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.4,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(roomName, style: CoworkingHome.customStyleHeader),
                  const SizedBox(height: 8),
                  Text("Endereço: $address", style: CoworkingHome.customStyle),
                  const SizedBox(height: 8),
                  Text("Capacidade: $capacity",
                      style: CoworkingHome.customStyle),
                  const SizedBox(height: 8),
                  Text("Preço: $price", style: CoworkingHome.customStyle),
                  const SizedBox(height: 12),
                  const BookingButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingButton extends StatefulWidget {
  const BookingButton({super.key});

  @override
  _BookingButtonState createState() => _BookingButtonState();
}

class _BookingButtonState extends State<BookingButton> {
  bool _isBooked = false;

  void _toggleBooking() {
    setState(() {
      _isBooked = !_isBooked;
    });
    final message = _isBooked ? 'Reserva realizada!' : 'Reserva cancelada!';
    _showAlert(context, 'Reserva', message);
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleBooking,
      child: Text(_isBooked ? 'Cancelar Reserva' : 'Reservar Agora'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isBooked ? Colors.red : Colors.green,
      ),
    );
  }
}
