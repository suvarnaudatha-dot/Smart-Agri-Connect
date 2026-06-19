import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// 👇 Add these 3 imports
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/app_localizations.dart'; // you'll create this file later
import 'l10n/app_localizations.dart';

void main() {
  runApp(const SmartAgriConnectApp());
}


class SmartAgriConnectApp extends StatefulWidget {
  const SmartAgriConnectApp({super.key});

  @override
  State<SmartAgriConnectApp> createState() => _SmartAgriConnectAppState();
}

class _SmartAgriConnectAppState extends State<SmartAgriConnectApp> {
  Locale _locale = const Locale('en'); // default language is English

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale; // this changes the language
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Agri Connect',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,

      locale: _locale, // 👈 Important

      // localization setup (keep as it is)
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('te'),
        Locale('ta'),
      ],

      // 👇 pass the changeLanguage function to HomeScreen
      home: HomeScreen(onLanguageChange: _changeLanguage),
    );
  }
}



class HomeScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const HomeScreen({super.key, required this.onLanguageChange});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    CropAdvisorScreen(),
    MarketPricesScreen(),
    DiseaseGuideScreen(),
    LearningHubScreen(),
    GovtSchemesScreen(),
    FarmerBuyerConnectScreen(), // 👈 added here
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Agri Connect'),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              widget.onLanguageChange(locale); // change the app language
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: Locale('en'), child: Text('English')),
              PopupMenuItem(value: Locale('hi'), child: Text('हिन्दी')),
              PopupMenuItem(value: Locale('te'), child: Text('తెలుగు')),
              PopupMenuItem(value: Locale('ta'), child: Text('தமிழ்')),
            ],
          ),
        ],
      ),

      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'Crop Advisor'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Market Prices'),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: 'Diseases'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Learning Hub'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Govt Schemes'),
          BottomNavigationBarItem(icon: Icon(Icons.connect_without_contact), label: 'Connect'), // 👈 new
        ],

      ),
    );
  }
}


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dashboard, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              loc.dashboardWelcome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              loc.dashboardSubtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Crop Advisor Screen -------------------
class CropAdvisorScreen extends StatelessWidget {
  const CropAdvisorScreen({super.key});

