import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9A5525), // Matching theme color
      appBar: AppBar(
        title: Text("About Us", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF7A3E1D), // Darker shade for contrast
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildHeader(),
            SizedBox(height: 20),
            _buildProfileCard(
              name: "Hammad Imtiaz",
              role: "Frontend Developer | Software Engineer",
              imagePath: "assets/images/hammad.png", // Add Image Later
            ),
            _buildProfileCard(
              name: "Ramsha Abid",
              role: "UI/UX Designer | Software Engineer",
              imagePath: "assets/images/ramsha.png", // Add Image Later
            ),
            _buildProfileCard(
              name: "Sayyab Nadeem",
              role: "Backend Developer | Software Engineer",
              imagePath: "assets/images/sayyab.png", // Add Image Later
            ),
            _buildProfileCard(
              name: "Ma’am Pakiza Amin",
              role: "Project Supervisor",
              imagePath: "assets/images/supervisor.png", // Add Image Later
            ),
            SizedBox(height: 30),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // **Header Section**
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            "Welcome to Wild Guard",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Developed as a Final Year Design Project (FYDP) at HITEC University.",
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // **Profile Card**
  Widget _buildProfileCard({
    required String name,
    required String role,
    required String imagePath,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath), // Placeholder image
            backgroundColor: Colors.white,
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            role,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ),
    );
  }

  // **Footer Section**
  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        "This app is developed to enhance wildlife monitoring and protection.",
        style: TextStyle(fontSize: 14, color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }
}
