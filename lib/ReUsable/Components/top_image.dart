import 'package:flutter/material.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';


class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: Image.asset("assets/icons/travel.jpg" , fit: BoxFit.fill,),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: AppColors.defaultPadding * 2),
      ],
    );
  }
}


