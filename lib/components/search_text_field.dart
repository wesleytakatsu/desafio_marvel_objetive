import 'package:flutter/material.dart';

class SearchContainer extends StatelessWidget {
  final bool mobileViewPortrait;
  final Function(String) onChanged;

  const SearchContainer({
    super.key,
    required this.mobileViewPortrait,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: mobileViewPortrait ? borderTopBottonSizePortrait : borderTopBottonSizeLandscape,
        bottom: mobileViewPortrait ? borderTopBottonSizePortrait : borderTopBottonSizeLandscape,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nome do Personagem',
            style: TextStyle(
              color: Color(0xFFD42026),
              fontSize: 16,
              fontFamily: 'Roboto-Light',
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 31,
            width: !mobileViewPortrait ? 400 : MediaQuery.of(context).size.width,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Color(0xFFD42026),
                    width: 1,
                  ),
                ),
              ),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
