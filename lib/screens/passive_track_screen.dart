import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';

class PassiveTrackScreen extends StatefulWidget {
  const PassiveTrackScreen({super.key});

  @override
  _PassiveTrackScreenState createState() => _PassiveTrackScreenState();
}

class _PassiveTrackScreenState extends State<PassiveTrackScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _toggleAnimation() {
    setState(() {
      isAnimating = !isAnimating;
      if (isAnimating) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.reset(); // Stop and reset animation
      }
    });
  }

  // **Method to Open Camera**
  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // **TOP NAVIGATION BAR**
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Color(0xFF9A5525),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  key: Key('backButton'), // Add a key to the back button
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
                  "P-Track",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.person, color: Colors.white, size: 30),
              ],
            ),
          ),

          // **NOTIFICATIONS SECTION**
          Expanded(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                _buildNotification(
                  "Black Deer Detected!",
                  "A black deer has been detected in the area. Stay cautious.",
                ),
                _buildNotification(
                  "Jackal Detected!",
                  "A jackal has been spotted nearby. Maintain a safe distance.",
                ),
                _buildNotification(
                  "Leopard Spotted!",
                  "A leopard has been seen in the vicinity. Avoid sudden movements.",
                ),
                _buildNotification(
                  "Wild Boar Nearby!",
                  "A wild boar has been detected. Do not provoke and stay calm.",
                ),
              ],
            ),
          ),

          // **SENSOR & GO BUTTON SECTION**
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF9A5525),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Activate Sensors!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),

                  // **GO Button with Animation**
                  GestureDetector(
                    key: Key('goButton'), // Add a key to the "GO" button
                    onTap: _toggleAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: EdgeInsets.all(50), // Increased Button Size
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: Text(
                          isAnimating ? "STOP" : "GO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // **Camera Open Option (Now Clickable)**
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      children: [
                        TextSpan(text: "Not detected? Open "),
                        WidgetSpan(
                          child: GestureDetector(
                            key: Key(
                              'cameraButton',
                            ), // Add a key to the camera link
                            onTap: _openCamera,
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // **Notification Card Widget**
  Widget _buildNotification(String title, String message) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(message, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