  final List<Map<String, String>> crops = const [
    {"name": "Wheat", "soil": "Loamy", "season": "Rabi", "water": "Moderate", "fertilizer": "Urea, DAP"},
    {"name": "Rice", "soil": "Clayey", "season": "Kharif", "water": "High", "fertilizer": "NPK, Potash"},
    {"name": "Maize", "soil": "Loamy", "season": "Kharif", "water": "Moderate", "fertilizer": "DAP, Urea"},
    {"name": "Cotton", "soil": "Sandy loam", "season": "Kharif", "water": "Low to Moderate", "fertilizer": "NPK"},
    {"name": "Sugarcane", "soil": "Loamy", "season": "Rabi/Kharif", "water": "High", "fertilizer": "NPK, Potash"},
    {"name": "Tomato", "soil": "Sandy loam", "season": "All year", "water": "Moderate", "fertilizer": "Nitrogen, Phosphorus"},
    {"name": "Potato", "soil": "Loamy", "season": "Rabi", "water": "Moderate", "fertilizer": "NPK"},
    {"name": "Chili", "soil": "Loamy", "season": "Kharif", "water": "Low to Moderate", "fertilizer": "NPK"},
    {"name": "Banana", "soil": "Loamy", "season": "All year", "water": "High", "fertilizer": "NPK, Potash"},
    {"name": "Onion", "soil": "Sandy loam", "season": "Rabi", "water": "Moderate", "fertilizer": "Nitrogen, Phosphorus"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        final crop = crops[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.agriculture, color: Colors.green),
            title: Text(crop['name']!),
            subtitle: Text(
                "Soil: ${crop['soil']}\nSeason: ${crop['season']}\nWater: ${crop['water']}\nFertilizer: ${crop['fertilizer']}"
            ),
          ),
        );
      },
    );
  }
}
// ------------------- Market Prices Screen -------------------
class MarketPricesScreen extends StatefulWidget {
  const MarketPricesScreen({super.key});

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  final List<Map<String, String>> _allPrices = const [
    {"crop": "Wheat", "price": "₹2100/quintal"},
    {"crop": "Rice", "price": "₹2000/quintal"},
    {"crop": "Maize", "price": "₹1900/quintal"},
    {"crop": "Cotton", "price": "₹7000/quintal"},
    {"crop": "Sugarcane", "price": "₹3500/quintal"},
    {"crop": "Tomato", "price": "₹25/kg"},
    {"crop": "Potato", "price": "₹18/kg"},
    {"crop": "Chili", "price": "₹120/kg"},
    {"crop": "Banana", "price": "₹35/kg"},
    {"crop": "Onion", "price": "₹20/kg"},
    {"crop": "Paddy", "price": "₹2100/quintal"},
    {"crop": "Bajra", "price": "₹1800/quintal"},
    {"crop": "Jowar", "price": "₹1750/quintal"},
    {"crop": "Barley", "price": "₹1900/quintal"},
    {"crop": "Groundnut", "price": "₹5500/quintal"},
    {"crop": "Soybean", "price": "₹4800/quintal"},
    {"crop": "Mustard", "price": "₹5200/quintal"},
    {"crop": "Sunflower", "price": "₹5300/quintal"},
    {"crop": "Pulses (Toor)", "price": "₹6400/quintal"},
    {"crop": "Pulses (Moong)", "price": "₹7200/quintal"},
    {"crop": "Pulses (Urad)", "price": "₹7000/quintal"},
    {"crop": "Gram", "price": "₹5500/quintal"},
    {"crop": "Lentil (Masoor)", "price": "₹6200/quintal"},
    {"crop": "Green Gram", "price": "₹7500/quintal"},
    {"crop": "Coconut", "price": "₹90/kg"},
    {"crop": "Arecanut", "price": "₹450/kg"},
    {"crop": "Coffee", "price": "₹220/kg"},
    {"crop": "Tea", "price": "₹160/kg"},
    {"crop": "Pepper", "price": "₹600/kg"},
    {"crop": "Cardamom", "price": "₹1800/kg"},
    {"crop": "Turmeric", "price": "₹130/kg"},
    {"crop": "Ginger", "price": "₹90/kg"},
    {"crop": "Garlic", "price": "₹140/kg"},
    {"crop": "Coriander", "price": "₹110/kg"},
    {"crop": "Cumin", "price": "₹210/kg"},
    {"crop": "Fenugreek", "price": "₹100/kg"},
    {"crop": "Sesame", "price": "₹120/kg"},
    {"crop": "Castor", "price": "₹4800/quintal"},
    {"crop": "Guar Seed", "price": "₹4200/quintal"},
    {"crop": "Sorghum", "price": "₹2000/quintal"},
    {"crop": "Pearl Millet", "price": "₹1900/quintal"},
    {"crop": "Tobacco", "price": "₹4500/quintal"},
    {"crop": "Jute", "price": "₹4300/quintal"},
    {"crop": "Rubber", "price": "₹170/kg"},
    {"crop": "Cotton Seed", "price": "₹3500/quintal"},
    {"crop": "Corn", "price": "₹1850/quintal"},
    {"crop": "Soya Meal", "price": "₹4800/quintal"},
    {"crop": "Pineapple", "price": "₹45/kg"},
    {"crop": "Papaya", "price": "₹35/kg"},
    {"crop": "Mango", "price": "₹70/kg"},
    {"crop": "Apple", "price": "₹120/kg"},
    {"crop": "Pomegranate", "price": "₹180/kg"},
    {"crop": "Grapes", "price": "₹100/kg"},
    {"crop": "Watermelon", "price": "₹25/kg"},
    {"crop": "Cucumber", "price": "₹20/kg"},
    {"crop": "Carrot", "price": "₹30/kg"},
    {"crop": "Cabbage", "price": "₹18/kg"},
    {"crop": "Cauliflower", "price": "₹25/kg"},
  ];

