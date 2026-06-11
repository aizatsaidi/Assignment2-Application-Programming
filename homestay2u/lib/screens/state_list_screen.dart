import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homestay_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class StateListScreen extends StatefulWidget {
  const StateListScreen({super.key});

  @override
  State<StateListScreen> createState() => _StateListScreenState();
}

class _StateListScreenState extends State<StateListScreen> {
  List<Map<String, dynamic>> states = [];
  bool isLoading = true;
  String errorMessage = '';

  final Map<String, Color> stateColors = {
    'Johor': const Color(0xFFE53935),
    'Kedah': const Color(0xFF8E24AA),
    'Kelantan': const Color(0xFF00897B),
    'Melaka': const Color(0xFFD81B60),
    'Negeri Sembilan': const Color(0xFF6D4C41),
    'Pahang': const Color(0xFF3949AB),
    'Perak': const Color(0xFF00ACC1),
    'Perlis': const Color(0xFFE91E63),
    'Pulau Pinang': const Color(0xFF1E88E5),
    'Sabah': const Color(0xFF43A047),
    'Sarawak': const Color(0xFFFB8C00),
    'Selangor': const Color(0xFFEF5350),
    'Terengganu': const Color(0xFF7CB342),
    'Kuala Lumpur': const Color(0xFF546E7A),
  };

  final Map<String, String> stateImages = {
    'Johor': 'assets/images/Johor.jpg',
    'Kedah': 'assets/images/Kedah.jpeg',
    'Kelantan': 'assets/images/Kelantan.png',
    'Melaka': 'assets/images/Melaka.jpg',
    'Negeri Sembilan': 'assets/images/Negeri_Sembilan.jpg',
    'Pahang': 'assets/images/Pahang.jpg',
    'Perak': 'assets/images/Perak.jpg',
    'Perlis': 'assets/images/Perlis.jpg',
    'Pulau Pinang': 'assets/images/Pulau_Pinang.webp',
    'Sabah': 'assets/images/Sabah.jpg',
    'Sarawak': 'assets/images/Sarawak.jpg',
    'Selangor': 'assets/images/Selangor.webp',
    'Terengganu': 'assets/images/Terengganu.webp',
    'Kuala Lumpur': 'assets/images/Kuala_Lumpur.jpeg',
  };

  @override
  void initState() {
    super.initState();
    fetchStates();
  }

  Future<void> fetchStates() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse('http://slum78.myddns.me/homestay2u/api/states'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        setState(() {
          states = data.map((item) => Map<String, dynamic>.from(item)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to connect. Check your internet connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(errorMessage, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchStates,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    // Hero header
                    SliverAppBar(
                        expandedHeight: 180,
                        pinned: true,
                        backgroundColor: const Color(0xFF6A11CB),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(28),
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Homestay2U Malaysia',
                          style: GoogleFonts.pacifico(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(28),
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Icon(
                                    Icons.home_work,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                SizedBox(height: 8),
                                Text(
                                  'Discover Malaysian Homestays',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomestayListScreen(
                                    state: 'All',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.list, color: Colors.white),
                            label: const Text(
                              'View All',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Subtitle
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Row(
                          children: [
                            const Text(
                              'Select a State',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${states.length} states)',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // State grid
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.4,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final s = states[index];
                            final color = stateColors[s['state']] ?? Colors.teal;
                            final image = stateImages[s['state']] ?? '';
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomestayListScreen(
                                      state: s['state'],
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      // Background image
                                      Image.asset(
                                        image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(color: color),
                                      ),
                                      // Dark overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.65),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Text on top
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              s['state'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '${s['total']} homestays',
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            );
                          },
                          childCount: states.length,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],
                ),
    );
  }
}