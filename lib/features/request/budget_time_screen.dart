import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import 'publish_screen.dart';
import 'widgets/budget_input.dart';
import 'widgets/day_selector.dart';
import 'widgets/info_box.dart';
import 'widgets/step_indicator.dart';
import 'widgets/summary_card.dart';
import 'widgets/time_selector.dart';

class BudgetTimeScreen extends StatefulWidget {
  const BudgetTimeScreen({super.key});

  @override
  State<BudgetTimeScreen> createState() => _BudgetTimeScreenState();
}

class _BudgetTimeScreenState extends State<BudgetTimeScreen> {
  final _minController = TextEditingController(text: '200');
  final _maxController = TextEditingController(text: '500');

  int _selectedDayIndex = 1;
  int _selectedTimeIndex = 1;

  static const List<Map<String, String>> _days = [
    {'day': 'الاثنين', 'date': '20'},
    {'day': 'الثلاثاء', 'date': '21'},
    {'day': 'الأربعاء', 'date': '22'},
    {'day': 'الخميس', 'date': '23'},
    {'day': 'الجمعة', 'date': '24'},
  ];

  static const List<String> _times = [
    '09:00 ص',
    '10:00 ص',
    '11:00 ص',
    '01:00 م',
    '03:00 م',
    '05:00 م',
  ];

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  String get _budgetRange =>
      '${_minController.text} - ${_maxController.text} ج';

  String get _preferredDate {
    final day = _days[_selectedDayIndex];
    return '${day['day']} ${day['date']} - ${_times[_selectedTimeIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.borderLight.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
              child: Column(
                children: [
                  Center(
                    child: StepIndicator(activeStep: 2, label: 'الميزانية والوقت'),
                  ),
                  SizedBox(height: 28),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('نطاق الميزانية (بالجنيه)'),
                        SizedBox(height: 12),
                        BudgetInput(
                          minController: _minController,
                          maxController: _maxController,
                        ),
                        SizedBox(height: 12),
                        InfoBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('الوقت المفضل'),
                        SizedBox(height: 12),
                        DaySelector(
                          selectedIndex: _selectedDayIndex,
                          onSelected: (v) =>
                              setState(() => _selectedDayIndex = v),
                        ),
                        SizedBox(height: 12),
                        TimeSelector(
                          selectedIndex: _selectedTimeIndex,
                          onSelected: (v) =>
                              setState(() => _selectedTimeIndex = v),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SummaryCard(
                    budgetRange: _budgetRange,
                    preferredDate: _preferredDate,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _bottomButton(),
        ],
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _bottomButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pageHorizontal,
        AppSpacing.md,
        AppSpacing.pageHorizontal,
        AppSpacing.pageBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PublishScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(27),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Text('التالي'),
          ),
        ),
      ),
    );
  }
}
