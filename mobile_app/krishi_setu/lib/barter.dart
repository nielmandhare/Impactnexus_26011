// import 'package:flutter/material.dart';
//
// class BarterPage extends StatefulWidget {
//   const BarterPage({super.key});
//
//   @override
//   State<BarterPage> createState() => _BarterPageState();
// }
//
// class _BarterPageState extends State<BarterPage> with TickerProviderStateMixin {
//   int _selectedTab = 0;
//   late AnimationController _pageController;
//   late Animation<double> _pageFade;
//
//   final List<Map<String, dynamic>> liveAuctions = [
//     {
//       "id": 1,
//       "name": "Organic Wheat",
//       "quantity": "50 quintals",
//       "image": "assets/images/wheat.png",
//       "currentBid": 2400,
//       "minBid": 2200,
//       "seller": "Pranit Oak",
//       "location": "Solapur, MH",
//       "timeLeft": "2h 45m",
//       "bidsCount": 12,
//       "matchScore": 95,
//       "isLive": true,
//       "verified": true,
//       "rating": 4.9,
//     },
//     {
//       "id": 2,
//       "name": "Fresh Tomatoes",
//       "quantity": "80 kg",
//       "image": "assets/images/tomato.png",
//       "currentBid": 850,
//       "minBid": 800,
//       "seller": "Suresh Deshmukh",
//       "location": "Pune, MH",
//       "timeLeft": "4h 20m",
//       "bidsCount": 8,
//       "matchScore": 88,
//       "isLive": true,
//       "verified": true,
//       "rating": 4.5,
//     },
//   ];
//
//   final List<Map<String, dynamic>> upcomingAuctions = [
//     {
//       "id": 3,
//       "name": "FRUITS",
//       "quantity": "25 KILOs",
//       "image": "assets/images/tomato.png",
//       "startingBid": 3200,
//       "seller": "Amit Patel",
//       "location": "Indore, MP",
//       "startsIn": "6 hours",
//       "matchScore": 92,
//       "isLive": false,
//       "verified": true,
//     },
//     {
//       "id": 4,
//       "name": "Basmati Rice",
//       "quantity": "40 quintals",
//       "image": "assets/images/wheat.png",
//       "startingBid": 5600,
//       "seller": "Singh Farms",
//       "location": "Punjab",
//       "startsIn": "12 hours",
//       "matchScore": 85,
//       "isLive": false,
//       "verified": false,
//     },
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _pageFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _pageController, curve: Curves.easeOut),
//     );
//     _pageController.forward();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: FadeTransition(
//         opacity: _pageFade,
//         child: SafeArea(
//           child: Column(
//             children: [
//               _buildHeader(),
//               _buildTabBar(),
//               Expanded(
//                 child: _selectedTab == 0
//                     ? _buildLiveAuctions()
//                     : _selectedTab == 1
//                     ? _buildUpcomingAuctions()
//                     : _buildMyBids(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.green.shade600, Colors.green.shade700],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(24),
//           bottomRight: Radius.circular(24),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 "✨ AI Barter Auction",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             "Smart matching powered by AI",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTabBar() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           _buildTabButton("Live", 0),
//           _buildTabButton("Upcoming", 1),
//           _buildTabButton("My Bids", 2),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTabButton(String label, int index) {
//     bool isSelected = _selectedTab == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => _selectedTab = index),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.green : Colors.transparent,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: isSelected ? Colors.white : Colors.grey,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLiveAuctions() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
//       child: Column(
//         children: [
//           _buildAIMatchingCard(),
//           const SizedBox(height: 20),
//           ...liveAuctions.map((auction) => _buildAuctionCard(auction)).toList(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAIMatchingCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.purple.shade100, Colors.blue.shade100],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: Colors.purple.shade200, width: 1.5),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               color: Colors.purple,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.flash_on,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "AI-Powered Matching",
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Get personalized auction recommendations based on your farm profile",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAuctionCard(Map<String, dynamic> auction) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // IMAGE WITH BADGES
//             Stack(
//               children: [
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                   ),
//                   child: Image.asset(
//                     auction["image"],
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(
//                         child: Icon(
//                           Icons.image_not_supported,
//                           size: 50,
//                           color: Colors.grey.shade400,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // LIVE BADGE
//                 if (auction["isLive"])
//                   Positioned(
//                     top: 12,
//                     left: 12,
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Row(
//                         children: [
//                           Icon(Icons.circle, color: Colors.white, size: 6),
//                           SizedBox(width: 6),
//                           Text(
//                             "LIVE",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 // MATCH SCORE BADGE
//                 Positioned(
//                   top: 12,
//                   right: 12,
//                   child: Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.purple,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.flash_on, color: Colors.white, size: 14),
//                         const SizedBox(width: 6),
//                         Text(
//                           "${auction["matchScore"]}% Match",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // RATING BADGE
//                 Positioned(
//                   bottom: 12,
//                   right: 12,
//                   child: Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 6,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
//                         const SizedBox(width: 3),
//                         Text(
//                           "${auction["rating"]}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // CONTENT SECTION
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // NAME & QUANTITY
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               auction["name"],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               auction["quantity"],
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           const Text(
//                             "Current Bid",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "₹${auction["currentBid"] ?? auction["startingBid"]}",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green.shade600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 14),
//                   const Divider(height: 1),
//                   const SizedBox(height: 14),
//                   // SELLER INFO
//                   Row(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.green.shade100,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Center(
//                           child: Text("🧑‍🌾", style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   auction["seller"],
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 if (auction["verified"])
//                                   const Padding(
//                                     padding: EdgeInsets.only(left: 6),
//                                     child: Icon(
//                                       Icons.check_circle,
//                                       color: Colors.green,
//                                       size: 16,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               auction["location"],
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 14),
//                   // STATS ROW
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildStatItem(
//                         Icons.schedule,
//                         auction["timeLeft"] ?? auction["startsIn"],
//                         "Time",
//                       ),
//                       _buildStatItem(
//                         Icons.people,
//                         "${auction["bidsCount"] ?? 0} bids",
//                         "Bids",
//                       ),
//                       _buildStatItem(
//                         Icons.trending_up,
//                         "₹${auction["minBid"] ?? auction["startingBid"]}",
//                         "Min Bid",
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // ACTION BUTTONS
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(
//                               color: Colors.grey,
//                               width: 1.5,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                           ),
//                           onPressed: () {},
//                           child: const Text(
//                             "View Details",
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.green.shade600,
//                                 Colors.green.shade700,
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               onTap: () {},
//                               borderRadius: BorderRadius.circular(14),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.gavel,
//                                         color: Colors.white, size: 18),
//                                     SizedBox(width: 6),
//                                     Text(
//                                       "Place Bid",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatItem(IconData icon, String value, String label) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: Colors.grey),
//             const SizedBox(width: 6),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 11,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildUpcomingAuctions() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
//       child: Column(
//         children: [
//           ...upcomingAuctions
//               .map((auction) => _buildAuctionCard(auction))
//               .toList(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMyBids() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.gavel,
//               size: 40,
//               color: Colors.grey.shade400,
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             "No Bids Yet",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             "Place your first bid to track it here",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class BarterPage extends StatefulWidget {
  const BarterPage({super.key});

  @override
  State<BarterPage> createState() => _BarterPageState();
}

class _BarterPageState extends State<BarterPage> with TickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _pageController;
  late Animation<double> _pageFade;

  // My Bids tracking
  List<Map<String, dynamic>> myBids = [];

  final List<Map<String, dynamic>> liveAuctions = [
    {
      "id": 1,
      "name": "Organic Wheat",
      "quantity": "50 quintals",
      "image": "assets/images/wheat.png",
      "currentBid": 2400,
      "minBid": 2200,
      "seller": "Pranit Oak",
      "location": "Solapur, MH",
      "timeLeft": "2h 45m",
      "bidsCount": 12,
      "matchScore": 95,
      "isLive": true,
      "verified": true,
      "rating": 4.9,
      "description": "Premium quality organic wheat grown without any chemical fertilizers. Harvested using traditional methods to ensure quality.",
      "quality": "Tier A - Premium",
      "certification": "Organic Certified",
      "harvestDate": "2024-02-15",
      "moisture": "12%",
    },
    {
      "id": 2,
      "name": "Fresh Tomatoes",
      "quantity": "80 kg",
      "image": "assets/images/tomato.png",
      "currentBid": 850,
      "minBid": 800,
      "seller": "Suresh Deshmukh",
      "location": "Pune, MH",
      "timeLeft": "4h 20m",
      "bidsCount": 8,
      "matchScore": 88,
      "isLive": true,
      "verified": true,
      "rating": 4.5,
      "description": "Fresh, juicy tomatoes picked today. Perfect for cooking and salads. No pesticides used.",
      "quality": "Tier B - Standard",
      "certification": "Farm Fresh",
      "harvestDate": "2024-02-28",
      "moisture": "90%",
    },
  ];

  final List<Map<String, dynamic>> upcomingAuctions = [
    {
      "id": 3,
      "name": "FRUITS",
      "quantity": "25 KILOs",
      "image": "assets/images/tomato.png",
      "startingBid": 3200,
      "seller": "Amit Patel",
      "location": "Indore, MP",
      "startsIn": "6 hours",
      "matchScore": 92,
      "isLive": false,
      "verified": true,
      "description": "Mixed seasonal fruits including mangoes, guavas, and papayas.",
      "quality": "Tier A - Premium",
    },
    {
      "id": 4,
      "name": "Basmati Rice",
      "quantity": "40 quintals",
      "image": "assets/images/wheat.png",
      "startingBid": 5600,
      "seller": "Singh Farms",
      "location": "Punjab",
      "startsIn": "12 hours",
      "matchScore": 85,
      "isLive": false,
      "verified": false,
      "description": "Premium basmati rice with long grains and aromatic flavor.",
      "quality": "Tier B - Standard",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _pageFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeOut),
    );
    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showProductDetails(Map<String, dynamic> auction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _buildDetailsSheet(auction),
    );
  }

  Widget _buildDetailsSheet(Map<String, dynamic> auction) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: Image.asset(
                          auction["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey.shade400,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Product Title & Quantity
                    Text(
                      auction["name"],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      auction["quantity"],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Bid Info
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Current Bid",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${auction["currentBid"] ?? auction["startingBid"]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Minimum Bid",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "₹${auction["minBid"] ?? auction["startingBid"]}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Description
                    const Text(
                      "Product Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      auction["description"] ?? "No description available",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Product Specs
                    const Text(
                      "Specifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSpecRow("Quality", auction["quality"] ?? "N/A"),
                    const SizedBox(height: 10),
                    _buildSpecRow("Certification", auction["certification"] ?? "N/A"),
                    if (auction["harvestDate"] != null) ...[
                      const SizedBox(height: 10),
                      _buildSpecRow("Harvest Date", auction["harvestDate"]),
                    ],
                    if (auction["moisture"] != null) ...[
                      const SizedBox(height: 10),
                      _buildSpecRow("Moisture", auction["moisture"]),
                    ],
                    const SizedBox(height: 18),
                    // Seller Info
                    const Text(
                      "Seller Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text("🧑‍🌾", style: TextStyle(fontSize: 24)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      auction["seller"],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (auction["verified"])
                                      const Padding(
                                        padding: EdgeInsets.only(left: 6),
                                        child: Icon(
                                          Icons.verified_user,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      auction["location"],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 12, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${auction["rating"]} rating",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showBidPlacementSheet(Map<String, dynamic> auction) {
    final bidController = TextEditingController();
    final currentBid = auction["currentBid"] ?? auction["startingBid"];
    final minBid = auction["minBid"] ?? currentBid + 100;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Live Bidding",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 6),
                          SizedBox(width: 4),
                          Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Product Summary
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: Image.asset(
                            auction["image"],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auction["name"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              auction["quantity"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Current Bid Display
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade50, Colors.green.shade100],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Current Highest Bid",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "₹$currentBid",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Minimum Next Bid",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "₹$minBid",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Bid Input
                const Text(
                  "Place Your Bid",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "₹ ",
                    hintText: "$minBid or higher",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onChanged: (_) => setModalState(() {}),
                ),
                const SizedBox(height: 16),
                // Quick Bid Buttons
                const Text(
                  "Quick Bid",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQuickBidButton(minBid, bidController, setModalState),
                    const SizedBox(width: 8),
                    _buildQuickBidButton(minBid + 100, bidController, setModalState),
                    const SizedBox(width: 8),
                    _buildQuickBidButton(minBid + 500, bidController, setModalState),
                  ],
                ),
                const SizedBox(height: 20),
                // Submit Bid Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade600, Colors.green.shade700],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: bidController.text.isEmpty
                            ? null
                            : () {
                          final bidAmount =
                              int.tryParse(bidController.text) ?? 0;
                          if (bidAmount >= minBid) {
                            setState(() {
                              myBids.add({
                                "id": auction["id"],
                                "name": auction["name"],
                                "image": auction["image"],
                                "bidAmount": bidAmount,
                                "seller": auction["seller"],
                                "location": auction["location"],
                                "timestamp": DateTime.now(),
                                "status": "Active",
                              });
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Bid of ₹$bidAmount placed successfully! 🎉"),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Bid must be at least the minimum amount"),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.gavel, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Place Bid Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickBidButton(int amount, TextEditingController controller,
      Function(VoidCallback) setModalState) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          controller.text = amount.toString();
          setModalState(() {});
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.green),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "₹$amount",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: FadeTransition(
        opacity: _pageFade,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: _selectedTab == 0
                    ? _buildLiveAuctions()
                    : _selectedTab == 1
                    ? _buildUpcomingAuctions()
                    : _buildMyBids(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "✨ AI Barter Auction",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Smart matching powered by AI",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTabButton("Live", 0),
          _buildTabButton("Upcoming", 1),
          _buildTabButton("My Bids (${myBids.length})", 2),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveAuctions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      child: Column(
        children: [
          _buildAIMatchingCard(),
          const SizedBox(height: 20),
          ...liveAuctions.map((auction) => _buildAuctionCard(auction)).toList(),
        ],
      ),
    );
  }

  Widget _buildAIMatchingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade100, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.purple.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "AI-Powered Matching",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Get personalized auction recommendations based on your farm profile",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE WITH BADGES
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                  child: Image.asset(
                    auction["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
                // LIVE BADGE
                if (auction["isLive"])
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 6),
                          SizedBox(width: 6),
                          Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // MATCH SCORE BADGE
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.flash_on, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          "${auction["matchScore"]}% Match",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // RATING BADGE
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                        const SizedBox(width: 3),
                        Text(
                          "${auction["rating"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // CONTENT SECTION
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME & QUANTITY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auction["name"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              auction["quantity"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Current Bid",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${auction["currentBid"] ?? auction["startingBid"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  // SELLER INFO
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text("🧑‍🌾", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  auction["seller"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                if (auction["verified"])
                                  const Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              auction["location"],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // STATS ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem(
                        Icons.schedule,
                        auction["timeLeft"] ?? auction["startsIn"],
                        "Time",
                      ),
                      _buildStatItem(
                        Icons.people,
                        "${auction["bidsCount"] ?? 0} bids",
                        "Bids",
                      ),
                      _buildStatItem(
                        Icons.trending_up,
                        "₹${auction["minBid"] ?? auction["startingBid"]}",
                        "Min Bid",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ACTION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => _showProductDetails(auction),
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _showBidPlacementSheet(auction),
                              borderRadius: BorderRadius.circular(14),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.gavel,
                                        color: Colors.white, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      "Place Bid",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingAuctions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      child: Column(
        children: [
          ...upcomingAuctions
              .map((auction) => _buildAuctionCard(auction))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildMyBids() {
    return myBids.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.gavel,
              size: 40,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "No Bids Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Place your first bid to track it here",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    )
        : SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      child: Column(
        children: [
          ...myBids.map((bid) {
            final index = myBids.indexOf(bid);
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade300,
                      child: Image.asset(
                        bid["image"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bid["name"],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          bid["seller"],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            bid["status"],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${bid["bidAmount"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Your Bid",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() => myBids.removeAt(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Bid withdrawn"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}