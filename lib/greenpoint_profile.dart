// ============================================================================
// GreenPoint - Profile Screen (Gamification for Eco-Friendly App)
// ============================================================================
// วิธีใช้งาน:
// 1. สร้างโปรเจกต์ Flutter ใหม่ (flutter create greenpoint_app)
// 2. แทนที่เนื้อหาไฟล์ lib/main.dart ด้วยไฟล์นี้
// 3. รันด้วยคำสั่ง flutter run
//
// โครงสร้างไฟล์:
//   1) CONFIG & THEME     -> แก้ชื่อแอป / สีธีม ได้ที่นี่
//   2) DATA MODELS        -> UserModel, AchievementModel, TransactionModel
//   3) MOCK DATA           -> แก้ข้อมูลผู้ใช้ / เหรียญรางวัล / ประวัติได้ที่นี่
//   4) MAIN APP & SCREEN
//   5) WIDGETS (แยกเป็นส่วนๆ)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get_app/components/appdrawer.dart';

void main() {
  runApp(const GreenPointApp());
}

// ============================================================================
// 1) CONFIG & THEME
// ----------------------------------------------------------------------------
// ✏️ แก้ไขชื่อแอป, สีหลัก, สีพื้นหลัง ได้ตรงนี้จุดเดียว
// ============================================================================
class AppConfig {
  static const String appName = 'GreenPoint'; // ✏️ แก้ชื่อแอปตรงนี้

  // สีธีมหลัก (สีเขียวธรรมชาติ)
  static const Color primaryGreen = Color(0xFF2E9E4F);
  static const Color lightGreen = Color(0xFFDCEFE0); // สำหรับ badge / banner
  static const Color paleGreenBg = Color(
    0xFFEAF6ED,
  ); // พื้นหลังการ์ด motivation
  static const Color scaffoldBg = Color(
    0xFFF7F8F7,
  ); // พื้นหลังหน้าจอ (เทาอ่อน/ขาว)
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1F2A24);
  static const Color textGrey = Color(0xFF7C8A82);
  static const Color redAccent = Color(0xFFE94E4E);
  static const Color goldColor = Color(0xFFE0B04B);
  static const Color silverColor = Color(0xFFB9BEC2);
  static const Color bronzeColor = Color(0xFFC98A4D);
  static const Color lockedGrey = Color(0xFFD9DCD9);
}

// ============================================================================
// 2) DATA MODELS
// ============================================================================

/// ข้อมูลผู้ใช้งาน
class UserModel {
  final String name;
  final int level;
  final String bio;
  final int currentXp;
  final int targetXp;
  final String? avatarUrl; // ถ้าไม่มีรูป จะใช้ไอคอน default แทน
  final int streakDays;
  final List<bool> weeklyCheckIn; // จันทร์ -> อาทิตย์ (7 ค่า)

  const UserModel({
    required this.name,
    required this.level,
    required this.bio,
    required this.currentXp,
    required this.targetXp,
    this.avatarUrl,
    required this.streakDays,
    required this.weeklyCheckIn,
  });

  double get progress => (currentXp / targetXp).clamp(0.0, 1.0);
  int get xpToNextLevel => (targetXp - currentXp).clamp(0, targetXp);
}

/// เหรียญรางวัล / ความสำเร็จ
class AchievementModel {
  final String title;
  final IconData icon;
  final Color badgeColor;
  final bool isUnlocked;

  const AchievementModel({
    required this.title,
    required this.icon,
    required this.badgeColor,
    required this.isUnlocked,
  });
}

/// ประเภทของธุรกรรม เพื่อเลือกไอคอนที่เหมาะสม
enum TransactionType { scan, redeem, bonus, other }

/// ประวัติการทำรายการ (ได้ XP / ใช้ XP)
class TransactionModel {
  final String title;
  final String date; // เช่น 02/09/2568
  final String time; // เช่น 14:32
  final String location;
  final int xpChange; // ค่าบวก = ได้ XP, ค่าลบ = ใช้ XP
  final TransactionType type;

  const TransactionModel({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.xpChange,
    required this.type,
  });

  bool get isPositive => xpChange >= 0;
}

// ============================================================================
// 3) MOCK DATA
// ----------------------------------------------------------------------------
// ✏️ แก้ไขข้อมูล User / Achievements / Transactions ได้ที่นี่
// ============================================================================

final UserModel mockUser = UserModel(
  name: 'Mr. Napat',
  level: 5,
  bio: 'รักษ์โลกในแบบของใคร 🌱',
  currentXp: 350,
  targetXp: 500,
  avatarUrl:
      'https://avatars.githubusercontent.com/u/186782030?s=400&u=d619309b66f3e2755b0b48921e9fe137945b5c21&v=4', // ใส่ URL รูปได้ เช่น 'https://example.com/avatar.png'
  streakDays: 12,
  // จันทร์, อังคาร, พุธ, พฤหัส, ศุกร์, เสาร์, อาทิตย์
  weeklyCheckIn: const [true, true, true, true, true, true, false],
);

const String motivationMessage =
    'ยอดเยี่ยมมาก! คุณกำลังช่วยโลก\nไปพร้อมกับสร้างสิ่งดีๆ ให้ตัวเอง';

