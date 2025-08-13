import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/pages/login.dart';
import 'package:taskify/service/auth_service.dart';
import 'package:taskify/shared/images.dart';
import 'package:taskify/shared/style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      final result = await AuthService().getCurrentUser();
      setState(() {
        userData = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);

      final error = e is Exception
          ? e.toString().replaceFirst("Exception: ", "")
          : e.toString();

      if (error.contains("Unauthorized") || error.contains("Token Expired")) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('tokenAuth');

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tokenAuth');

    // keluar dari semua stack, termasuk PersistentTabView
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            child: Image.asset(
              background_plain,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              semanticLabel: 'Background Image',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userData?['image'] ?? ''),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${userData?['firstName'] ?? ''} ${userData?['lastName'] ?? ''}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userData?['email'] ?? '',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor.withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              userData?['company']['title'] ?? '-',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: mainColor.withOpacity(0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departement',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: secondaryColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            userData?['company']['department'] ?? '-',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 30),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                        color: white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionTile(
                          title: Text(
                            'Personal Details',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            _buildDetailRow(
                                'First Name', userData?['firstName']),
                            _buildDetailRow('Last Name', userData?['lastName']),
                            _buildDetailRow(
                                'Maiden Name', userData?['maidenName']),
                            _buildDetailRow('Age', '${userData?['age']}'),
                            _buildDetailRow('Gender', userData?['gender']),
                            _buildDetailRow(
                                'Birth Date', userData?['birthDate']),
                            _buildDetailRow(
                                'Blood Group', userData?['bloodGroup']),
                          ],
                        ),
                        SizedBox(height: 10),
                        ExpansionTile(
                          title: Text(
                            'Contact Information',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            _buildDetailRow('Email', userData?['email']),
                            _buildDetailRow('Phone', userData?['phone']),
                            _buildDetailRow('Address',
                                '${userData?['address']?['address']}, ${userData?['address']?['city']}, ${userData?['address']?['state']}, ${userData?['address']?['postalCode']}, ${userData?['address']?['country']}'),
                            _buildDetailRow('MAC', userData?['macAddress']),
                          ],
                        ),
                        SizedBox(height: 10),
                        ExpansionTile(
                          title: Text(
                            'Work Details',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            _buildDetailRow(
                                'Company', userData?['company']?['name']),
                            _buildDetailRow('Department',
                                userData?['company']?['department']),
                            _buildDetailRow(
                                'Title', userData?['company']?['title']),
                            _buildDetailRow('Company Address',
                                '${userData?['company']?['address']?['address']}, ${userData?['company']?['address']?['city']}, ${userData?['company']?['address']?['state']}'),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity, // otomatis penuh lebar
                  child: ElevatedButton(
                    onPressed: () => _logout(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: secondaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14), // atur tinggi
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '-',
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
