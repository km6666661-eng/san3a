import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import 'budget_time_screen.dart';
import 'widgets/category_grid.dart';
import 'widgets/description_field.dart';
import 'widgets/location_section.dart';
import 'widgets/step_indicator.dart';
import 'widgets/urgency_grid.dart';

class RequestScreen extends StatefulWidget {
  final bool isTechnician;
  const RequestScreen({super.key, this.isTechnician = false});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String _selectedCategory = 'نجارة';
  String _selectedUrgency = 'عادي';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.pageTop),
                  Center(child: StepIndicator(activeStep: 1, label: 'تفاصيل الطلب')),
                  SizedBox(height: 28),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('الفئة'),
                        SizedBox(height: 12),
                        CategoryGrid(
                          selected: _selectedCategory,
                          onSelected: (v) => setState(() => _selectedCategory = v),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('وصف المشكلة'),
                        SizedBox(height: 12),
                        DescriptionField(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('مستوى الإلحاح'),
                        SizedBox(height: 12),
                        UrgencyGrid(
                          selected: _selectedUrgency,
                          onSelected: (v) => setState(() => _selectedUrgency = v),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildWhiteCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _sectionTitle('الموقع'),
                        SizedBox(height: 12),
                        LocationSection(),
                      ],
                    ),
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
                  builder: (_) => BudgetTimeScreen(isTechnician: widget.isTechnician),
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
