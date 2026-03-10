import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppDropDown extends StatelessWidget {
  final String? label;
  final String hintText;
  final String? value;
  final bool hideLabel;
  final bool isRequired;
  final List<String> items;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  const AppDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    this.label,
    this.validator,
    this.onChanged,
    this.hideLabel = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideLabel && label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${label!}${isRequired ? ' *' : ''}',
              style: const TextStyle(fontSize: 14, color: AppTheme.titleColor),
            ),
          ),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<String>(
              validator: validator,
              hint: Text(
                hintText,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.capColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              elevation: 1,
              isDense: true,
              isExpanded: true,
              initialValue: value,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: AppTheme.fontFamily,
              ),
              icon: Icon((MdiIcons.chevronDown), color: AppTheme.capColor),
              onChanged: onChanged,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: AppTheme.textFieldInputDecoration.copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items: items.map((e) => buildMenuItem(e)).toList(),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((String item) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.titleColor,
                        fontFamily: AppTheme.fontFamily,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    alignment: AlignmentDirectional.centerStart,
    child: Text(
      item,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.titleColor,
        fontFamily: AppTheme.fontFamily,
      ),
    ),
  );
}
