import 'package:flutter/material.dart';
import 'package:souqna_app/features/auth/presentation/screens/welcome_screen.dart';

// نموذج بسيط لتخزين بيانات كل شاشة ترحيب
class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // قائمة بيانات الشاشات
  final List<OnboardingItem> _pages = [
    OnboardingItem(
      title: 'مرحباً في سوقنا',
      description: 'تصفح آلاف المنتجات من المتاجر المحلية في مدينتك بكل سهولة.',
      icon: Icons.search,
    ),
    OnboardingItem(
      title: 'ادعم مجتمعك',
      description:
          'بكل عملية شراء، أنت تدعم أصحاب المتاجر المحليين وتساهم في نمو اقتصاد مدينتك.',
      icon: Icons.people_outline,
    ),
    OnboardingItem(
      title: 'استلم طلباتك بسرعة',
      description:
          'اطلب عبر التطبيق واستلم طلباتك مباشرة من المتجر بدون انتظار.',
      icon: Icons.shopping_bag_outlined,
    ),
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // الجزء العلوي: الشاشات القابلة للسحب
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, size: 100, color: Colors.teal),
                      const SizedBox(height: 40),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            // الجزء السفلي: نقاط وزر
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // النقاط
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.teal
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  // الزر
                  FloatingActionButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // الانتقال إلى شاشة الاختيار بين تسجيل الدخول وإنشاء حساب
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.teal,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
