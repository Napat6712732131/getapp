import 'package:flutter/material.dart';
import 'package:get_app/components/appdrawer.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int selectedCategory = 0;
  int selectedTab = 0;
  int bottomNavIndex = 1;

  final List<String> categories = ['ทั้งหมด', 'คาเฟ่', 'ร้านอาหาร', 'ช้อปปิ้ง'];

  final List<Map<String, dynamic>> stores = [
    {
      'name': 'G1',
      'rating': 4.3,
      'reviews': 99,
      'category': 'คาเฟ่',
      'distance': '116.5 km',
      'points': '0 GP',
      'tags': ['ร้านไอศกรีม', 'Eco-Friendly', 'แฟชั่นภาพ'],
    },
    {
      'name': 'Light up cafe x Nimman',
      'rating': 4.2,
      'reviews': 22,
      'category': 'คาเฟ่',
      'distance': '115.5 km',
      'points': '0 GP',
      'tags': ['คาเฟ่', 'Eco-Friendly'],
    },
    {
      'name': 'Blue Brew',
      'rating': 4.5,
      'reviews': 44,
      'category': 'คาเฟ่',
      'distance': '114.2 km',
      'points': '0 GP',
      'tags': ['กาแฟ', 'บรรยากาศดี'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2E9E45);
    const lightGreen = Color(0xFFF3FAF4);
    const textGray = Color(0xFF7B7B7B);
    const borderColor = Color(0xFFE8E8E8);

    return Scaffold(
      appBar: AppBar(title: const Text('GreenPoint'), backgroundColor: green),
      drawer: const Appdrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== Header =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // โลโก้ + notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: green,
                            child: Icon(
                              Icons.eco,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'GreenPoint',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none_rounded),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Search bar
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'ค้นหาร้านค้า, ประเภท, สถานที่...',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        Icon(Icons.tune, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category chips
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final selected = selectedCategory == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: selected ? green : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected ? green : borderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  index == 0
                                      ? Icons.grid_view_rounded
                                      : index == 1
                                      ? Icons.local_cafe_outlined
                                      : index == 2
                                      ? Icons.restaurant_outlined
                                      : Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: selected
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ===== Tab =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab(
                    title: 'รายชื่อร้าน',
                    selected: selectedTab == 0,
                    onTap: () => setState(() => selectedTab = 0),
                  ),
                  _buildTab(
                    title: 'แผนที่',
                    selected: selectedTab == 1,
                    onTap: () => setState(() => selectedTab = 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ===== Content =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recommended card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE5F1E7)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE5E5E5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.eco, size: 14, color: green),
                                SizedBox(width: 6),
                                Text(
                                  'ร้านที่คุณสนับสนุนมากที่สุด',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          '11',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF2A2A2A),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.verified,
                                          color: green,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '4.8 | คาเฟ่ | 116.4 km',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: textGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),

                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'แต้มสะสมจากร้านนี้',
                                                style: TextStyle(
                                                  color: textGray,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: '0 GP',
                                                      style: TextStyle(
                                                        color: green,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' / 8 รายการ',
                                                      style: TextStyle(
                                                        color: textGray,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Right side placeholder image + button
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 110,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            size: 42,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.favorite_border,
                                            color: Colors.redAccent,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 110,
                                    height: 42,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'ดูรายละเอียด',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Section title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'ร้านค้าที่ร่วมโครงการ GreenPoint',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2B2B2B),
                          ),
                        ),
                        Text(
                          'เรียงตาม: ใกล้สุด',
                          style: TextStyle(fontSize: 12, color: textGray),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Store list
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stores.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final store = stores[index];
                        return _StoreListCard(
                          name: store['name'],
                          rating: store['rating'],
                          reviews: store['reviews'],
                          category: store['category'],
                          distance: store['distance'],
                          points: store['points'],
                          tags: List<String>.from(store['tags']),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ===== Bottom Navigation =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
          });
        },
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront),
            label: 'Partner Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            activeIcon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    const green = Color(0xFF2E9E45);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? green : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? green : Colors.grey,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreListCard extends StatelessWidget {
  final String name;
  final double rating;
  final int reviews;
  final String category;
  final String distance;
  final String points;
  final List<String> tags;

  const _StoreListCard({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.category,
    required this.distance,
    required this.points,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2E9E45);
    const textGray = Color(0xFF7B7B7B);
    const borderColor = Color(0xFFEAEAEA);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // placeholder image
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.storefront, color: Colors.white),
          ),
          const SizedBox(width: 12),

          // middle content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, size: 16, color: green),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.star, size: 15, color: Colors.amber),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '$rating ($reviews รีวิว) | $category | $distance',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: textGray),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F7F5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 11,
                              color: green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // right side
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'แต้มจากร้านนี้',
                  style: TextStyle(fontSize: 10, color: textGray),
                ),
                const SizedBox(height: 2),
                Text(
                  points,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: green,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: green,
                    side: const BorderSide(color: green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('ดูรายละเอียด'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
