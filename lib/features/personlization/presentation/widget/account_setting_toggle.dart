import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class AccountSettingToggle extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color activeColor;
  final bool isDark;
  final bool hasToggle;

  const AccountSettingToggle({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.activeColor = AppColors.dashboardAppbarBackground,
    this.isDark = false,
    this.hasToggle = true,
  });

  @override
  State<AccountSettingToggle> createState() => _AccountSettingToggleState();
}

class _AccountSettingToggleState extends State<AccountSettingToggle> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: widget.isDark
                  ? AppColors.textWhite.withValues(alpha: 0.04)
                  : AppColors.grey10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(widget.icon, size: 20, color: widget.activeColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          widget.hasToggle
              ? Switch.adaptive(
                  value: value,
                  onChanged: (v) => setState(() => value = v),
                  activeColor: widget.activeColor,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
