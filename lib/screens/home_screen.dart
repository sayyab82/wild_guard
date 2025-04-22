import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'passive_track_screen.dart';
import 'profile_screen.dart';
import 'animal_profile_screen.dart';
import 'alert_screen.dart';
import 'feedback_screen.dart';
import 'about_us_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late final AnimationController _animationController;

  final String tipText =
      "When encountering a wild animal, remain calm, avoid sudden movements, and do not make direct eye contact. "
      "Sudden actions may be perceived as a threat. Back away slowly while maintaining a safe distance.";

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8), // Adjust duration to control speed
    );

    // Define the animation loop
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    // Start the animation and repeat it
    _animationController.forward().whenComplete(() {
      _animationController.repeat();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // App Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color(0xFF9A5525),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMenuOpen = !isMenuOpen;
                          });
                        },
                        child: Icon(Icons.menu, color: Colors.white, size: 30),
                      ),
                      Text(
                        "Wild Guard",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                // Hero Image with Animated Tip
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/Lion.png",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                        ),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            final double offset =
                                60 *
                                _animationController
                                    .value; // Adjust the value for different speed
                            return Transform.translate(
                              offset: Offset(0, -offset), // Move text upwards
                              child: Text(
                                tipText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                // Button Grid
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(color: Color(0xFF9A5525)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMenuItem(
                                "Alerts",
                                Icons.notifications,
                                context,
                                AlertScreen(),
                              ),
                              _buildMenuItem(
                                "Passive Track",
                                Icons.track_changes,
                                context,
                                PassiveTrackScreen(),
                              ),
                              _buildMenuItem(
                                "Live Track",
                                Icons.location_on,
                                context,
                                CameraScreen(),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMenuItem(
                                "Reports",
                                Icons.assignment,
                                context,
                                null,
                              ),
                              _buildMenuItem(
                                "Feedback",
                                Icons.thumb_up,
                                context,
                                FeedbackScreen(),
                              ),
                              _buildMenuItem(
                                "Profile",
                                Icons.account_circle,
                                context,
                                AnimalProfileScreen(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Custom Menu Overlay
        if (isMenuOpen) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMenuOpen = false;
                });
              },
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Material(
              color: Color(0xFF9A5525),
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuOption(
                      "User Profile",
                      Icons.person,
                      ProfileScreen(),
                    ),
                    _buildMenuOption(
                      "Live Track",
                      Icons.location_on,
                      CameraScreen(),
                    ),
                    _buildMenuOption(
                      "Alerts",
                      Icons.notifications,
                      AlertScreen(),
                    ),
                    _buildMenuOption(
                      "Animal Profile",
                      Icons.pets,
                      AnimalProfileScreen(),
                    ),
                    _buildMenuOption("Reports", Icons.assignment, null),
                    _buildMenuOption("About Us", Icons.info, AboutUsScreen()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMenuOption(String title, IconData icon, Widget? route) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        }
        setState(() {
          isMenuOpen = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String label,
    IconData icon,
    BuildContext context,
    Widget? route,
  ) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
