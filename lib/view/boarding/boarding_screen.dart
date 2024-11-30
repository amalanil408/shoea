import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoea/util/constant.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _boardingData = [
    {
      'image': 'assets/img/boarding_1.jpg',
      'text': 'We provide high quality products just for you',
    },
    {
      'image': 'assets/img/boarding_2.jpg',
      'text': 'Your satisfaction is our number one priority',
    },
    {
      'image': 'assets/img/boarding_3.jpg',
      'text': "Let's fulfill your fashion needs with Shoea right now!",
    },
  ];

  void _onNext() {
    if (_currentPage < _boardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkip(); 
    }
  }

  void _onSkip() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _boardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _boardingData[index]['image']!,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _boardingData[index]['text']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _boardingData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 10,
                width: _currentPage == index ? 20 : 10,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _onSkip,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  child: Text(
                    _currentPage == _boardingData.length - 1
                        ? 'Finish'
                        : 'Next',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}


