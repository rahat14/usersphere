import 'package:flutter/material.dart';
import 'package:usersphere/core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

class SearchInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onReset;

  const SearchInputField({
    super.key,
    required this.onChanged,
    required this.onReset,
  });

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // Rebuild to toggle clear icon
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        cursorColor: AppColors.textSubTitle,
        decoration: InputDecoration(
          hintText: 'Search users...',
          hintStyle: CustomTextStyle.of(context).bodyMediumStyle(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _controller.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.textSubTitle,
                    ),
                    onPressed: () {
                      _controller.clear();
                      widget.onReset();
                      //  widget.onChanged('');
                    },
                  )
                  : null,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
