import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KisanIdPage extends StatelessWidget {
  const KisanIdPage({super.key});

  Future<void> openPMKisanSite() async {
    final Uri url = Uri.parse(
        "https://www.pmkisan.gov.in/KnowYour_Registration.aspx");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch PM-KISAN website");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [

              const SizedBox(height: 10),

              /// BACK BUTTON
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// LOGO
              Image.asset(
                "assets/images/krishi_logo.png",
                height: 110,
              ),

              const SizedBox(height: 35),

              /// QUESTION CARD
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 4),
                    )
                  ],
                ),

                child: Column(
                  children: const [

                    Text(
                      "Do you have a PM-KISAN ID?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      "PM-KISAN is a government scheme for farmers. You need a PM-KISAN ID to use KrishiSetu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// YES BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    "Yes, I have PM-KISAN ID",
                    style: TextStyle(fontSize: 16),
                  ),

                  onPressed: () {
                    /// NEXT STEP INSIDE APP
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Proceeding with PM-KISAN verification"),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              /// NO BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,

                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  icon: const Icon(Icons.close),
                  label: const Text(
                    "No, I don't have PM-KISAN ID",
                    style: TextStyle(fontSize: 16),
                  ),

                  onPressed: () {
                    openPMKisanSite();
                  },
                ),
              ),

              const SizedBox(height: 25),

              /// INFO BOX
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.blue.shade100,
                  ),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "What is PM-KISAN?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Pradhan Mantri Kisan Samman Nidhi (PM-KISAN) is a government scheme that provides ₹6,000 per year to farmers. If you don't have it, click 'No' to register.",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        height: 1.4,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}