  List<Map<String, String>> _filteredPrices = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredPrices = _allPrices;
    _searchController.addListener(_filterCrops);
  }

  void _filterCrops() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPrices = _allPrices
          .where((crop) => crop['crop']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.green),
              hintText: 'Search crop...',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.green, width: 2),
              ),
            ),
          ),
        ),

        // 📋 Filtered Crop List
        Expanded(
          child: _filteredPrices.isEmpty
              ? const Center(child: Text('No crops found'))
              : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _filteredPrices.length,
            itemBuilder: (context, index) {
              final crop = _filteredPrices[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.green),
                  title: Text(crop['crop']!),
                  trailing: Text(
                    crop['price']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ------------------- Disease Guide Screen -------------------
class DiseaseGuideScreen extends StatelessWidget {
  const DiseaseGuideScreen({super.key});

  final List<Map<String, String>> diseases = const [
    {
      "crop": "Wheat",
      "disease": "Rust",
      "symptoms": "Orange pustules on leaves and stems",
      "treatment": "Use resistant varieties, apply fungicides like Mancozeb"
    },
    {
      "crop": "Wheat",
      "disease": "Powdery Mildew",
      "symptoms": "White powdery patches on leaf surfaces",
      "treatment": "Spray sulfur-based fungicides, avoid excess nitrogen"
    },
    {
      "crop": "Rice",
      "disease": "Blast",
      "symptoms": "Spindle-shaped lesions on leaves and nodes",
      "treatment": "Use resistant varieties, avoid excess nitrogen, apply tricyclazole"
    },
    {
      "crop": "Rice",
      "disease": "Bacterial Leaf Blight",
      "symptoms": "Yellowing and drying of leaf tips",
      "treatment": "Use clean seeds, copper-based bactericides"
    },
    {
      "crop": "Maize",
      "disease": "Downy Mildew",
      "symptoms": "Yellow streaks and white fungal growth on underside of leaves",
      "treatment": "Use metalaxyl fungicide, destroy infected plants"
    },
    {
      "crop": "Cotton",
      "disease": "Boll Rot",
      "symptoms": "Rotting of green bolls, brown discoloration inside boll",
      "treatment": "Use carbendazim spray, improve field drainage"
    },
    {
      "crop": "Cotton",
      "disease": "Leaf Curl Virus",
      "symptoms": "Curling and thickening of leaves with stunted growth",
      "treatment": "Control whiteflies, remove infected plants"
    },
    {
      "crop": "Tomato",
      "disease": "Early Blight",
      "symptoms": "Dark concentric spots on lower leaves",
      "treatment": "Spray chlorothalonil or mancozeb fungicides"
    },
    {
      "crop": "Tomato",
      "disease": "Late Blight",
      "symptoms": "Water-soaked lesions on leaves and fruit",
      "treatment": "Remove infected plants, spray metalaxyl or copper oxychloride"
    },
    {
      "crop": "Potato",
      "disease": "Late Blight",
      "symptoms": "Dark brown patches on leaves, tuber rot",
      "treatment": "Use certified seeds, copper fungicides, crop rotation"
    },
    {
      "crop": "Sugarcane",
      "disease": "Red Rot",
      "symptoms": "Reddish-brown discoloration inside cane, foul smell",
      "treatment": "Use resistant varieties, hot water seed treatment"
    },
    {
      "crop": "Sugarcane",
      "disease": "Smut",
      "symptoms": "Black whip-like structure emerges from top of cane",
      "treatment": "Use disease-free seed, burn infected clumps"
    },
    {
      "crop": "Chili",
      "disease": "Leaf Curl Virus",
      "symptoms": "Curled, small, thick leaves with reduced fruiting",
      "treatment": "Control whiteflies, remove infected plants"
    },
    {
      "crop": "Chili",
      "disease": "Anthracnose",
      "symptoms": "Dark sunken lesions on fruits",
      "treatment": "Spray carbendazim or mancozeb fungicides"
    },
    {
      "crop": "Banana",
      "disease": "Panama Wilt",
      "symptoms": "Yellowing and wilting of older leaves",
      "treatment": "Use resistant varieties, ensure proper drainage"
    },
    {
      "crop": "Banana",
      "disease": "Bunchy Top Virus",
      "symptoms": "Shortened, bunched leaves with dark green streaks",
      "treatment": "Remove infected plants, control aphids"
    },
    {
      "crop": "Onion",
      "disease": "Purple Blotch",
      "symptoms": "Purple spots with yellow margins on leaves",
      "treatment": "Spray mancozeb or chlorothalonil fungicides"
    },
    {
      "crop": "Onion",
      "disease": "Downy Mildew",
      "symptoms": "Grayish mold on leaves, bending and drying",
      "treatment": "Spray metalaxyl and maintain field aeration"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: diseases.length,
      itemBuilder: (context, index) {
        final disease = diseases[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.health_and_safety, color: Colors.red),
            title: Text(
              "${disease['crop']} - ${disease['disease']}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Symptoms: ${disease['symptoms']}\nTreatment: ${disease['treatment']}",
            ),
          ),
        );
      },
    );
  }
}

/// ------------------- Learning Hub Screen -------------------
class LearningHubScreen extends StatelessWidget {
  const LearningHubScreen({super.key});

  final List<Map<String, String>> videos = const [
    {
      "title": "Wheat Farming Guide - Step by Step",
      "url": "https://www.youtube.com/watch?v=0vQySgljY5Y"
    },
    {
      "title": "Rice Cultivation Tips and Best Practices",
      "url": "https://www.youtube.com/watch?v=INq9V1pGyks"
    },
    {
      "title": "Organic Farming Techniques for Beginners",
      "url": "https://www.youtube.com/watch?v=ltm1b0yHZmM"
    },
    {
      "title": "Drip Irrigation System Setup and Maintenance",
      "url": "https://www.youtube.com/watch?v=JZVbqz3-K1c"
    },
    {
      "title": "Pest and Disease Management in Crops",
      "url": "https://www.youtube.com/watch?v=5q_3DqgEs2k"
    },
    {
      "title": "Soil Testing and Fertility Improvement",
      "url": "https://www.youtube.com/watch?v=zwPJDExJ2xk"
    },
    {
      "title": "Climate Smart and Sustainable Agriculture",
      "url": "https://www.youtube.com/watch?v=vlUTD_mnGkE"
    },
    {
      "title": "Hydroponic Farming: Soil-less Agriculture",
      "url": "https://www.youtube.com/watch?v=ojf9R8y0I6A"
    },
    {
      "title": "Vertical Farming Techniques in India",
      "url": "https://www.youtube.com/watch?v=iqi1IE9GdF0"
    },
    {
      "title": "Greenhouse Farming - Controlled Environment Crops",
      "url": "https://www.youtube.com/watch?v=pL0LXYc7zR4"
    },
    {
      "title": "Modern Tractor and Smart Farming Technology",
      "url": "https://www.youtube.com/watch?v=HhJLM7GJxO0"
    },
    {
      "title": "Zero Budget Natural Farming Explained",
      "url": "https://www.youtube.com/watch?v=YxkzxwZ2iZI"
    },
    {
      "title": "Crop Rotation and Soil Health Management",
      "url": "https://www.youtube.com/watch?v=R2Kp2VhKsbI"
    },
    {
      "title": "Composting and Organic Fertilizer Preparation",
      "url": "https://www.youtube.com/watch?v=BL9lKtfG5Ew"
    },
  ];

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.play_circle_fill, color: Colors.green),
            title: Text(video['title']!),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchURL(video['url']!),
          ),
        );
      },
    );
  }
}


