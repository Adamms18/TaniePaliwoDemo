import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// CityScreen widget
class CityScreen extends StatelessWidget {
  final String cityName;
  const CityScreen({super.key, required this.cityName});

  // Simple coordinates for some cities
  static final Map<String, LatLng> cityCoordinates = {
    'Warszawa': LatLng(52.2297, 21.0122),
    'Kraków': LatLng(50.0647, 19.9450),
    'Wrocław': LatLng(51.1079, 17.0385),
    'Poznań': LatLng(52.4064, 16.9252),
    'Gdańsk': LatLng(54.3520, 18.6466),
    'Szczecin': LatLng(53.4285, 14.5528),
    'Łódź': LatLng(51.7592, 19.4550),
    'Katowice': LatLng(50.2649, 19.0238),
    'Lublin': LatLng(51.2465, 22.5684),
    'Bydgoszcz': LatLng(53.1235, 18.0084),
    'Białystok': LatLng(53.1325, 23.1688),
    'Rzeszów': LatLng(50.0412, 21.9991),
    'Toruń': LatLng(53.0138, 18.5984),
    'Opole': LatLng(50.6751, 17.9213),
    'Gdynia': LatLng(54.5189, 18.5305),
    'Częstochowa': LatLng(50.8118, 19.1203),
  };

  @override
  Widget build(BuildContext context) {
    final LatLng? cityLatLng = cityCoordinates[cityName];

    return Scaffold(
      appBar: AppBar(
        title: Text(cityName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (cityLatLng != null)
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: cityLatLng,
                    initialZoom: 12,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.apka1',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: cityLatLng,
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(Icons.info),
                    title: Text('Placeholder ${index + 1}'),
                    subtitle: const Text('Szczegóły...'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _cities = [
    'Warszawa',
    'Kraków',
    'Wrocław',
    'Poznań',
    'Gdańsk',
    'Szczecin',
    'Łódź',
    'Katowice',
    'Lublin',
    'Bydgoszcz',
    'Białystok',
    'Rzeszów',
    'Toruń',
    'Opole',
    'Gdynia',
    'Częstochowa',
  ];

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredCities = _cities
        .where((city) => city.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Szukaj miasta',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Card(
            color: Colors.blue.shade50,
            child: ListTile(
              leading: const Icon(Icons.my_location, color: Colors.blue),
                title: const Text(
                'Wyszukaj za pomocą lokalizacji',
                style: TextStyle(color: Colors.black),
                ),
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const CityScreen(cityName: 'Warszawa'), // Placeholder
                ),
              );
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCities.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(filteredCities[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityScreen(cityName: filteredCities[index]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}