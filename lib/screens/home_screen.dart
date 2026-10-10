import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../models/homepage_response.dart';
import '../models/page_component.dart';
import '../services/api_service.dart';
import '../widgets/category_section.dart';
import '../widgets/coupon_corner.dart';
import '../widgets/error_view.dart';
import '../widgets/header.dart';
import '../widgets/hero_banner.dart';
import '../widgets/loading_view.dart';
import '../widgets/shop_by_occasion.dart';
import '../widgets/shop_for_all.dart';
import '../widgets/steals_section.dart';
import '../widgets/trends_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();
  late Future<HomepageResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.fetchHomepage();
  }

  void _retry() {
    setState(() {
      _future = _api.fetchHomepage();
    });
  }

  /// Finds a section by words in its API name (e.g. "hero", "flash").
  /// If the name does not match, falls back to its position in the list.
  PageComponent? _pick(List<PageComponent> all, List<String> keywords, int index) {
    for (final c in all) {
      final name = c.name.toLowerCase();
      if (keywords.every((k) => name.contains(k))) return c;
    }
    return index < all.length ? all[index] : null;
  }

  /// Centers content and limits its width on big screens.
  Widget _section(Widget child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConfig.maxContentWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child,
          ),
        ),
      );

  Widget _buildPage(HomepageResponse data) {
    final all = data.components;
    final hero = _pick(all, ['hero'], 0);
    final occasion = _pick(all, ['wardrobe'], 1);
    final trends = _pick(all, ['trends'], 2);
    final coupon = _pick(all, ['coupon'], 3);
    final girls = _pick(all, ['girl'], 4);
    final boys = _pick(all, ['boy'], 5);
    final steals = _pick(all, ['steals'], 6);
    final shopAll = _pick(all, ['shop_for_all'], 7);

    const gap = SizedBox(height: 48);

    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (hero != null) HeroBanner(component: hero),
            gap,
            if (occasion != null) ...[_section(ShopByOccasion(component: occasion)), gap],
            if (trends != null) ...[_section(TrendsSection(component: trends)), gap],
            if (coupon != null) ...[_section(CouponCorner(component: coupon)), gap],
            if (girls != null) ...[
              _section(CategorySection(component: girls, fallbackTitle: 'Shop for Girls')),
              gap,
            ],
            if (boys != null) ...[
              _section(CategorySection(component: boys, fallbackTitle: 'Shop for Boys')),
              gap,
            ],
            if (steals != null) ...[_section(StealsSection(component: steals)), gap],
            if (shopAll != null) ...[_section(ShopForAll(component: shopAll)), gap],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: FutureBuilder<HomepageResponse>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const LoadingView();
                }
                if (snapshot.hasError) {
                  return ErrorView(
                    message: snapshot.error.toString(),
                    onRetry: _retry,
                  );
                }
                return _buildPage(snapshot.data!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