// ------------------- Government Schemes Screen -------------------


class GovtSchemesScreen extends StatelessWidget {
  const GovtSchemesScreen({super.key});

  // 🔗 List of government schemes with links
  final List<Map<String, String>> schemes = const [
    {
      "name": "PM Kisan Samman Nidhi",
      "description": "Provides ₹6000 per year to small and marginal farmers.",
      "url": "https://pmkisan.gov.in/"
    },
    {
      "name": "Kisan Credit Card (KCC)",
      "description": "Offers short-term credit support for crop cultivation.",
      "url": "https://pmkisan.gov.in/Documents/KCC.pdf"
    },
    {
      "name": "Pradhan Mantri Fasal Bima Yojana",
      "description": "Crop insurance for farmers against natural calamities.",
      "url": "https://pmfby.gov.in/"
    },
    {
      "name": "Soil Health Card Scheme",
      "description": "Provides soil nutrient status and fertilizer recommendations.",
      "url": "https://soilhealth.dac.gov.in/"
    },
    {
      "name": "PM Krishi Sinchayee Yojana",
      "description": "Promotes efficient irrigation and water use.",
      "url": "https://pmksy.gov.in/"
    },
    {
      "name": "eNAM (National Agriculture Market)",
      "description": "Online trading platform for better price discovery.",
      "url": "https://enam.gov.in/"
    },
    {
      "name": "Rashtriya Krishi Vikas Yojana",
      "description": "Encourages states to invest more in agriculture and allied sectors.",
      "url": "https://rkvy.nic.in/"
    },
    {
      "name": "Dairy Entrepreneurship Development Scheme",
      "description": "Supports dairy farmers and entrepreneurs.",
      "url": "https://dahd.nic.in/"
    },
  ];

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: schemes.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final scheme = schemes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheme['name']!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 5),
                Text(
                  scheme['description']!,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchURL(scheme['url']!),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text("Apply Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
// ------------------- Farmer–Buyer Connect Screen -------------------
class FarmerBuyerConnectScreen extends StatefulWidget {
  const FarmerBuyerConnectScreen({super.key});

  @override
  State<FarmerBuyerConnectScreen> createState() => _FarmerBuyerConnectScreenState();
}

class _FarmerBuyerConnectScreenState extends State<FarmerBuyerConnectScreen> {
  final List<Map<String, String>> _posts = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cropController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  void _addPost() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _posts.add({
          'name': _nameController.text,
          'crop': _cropController.text,
          'quantity': _quantityController.text,
          'price': _priceController.text,
          'contact': _contactController.text,
        });
        _nameController.clear();
        _cropController.clear();
        _quantityController.clear();
        _priceController.clear();
        _contactController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Farmer–Buyer Connect",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Farmer Name'),
                    validator: (v) => v!.isEmpty ? 'Enter name' : null,
                  ),
                  TextFormField(
                    controller: _cropController,
                    decoration: const InputDecoration(labelText: 'Crop Name'),
                    validator: (v) => v!.isEmpty ? 'Enter crop' : null,
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity (e.g., 50 kg)'),
                    validator: (v) => v!.isEmpty ? 'Enter quantity' : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Expected Price (₹ per kg/quintal)'),
                    validator: (v) => v!.isEmpty ? 'Enter price' : null,
                  ),
                  TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(labelText: 'Contact Number'),
                    validator: (v) => v!.isEmpty ? 'Enter contact' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _addPost,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Post"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Available Posts:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            if (_posts.isEmpty)
              const Text("No posts yet. Add your listing above.")
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    child: ListTile(
                      title: Text("${post['crop']} (${post['quantity']})"),
                      subtitle: Text("Price: ${post['price']}\nContact: ${post['contact']}"),
                      trailing: Text(post['name']!),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