final List<AchievementModel> mockAchievements = [
  const AchievementModel(
    title: 'Eco Starter',
    icon: Icons.eco,
    badgeColor: AppConfig.bronzeColor,
    isUnlocked: true,
  ),
  const AchievementModel(
    title: 'Green Shopper',
    icon: Icons.shopping_bag,
    badgeColor: AppConfig.bronzeColor,
    isUnlocked: true,
  ),
  const AchievementModel(
    title: 'Eco Explorer',
    icon: Icons.location_on,
    badgeColor: AppConfig.silverColor,
    isUnlocked: true,
  ),
  const AchievementModel(
    title: 'No Plastic',
    icon: Icons.card_giftcard,
    badgeColor: AppConfig.goldColor,
    isUnlocked: true,
  ),
  const AchievementModel(
    title: 'Eco Hero',
    icon: Icons.lock,
    badgeColor: AppConfig.lockedGrey,
    isUnlocked: false,
  ),
];

final List<TransactionModel> mockTransactions = [
  const TransactionModel(
    title: 'สแกน QR code ที่ร้านกระเจี๊ยบ',
    date: '02/09/2568',
    time: '14:32',
    location: 'Cha-ji Coffee',
    xpChange: 10,
    type: TransactionType.scan,
  ),
  const TransactionModel(
    title: 'สแกน QR code ที่ร้านลูกชิ้นอ้วน',
    date: '01/09/2568',
    time: '10:18',
    location: 'ร้านลูกชิ้นอ้วน',
    xpChange: 5,
    type: TransactionType.scan,
  ),
  const TransactionModel(
    title: 'แลกกระบอกน้ำตราหมี',
    date: '03/08/2568',
    time: '17:45',
    location: 'GreenPoint Shop',
    xpChange: -50,
    type: TransactionType.redeem,
  ),
  const TransactionModel(
    title: 'โบนัสกิจกรรม แต้ม x2',
    date: '28/07/2568',
    time: '09:20',
    location: 'งาน Green Life',
    xpChange: 20,
    type: TransactionType.bonus,
  ),
];

// ============================================================================
// 4) MAIN APP & SCREEN
// ============================================================================
class GreenPointApp extends StatelessWidget {
  const GreenPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppConfig.primaryGreen,
        scaffoldBackgroundColor: AppConfig.scaffoldBg,
        fontFamily: 'Sarabun', // ถ้ามีฟอนต์ไทยในโปรเจกต์ สามารถใส่ชื่อได้ที่นี่
        colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.primaryGreen),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.scaffoldBg,
      appBar: GreenPointAppBar(appName: AppConfig.appName),
      drawer: const Appdrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileCard(user: mockUser),
              const SizedBox(height: 16),
              const MotivationBanner(message: motivationMessage),
              const SizedBox(height: 16),
              StreakSection(user: mockUser),
              const SizedBox(height: 20),
              AchievementSection(achievements: mockAchievements),
              const SizedBox(height: 20),
              TransactionSection(transactions: mockTransactions),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GreenBottomNavBar(activeIndex: 3),
    );
  }
}

// ============================================================================
// 5) WIDGETS
// ============================================================================

/// -------------------- AppBar --------------------
class GreenPointAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appName;
  const GreenPointAppBar({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConfig.scaffoldBg,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppConfig.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Text(
            appName, // ✏️ มาจาก AppConfig.appName
            style: const TextStyle(
              color: AppConfig.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: AppConfig.textDark,
                size: 28,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppConfig.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// -------------------- Profile Card --------------------
class ProfileCard extends StatelessWidget {
  final UserModel user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConfig.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppConfig.lightGreen,
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 40,
                        color: AppConfig.primaryGreen,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 14,
                    color: AppConfig.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user.name, // ✏️ user.name
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppConfig.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.eco,
                            size: 12,
                            color: AppConfig.primaryGreen,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'Level ${user.level}', // ✏️ user.level
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppConfig.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  user.bio, // ✏️ user.bio
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppConfig.textGrey,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${user.currentXp} XP', // ✏️ user.currentXp
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/ ${user.targetXp} XP', // ✏️ user.targetXp
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppConfig.textGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: user.progress, // ✏️ คำนวณจาก currentXp / targetXp
                    minHeight: 8,
                    backgroundColor: AppConfig.lockedGrey.withOpacity(0.4),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppConfig.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'อีก ${user.xpToNextLevel} XP เพื่อเลื่อนเป็น Level ${user.level + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppConfig.textGrey,
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

/// -------------------- Motivation Banner --------------------
class MotivationBanner extends StatelessWidget {
  final String message;
  const MotivationBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConfig.paleGreenBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.recycling,
              color: AppConfig.primaryGreen,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              message, // ✏️ แก้ข้อความให้กำลังใจได้ที่ motivationMessage
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppConfig.textDark,
                height: 1.4,
              ),
            ),
          ),
          const Icon(Icons.eco, color: AppConfig.primaryGreen, size: 22),
        ],
      ),
    );
  }
}

