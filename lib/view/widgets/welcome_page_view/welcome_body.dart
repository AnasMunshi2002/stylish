import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/shared_pref/login/login_pref_manager.dart';
import '../../../view_models/navigation_provider/navigation_provider.dart';
import '../../../view_models/page_view_provider/page_view_provider.dart';
import '../../../view_models/theme_provider/colors/common.dart';
import '../../../view_models/theme_provider/theme.dart';
import '../../screens/main_pages/home/home_page.dart';
import '../../screens/starting/get_started.dart';
import '../responsive_size/responsive_size.dart';
import '../tb/tb.dart';
import 'animated_container/animated_dots.dart';
import 'welcome_page_view.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final pageView = Provider.of<PageViewProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              pageView.changePage(index);
            },
            children: const [
              WelcomePageView(
                  image: 'assets/logo/fashion shop-rafiki 1.png',
                  title: "Choose Products"),
              WelcomePageView(
                  image: 'assets/logo/Sales consulting-pana 1.png',
                  title: "Make Payment"),
              WelcomePageView(
                  image: 'assets/logo/Shopping bag-rafiki 1.png',
                  title: "Get Your Order")
            ],
          ),
        ),
        PageIndicator(
          currentPageIndex: pageView.pageNo,
          tabController: _tabController,
          onUpdateCurrentPage: _updateCurrentPage,
        ),
      ],
    );
  }

  void _updateCurrentPage() {
    _tabController.index = context.read<PageViewProvider>().pageNo;
    _pageController.animateToPage(context.read<PageViewProvider>().pageNo,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final TabController tabController;
  final void Function() onUpdateCurrentPage;

  const PageIndicator(
      {super.key,
      required this.currentPageIndex,
      required this.tabController,
      required this.onUpdateCurrentPage});

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    final pageView = Provider.of<PageViewProvider>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: Visibility(
              visible: pageView.pageNo != 0,
              child: TB(
                  style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(themeColor.primary),
                      alignment: Alignment.centerLeft),
                  event: () {
                    pageView.changePage(pageView.pageNo - 1);
                    onUpdateCurrentPage();
                  },
                  text: "Prev",
                  fontSize: ResponsiveSize.getMediumFont(context),
                  weight: "M600",
                  color: themeColor.tertiary))),
      const Row(
        children: [
          AnimatedDots(currentPage: 0),
          SizedBox(width: 10),
          AnimatedDots(currentPage: 1),
          SizedBox(width: 10),
          AnimatedDots(currentPage: 2)
        ],
      ),
      Expanded(
          child: TB(
              style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(themeColor.primary),
                  alignment: Alignment.centerRight),
              event: () {
                if (pageView.pageNo == 2) {
                  if (LoginManager.getIsLogin()) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                    context.read<NavigationProvider>().changePage(0);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetStartedScreen()));
                  }
                } else {
                  context
                      .read<PageViewProvider>()
                      .changePage(pageView.pageNo + 1);
                  onUpdateCurrentPage();
                }
              },
              fontSize: ResponsiveSize.getMediumFont(context),
              text: context.read<PageViewProvider>().pageNo == 2
                  ? "Get started"
                  : "Next",
              weight: "M600",
              color: CommonColors.navBarActive)),
    ]);
  }
}
