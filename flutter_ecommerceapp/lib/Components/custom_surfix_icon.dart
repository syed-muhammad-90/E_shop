import 'package:flutter/material.dart';
import 'package:flutter_ecommerceapp/constrains/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomSurffixIcon extends StatelessWidget {
  final IconData data;
  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon,this.data
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(18),
      ),
    );
  }
}
