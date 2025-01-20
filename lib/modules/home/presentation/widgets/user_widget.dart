import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.image,
    required this.address,
  });
  final String image;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'التوصيل لـ',
                style: labelStyle,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Text(
                      address,
                      style: labelStyle?.copyWith(color: myGreenColor),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    color: myGreenColor,
                    size: 20,
                  ),
                ],
              )
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              image,
            ),
          )
        ],
      ),
    );
  }
}
