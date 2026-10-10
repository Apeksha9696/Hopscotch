import 'package:flutter/material.dart';

/// UI-only desktop ecommerce header (no login / cart logic).
class Header extends StatelessWidget {
  const Header({super.key});

  static const _links = [
    'Girls', 'Boys', 'Baby', 'Footwear', 'Toys', 'Winter Wear', 'Party Wear', 'Sale',
  ];
  static const _logoColors = [
    Color(0xFFE53935), Color(0xFFFB8C00), Color(0xFF43A047), Color(0xFF1E88E5),
    Color(0xFF8E24AA), Color(0xFFE53935), Color(0xFFFB8C00), Color(0xFF43A047), Color(0xFF1E88E5),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: LayoutBuilder(builder: (context, c) {
              final wide = c.maxWidth >= 900;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (wide)
                      Row(children: [
                        _logo(),
                        const SizedBox(width: 32),
                        Expanded(child: Center(child: _search())),
                        const SizedBox(width: 24),
                        ..._actions(),
                      ])
                    else ...[
                      Row(children: [
                        _logo(),
                        const Spacer(),
                        ..._actions(compact: true),
                      ]),
                      const SizedBox(height: 8),
                      _search(),
                    ],
                    const SizedBox(height: 4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment:
                            wide ? MainAxisAlignment.center : MainAxisAlignment.start,
                        children: [
                          for (final l in _links)
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                              ),
                              child: Text(l,
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    const name = 'Hopscotch';
    return Text.rich(
      TextSpan(children: [
        for (var i = 0; i < name.length; i++)
          TextSpan(
            text: name[i],
            style: TextStyle(color: _logoColors[i % _logoColors.length]),
          ),
      ]),
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 0.5),
    );
  }

  Widget _search() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for kids clothing, footwear and more',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  List<Widget> _actions({bool compact = false}) {
    return [
      if (!compact)
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_outline),
          label: const Text('Login'),
          style: TextButton.styleFrom(foregroundColor: Colors.black87),
        )
      else
        IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
      IconButton(
          onPressed: () {}, tooltip: 'Wishlist', icon: const Icon(Icons.favorite_border)),
      IconButton(
          onPressed: () {}, tooltip: 'Cart', icon: const Icon(Icons.shopping_bag_outlined)),
    ];
  }
}
