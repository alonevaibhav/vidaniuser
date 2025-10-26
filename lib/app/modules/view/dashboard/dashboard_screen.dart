import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/Theme/app_theme.dart';
import '../../../core/widgets/theme_toggle.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedPlantIndex = 0;
  bool _isMonitoring = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            actions: [
              ThemeToggleButton(),
              SizedBox(width: AppTheme.space8),
              IconButton(
                icon: Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              SizedBox(width: AppTheme.space8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppTheme.radiusXLarge),
                    bottomRight: Radius.circular(AppTheme.radiusXLarge),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppTheme.space24,
                      60,
                      AppTheme.space24,
                      AppTheme.space24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.space12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.success.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.success,
                                    ),
                                  ),
                                  SizedBox(width: AppTheme.space8),
                                  Text(
                                    'Live',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: AppTheme.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.space16),
                        Text(
                          'Solar Dashboard',
                          style: textTheme.displaySmall,
                        ),
                        SizedBox(height: AppTheme.space8),
                        Text(
                          'Monitor your solar energy in real-time',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    SizedBox(height: AppTheme.space24),
                    _buildStatsCards(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernPlantSelector(),
                    SizedBox(height: AppTheme.space24),
                    _buildEnergyFlowCard(),
                    SizedBox(height: AppTheme.space24),
                    _buildQuickActions(),
                    SizedBox(height: AppTheme.space24),
                    _buildFeaturesGrid(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernSocialProof(),
                    SizedBox(height: AppTheme.space24),
                    _buildModernCTA(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final stats = [
      {
        'icon': Icons.bolt,
        'value': '45.2',
        'unit': 'kW',
        'label': 'Power',
        'color': AppTheme.primary
      },
      {
        'icon': Icons.eco,
        'value': '1.2',
        'unit': 'tons',
        'label': 'CO₂ Saved',
        'color': AppTheme.success
      },
      {
        'icon': Icons.savings,
        'value': '₹8.5',
        'unit': 'K',
        'label': 'Saved',
        'color': AppTheme.warning
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Row(
        children: stats.map((stat) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.space4),
              padding: EdgeInsets.all(AppTheme.space16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: theme.brightness == Brightness.dark
                    ? AppTheme.darkShadowSmall
                    : AppTheme.shadowSmall,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (stat['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: stat['color'] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: AppTheme.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        stat['value'] as String,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          stat['unit'] as String,
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.space4),
                  Text(
                    stat['label'] as String,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernPlantSelector() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final plants = [
      {
        'name': 'Mumbai Solar Park',
        'power': '45.2 kW',
        'efficiency': 94,
        'icon': Icons.apartment
      },
      {
        'name': 'Pune Industrial',
        'power': '38.7 kW',
        'efficiency': 89,
        'icon': Icons.factory
      },
      {
        'name': 'Nashik Rooftop',
        'power': '22.5 kW',
        'efficiency': 91,
        'icon': Icons.home
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Your Plants',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedPlantIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedPlantIndex = index),
                child: Container(
                  width: 280,
                  margin: EdgeInsets.only(right: AppTheme.space12),
                  padding: EdgeInsets.all(AppTheme.space20),
                  decoration: BoxDecoration(
                    color: isSelected ? colorScheme.primary : colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
                    border: isSelected
                        ? null
                        : Border.all(color: colorScheme.outline),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ]
                        : (theme.brightness == Brightness.dark
                        ? AppTheme.darkShadowSmall
                        : AppTheme.shadowSmall),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppTheme.space12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                            child: Icon(
                              plants[index]['icon'] as IconData,
                              color: isSelected ? Colors.white : colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.space12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : AppTheme.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                            ),
                            child: Text(
                              '${plants[index]['efficiency']}%',
                              style: textTheme.labelMedium?.copyWith(
                                color: isSelected ? Colors.white : AppTheme.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        plants[index]['name'] as String,
                        style: textTheme.titleLarge?.copyWith(
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                      SizedBox(height: AppTheme.space8),
                      Row(
                        children: [
                          Icon(
                            Icons.bolt,
                            size: 16,
                            color: isSelected
                                ? Colors.white70
                                : textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                          SizedBox(width: 4),
                          Text(
                            plants[index]['power'] as String,
                            style: textTheme.bodyMedium?.copyWith(
                              color: isSelected ? Colors.white70 : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyFlowCard() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
          boxShadow: theme.brightness == Brightness.dark
              ? AppTheme.darkShadowSmall
              : AppTheme.shadowSmall,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Energy Flow',
                  style: textTheme.titleLarge,
                ),
                Switch.adaptive(
                  value: _isMonitoring,
                  onChanged: (value) => setState(() => _isMonitoring = value),
                  activeColor: AppTheme.success,
                ),
              ],
            ),
            SizedBox(height: AppTheme.space32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlowNode('Solar', Icons.wb_sunny, AppTheme.warning),
                Icon(Icons.arrow_forward, color: colorScheme.outline),
                _buildFlowNode('Battery', Icons.battery_charging_full, colorScheme.primary),
                Icon(Icons.arrow_forward, color: colorScheme.outline),
                _buildFlowNode('Home', Icons.home, AppTheme.success),
              ],
            ),
            SizedBox(height: AppTheme.space32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Production',
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      '45.2 kW',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.space12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.75,
                    minHeight: 8,
                    backgroundColor: colorScheme.outline.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowNode(String label, IconData icon, Color color) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3), width: 2),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: AppTheme.space8),
        Text(
          label,
          style: textTheme.labelMedium,
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final actions = [
      {
        'icon': Icons.cleaning_services,
        'title': 'Start\nCleaning',
        'color': AppTheme.success
      },
      {
        'icon': Icons.play_circle_outline,
        'title': 'Auto\nMode',
        'color': colorScheme.primary
      },
      {'icon': Icons.schedule, 'title': 'Schedule', 'color': AppTheme.warning},
      {'icon': Icons.analytics, 'title': 'Reports', 'color': AppTheme.accent},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Quick Actions',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(right: AppTheme.space12),
                  padding: EdgeInsets.all(AppTheme.space16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: colorScheme.outline),
                    boxShadow: theme.brightness == Brightness.dark
                        ? AppTheme.darkShadowSmall
                        : AppTheme.shadowSmall,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (actions[index]['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: Icon(
                          actions[index]['icon'] as IconData,
                          color: actions[index]['color'] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: AppTheme.space8),
                      Text(
                        actions[index]['title'] as String,
                        textAlign: TextAlign.center,
                        style: textTheme.labelSmall?.copyWith(
                          height: 1.2,
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
    );
  }

  Widget _buildFeaturesGrid() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final features = [
      {
        'icon': Icons.phone_android,
        'title': 'Remote Control',
        'desc': 'Control from anywhere',
        'color': colorScheme.primary,
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Smart Alerts',
        'desc': 'Get instant notifications',
        'color': AppTheme.warning,
      },
      {
        'icon': Icons.eco,
        'title': 'Eco Impact',
        'desc': 'Track carbon reduction',
        'color': AppTheme.success,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.space20),
          child: Text(
            'Features',
            style: textTheme.headlineMedium,
          ),
        ),
        SizedBox(height: AppTheme.space16),
        ...features.map((feature) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.space16,
            vertical: 6,
          ),
          child: Container(
            padding: EdgeInsets.all(AppTheme.space20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              border: Border.all(color: colorScheme.outline),
              boxShadow: theme.brightness == Brightness.dark
                  ? AppTheme.darkShadowSmall
                  : AppTheme.shadowSmall,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (feature['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: feature['color'] as Color,
                    size: 28,
                  ),
                ),
                SizedBox(width: AppTheme.space16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: textTheme.titleMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        feature['desc'] as String,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: colorScheme.outline,
                ),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildModernSocialProof() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
          border: Border.all(color: colorScheme.outline),
          boxShadow: theme.brightness == Brightness.dark
              ? AppTheme.darkShadowSmall
              : AppTheme.shadowSmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('500+', 'Plants', textTheme, colorScheme),
            Container(width: 1, height: 40, color: colorScheme.outline),
            _buildStatItem('10K+', 'Users', textTheme, colorScheme),
            Container(width: 1, height: 40, color: colorScheme.outline),
            _buildStatItem('₹2Cr+', 'Saved', textTheme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        Text(
          value,
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildModernCTA() {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.space16),
      child: Container(
        padding: EdgeInsets.all(AppTheme.space32),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              '🚀',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: AppTheme.space16),
            Text(
              'Ready to Get Started?',
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.space8),
            Text(
              'Join thousands of users saving energy',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.space24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                foregroundColor: colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.space32,
                  vertical: AppTheme.space16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create Free Account',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: AppTheme.space8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}