/// -------------------- Streak Section --------------------
class StreakSection extends StatelessWidget {
  final UserModel user;
  const StreakSection({super.key, required this.user});

  static const List<String> _dayLabels = [
    'จ.',
    'อ.',
    'พ.',
    'พฤ.',
    'ศ.',
    'ส.',
    'อา.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConfig.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppConfig.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: AppConfig.primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ใช้แอปต่อเนื่อง',
                      style: TextStyle(fontSize: 13, color: AppConfig.textGrey),
                    ),
                    Text(
                      '${user.streakDays} วัน', // ✏️ user.streakDays
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.only(left: 56),
            child: Text(
              'เก่งมาก! รักษ์โลกอย่างต่อเนื่อง',
              style: TextStyle(fontSize: 12, color: AppConfig.textGrey),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final bool checked = user.weeklyCheckIn.length > index
                  ? user.weeklyCheckIn[index] // ✏️ user.weeklyCheckIn
                  : false;
              return Column(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: checked
                          ? AppConfig.primaryGreen
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: checked
                            ? AppConfig.primaryGreen
                            : AppConfig.lockedGrey,
                      ),
                    ),
                    child: checked
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _dayLabels[index],
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppConfig.textGrey,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// -------------------- Achievements Section --------------------
class AchievementSection extends StatelessWidget {
  final List<AchievementModel> achievements;
  const AchievementSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Achievements', onSeeAll: () {}),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length, // ✏️ mockAchievements
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return AchievementBadge(achievement: achievements[index]);
            },
          ),
        ),
      ],
    );
  }
}

class AchievementBadge extends StatelessWidget {
  final AchievementModel achievement;
  const AchievementBadge({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final bool unlocked = achievement.isUnlocked;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: unlocked
                ? achievement.badgeColor.withOpacity(0.15)
                : AppConfig.lockedGrey.withOpacity(0.3),
            border: Border.all(
              color: unlocked ? achievement.badgeColor : AppConfig.lockedGrey,
              width: 2,
            ),
          ),
          child: Icon(
            achievement.icon,
            color: unlocked ? achievement.badgeColor : AppConfig.textGrey,
            size: 26,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 72,
          child: Text(
            achievement.title, // ✏️ achievement.title
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: unlocked ? AppConfig.textDark : AppConfig.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// -------------------- Transaction History Section --------------------
class TransactionSection extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'ประวัติการทำรายการ', onSeeAll: () {}),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppConfig.cardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: transactions.length, // ✏️ mockTransactions
            separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 62, endIndent: 16),
            itemBuilder: (context, index) {
              return TransactionTile(transaction: transactions[index]);
            },
          ),
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionTile({super.key, required this.transaction});

  IconData get _icon {
    switch (transaction.type) {
      case TransactionType.scan:
        return Icons.qr_code_scanner;
      case TransactionType.redeem:
        return Icons.card_giftcard;
      case TransactionType.bonus:
        return Icons.star;
      case TransactionType.other:
        return Icons.receipt_long;
    }
  }

  Color get _iconColor =>
      transaction.isPositive ? AppConfig.primaryGreen : AppConfig.redAccent;

  @override
  Widget build(BuildContext context) {
    final bool positive = transaction.isPositive;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(_icon, color: _iconColor, size: 20),
      ),
      title: Text(
        transaction.title, // ✏️ transaction.title
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppConfig.textDark,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${transaction.date} • ${transaction.time} • ${transaction.location}',
        style: const TextStyle(fontSize: 11, color: AppConfig.textGrey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${positive ? '+' : ''}${transaction.xpChange} XP', // ✏️ transaction.xpChange
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: positive ? AppConfig.primaryGreen : AppConfig.redAccent,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 18, color: AppConfig.textGrey),
        ],
      ),
    );
  }
}

/// -------------------- Section Header (reusable) --------------------
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConfig.textDark,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Row(
            children: [
              Text(
                'ดูทั้งหมด',
                style: TextStyle(
                  fontSize: 13,
                  color: AppConfig.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: AppConfig.primaryGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// -------------------- Bottom Navigation Bar --------------------
class GreenBottomNavBar extends StatelessWidget {
  final int activeIndex; // 0: Home, 1: Partner Store, 2: Scan, 3: Profile
  const GreenBottomNavBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                isActive: activeIndex == 0,
              ),
              _NavItem(
                icon: Icons.storefront_outlined,
                activeIcon: Icons.storefront,
                label: 'Partner Store',
                isActive: activeIndex == 1,
              ),
              _ScanButton(isActive: activeIndex == 2),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: activeIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? AppConfig.primaryGreen : AppConfig.textGrey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isActive ? activeIcon : icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

/// ปุ่ม Scan ตรงกลาง (ยกสูงขึ้นมาให้เด่น)
class _ScanButton extends StatelessWidget {
  final bool isActive;
  const _ScanButton({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? AppConfig.primaryGreen : AppConfig.textGrey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.qr_code_scanner,
            size: 16,
            color: isActive ? AppConfig.primaryGreen : AppConfig.textGrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Scan',
          style: TextStyle(
            fontSize: 11,
            color: isActive ? AppConfig.primaryGreen : AppConfig.textGrey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
