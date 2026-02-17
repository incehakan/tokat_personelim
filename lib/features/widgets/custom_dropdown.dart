import 'package:flutter/material.dart';
import '../../product/constants/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.initialSelection,
    required this.length,
    required this.values,
    required this.onSelected,
  }) : super(key: key);

  final T initialSelection;
  final int length;
  final List<T> values;
  final Function(T type) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.riverBed,
      ),
      selectedTrailingIcon: const Icon(
        Icons.arrow_drop_up,
        color: AppColors.riverBed,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.spindle,
        border: InputBorder.none,
      ),
      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.kashmirBlue,
          ),
      width: MediaQuery.of(context).size.width * 0.9,
      initialSelection: initialSelection,
      menuStyle: const MenuStyle(
        elevation: MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(
          AppColors.spindle,
        ),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      dropdownMenuEntries: List.generate(
        length,
        (index) => DropdownMenuEntry(
          value: values[index],
          label: values[index].toString(),
          style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              AppColors.kashmirBlue,
            ),
          ),
        ),
      ),
      onSelected: (T? type) {
        if (type != null) {
          onSelected(type);
        }
      },
    );
  }
}
