import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data profil
  String name = 'M. Ulil Abror';
  String bio =
      'Mahasiswa Sistem Informasi yang memiliki minat dan fokus dalam bidang Mobile Programming.'
      'Memiliki kemampuan dalam pengembangan aplikasi mobile menggunakan Flutter serta memahami dasar-dasar UI/UX, integrasi API, dan manajemen data.'
      'Aktif belajar dan mengembangkan proyek aplikasi untuk meningkatkan keterampilan teknis.';
  String location = 'Jakarta, Indonesia';
  String email = 'jhon.doe@example.com';
  String phone = '+62 123-4567-2292';
  String birthday = 'March 15, 2000';
  String occupation = 'Mobile Programmer at Universitas Pamulang';

  // Support both network URL and local file
  String? avatarUrl;
  File? avatarFile;

  //Data Skills
  List<String> skills = ['Flutter', 'UI/UX Design', 'Laravel', 'Figma', 'SQL'];
  Map<String, Color> skillColors = {
    'Flutter': Colors.blue,
    'UI/UX Design': Colors.purple,
    'Laravel': Colors.deepOrangeAccent,
    'Figma': Colors.pink,
    'SQL': Colors.green,
  };

  void _updateProfile(Map<String, dynamic> updatedData) {
    setState(() {
      if (updatedData['name'] != null) name = updatedData['name'];
      if (updatedData['bio'] != null) bio = updatedData['bio'];
      if (updatedData['location'] != null) location = updatedData['location'];
      if (updatedData['email'] != null) email = updatedData['email'];
      if (updatedData['phone'] != null) phone = updatedData['phone'];
      if (updatedData['birthday'] != null) birthday = updatedData['birthday'];
      if (updatedData['occupation'] != null)
        occupation = updatedData['occupation'];
      if (updatedData['avatarUrl'] != null)
        avatarUrl = updatedData['avatarUrl'];
      if (updatedData['avatarFile'] != null)
        avatarFile = updatedData['avatarFile'];
      if (updatedData['skills'] != null) skills = updatedData['skills'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //Cover Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: Image.network(
                        'data:image/jpeg;base64,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',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Hero(
                          tag: 'avatar',
                          child: GestureDetector(
                            onTap: () => _openEditProfileSheet(),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: _getAvatarImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildStatCard('Posts', '248', Icons.photo_library),
                        _buildStatCard('Followers', '12.5K', Icons.people),
                        _buildStatCard('Following', '894', Icons.person_add),
                      ],
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        bio,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.email, email),
                    _buildInfoRow(Icons.phone, phone),
                    _buildInfoRow(Icons.cake, birthday),
                    _buildInfoRow(Icons.work, occupation),
                    const SizedBox(height: 32),

                    const Text(
                      'Skills & Interests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: skills.map((skill) {
                        return _buildSkillChip(
                          skill,
                          skillColors[skill] ?? Colors.grey,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _openEditProfileSheet(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667EEA),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile shared!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF667EEA),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF667EEA),
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Share Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getAvatarImage() {
    if (avatarFile != null) {
      return FileImage(avatarFile!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    } else {
      return const NetworkImage(
        'https://pbs.twimg.com/media/E5dln1BXwAEczyn.jpg',
      );
    }
  }

  void _openEditProfileSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileSheet(
        currentData: {
          'name': name,
          'bio': bio,
          'location': location,
          'email': email,
          'phone': phone,
          'birthday': birthday,
          'occupation': occupation,
          'avatarUrl': avatarUrl,
          'avatarFile': avatarFile,
          'skills': skills,
        },
        onSave: _updateProfile,
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade50, Colors.grey.shade100],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF667EEA), size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF667EEA), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Color(0xFF4A5568)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

// ==================== EDIT PROFILE SHEET ====================

class EditProfileSheet extends StatefulWidget {
  final Map<String, dynamic> currentData;
  final Function(Map<String, dynamic>) onSave;

  const EditProfileSheet({
    super.key,
    required this.currentData,
    required this.onSave,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController occupationController;
  late TextEditingController avatarUrlController;
  late List<String> skills;
  late TextEditingController newSkillController;

  File? avatarFile;
  String? avatarUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentData['name']);
    bioController = TextEditingController(text: widget.currentData['bio']);
    locationController = TextEditingController(
      text: widget.currentData['location'],
    );
    emailController = TextEditingController(text: widget.currentData['email']);
    phoneController = TextEditingController(text: widget.currentData['phone']);
    birthdayController = TextEditingController(
      text: widget.currentData['birthday'],
    );
    occupationController = TextEditingController(
      text: widget.currentData['occupation'],
    );
    avatarUrlController = TextEditingController(
      text: widget.currentData['avatarUrl'] ?? '',
    );
    avatarFile = widget.currentData['avatarFile'];
    avatarUrl = widget.currentData['avatarUrl'];
    skills = List<String>.from(widget.currentData['skills']);
    newSkillController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    occupationController.dispose();
    avatarUrlController.dispose();
    newSkillController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          avatarFile = File(pickedFile.path);
          avatarUrl = null; // Clear URL when using local file
          avatarUrlController.clear(); // Clear URL text field
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Avatar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF667EEA),
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF667EEA)),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Color(0xFF667EEA)),
                title: const Text('Use URL'),
                onTap: () {
                  Navigator.pop(context);
                  _showUrlDialog();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showUrlDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController urlController = TextEditingController(
          text: avatarUrlController.text,
        );
        return AlertDialog(
          title: const Text('Enter Image URL'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(
              hintText: 'https://example.com/image.jpg',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.trim().isNotEmpty) {
                  setState(() {
                    avatarUrl = urlController.text.trim();
                    avatarFile = null;
                    avatarUrlController.text = avatarUrl!;
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
              ),
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _addSkill() {
    if (newSkillController.text.trim().isNotEmpty) {
      setState(() {
        skills.add(newSkillController.text.trim());
        newSkillController.clear();
      });
    }
  }

  void _removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  void _saveChanges() {
    final updatedData = {
      'name': nameController.text,
      'bio': bioController.text,
      'location': locationController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'birthday': birthdayController.text,
      'occupation': occupationController.text,
      'avatarUrl': avatarUrl,
      'avatarFile': avatarFile,
      'skills': skills,
    };
    widget.onSave(updatedData);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: _saveChanges,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar Section with Change Button
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF667EEA),
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: _getAvatarPreview(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerDialog,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF667EEA),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _showImagePickerDialog,
                          child: const Text(
                            'Change Avatar',
                            style: TextStyle(
                              color: Color(0xFF667EEA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Optional: Show URL field if using URL
                  if (avatarUrl != null && avatarFile == null) ...[
                    _buildTextField(
                      avatarUrlController,
                      'Avatar URL',
                      Icons.link,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Form Fields
                  _buildTextField(nameController, 'Full Name', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(
                    locationController,
                    'Location',
                    Icons.location_on,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    emailController,
                    'Email',
                    Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    phoneController,
                    'Phone',
                    Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(birthdayController, 'Birthday', Icons.cake),
                  const SizedBox(height: 16),
                  _buildTextField(
                    occupationController,
                    'Occupation',
                    Icons.work,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    bioController,
                    'Bio',
                    Icons.description,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),

                  // Skills Section
                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.asMap().entries.map((entry) {
                      int index = entry.key;
                      String skill = entry.value;
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Colors.grey.shade100,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _removeSkill(index),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newSkillController,
                          decoration: InputDecoration(
                            hintText: 'Add new skill',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _addSkill,
                        icon: const Icon(Icons.add_circle),
                        color: const Color(0xFF667EEA),
                        iconSize: 40,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Avatar Image
  ImageProvider _getAvatarPreview() {
    if (avatarFile != null) {
      return FileImage(avatarFile!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    } else {
      return const NetworkImage(
        'https://pbs.twimg.com/media/E5dln1BXwAEczyn.jpg',
      );
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF667EEA)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
