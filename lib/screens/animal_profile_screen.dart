import 'package:flutter/material.dart';
import 'home_screen.dart';

class AnimalProfileScreen extends StatelessWidget {
  const AnimalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // **BACKGROUND IMAGE WITH LOW OPACITY**
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust opacity to match design
              child: Image.asset(
                "assets/images/bear.jpg", // Ensure correct path
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            children: [
              // **APP BAR STYLE HEADER**
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Color(0xFF9A5525),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    HomeScreen(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              final offsetAnimation = Tween<Offset>(
                                begin: Offset(-1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.person, color: Colors.white, size: 30),
                  ],
                ),
              ),

              // **ANIMAL PROFILE CONTENT**
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    // **MAIN ANIMAL IMAGE (LEFT SIDE)**
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "assets/images/bear.jpg",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15),

                    // **TEXT DESCRIPTION**
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: Black Bear\n"
                            "Category: Mammal\n"
                            "Threat: Moderate\n"
                            "Behavior: Nocturnal\n"
                            "Range: 5 Meters",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // **PRECAUTIONS SECTION**
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF9A5525),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Precautions!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "• Never approach a black bear, especially if cubs are present.\n"
                          "• Avoid direct eye contact as it can be perceived as a threat.\n"
                          "• Speak in a calm, firm voice and slowly back away.\n"
                          "• Do not run—sudden movements can trigger a chase response.\n"
                          "• Store food properly to avoid attracting bears to your location.\n"
                          "• If a bear stands on its hind legs, it is trying to identify you, not attack.\n"
                          "• In case of an aggressive encounter, use bear spray and make yourself appear larger.\n"
                          "• Play dead only if a black bear is defensive (protecting cubs). If it is stalking, fight back aggressively.\n"
                          "• Store food properly to avoid attracting bears to your location.\n"
                          "• If a bear stands on its hind legs, it is trying to identify you, not attack.\n",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
