import 'package:flutter/material.dart';

import '../constants/colors_resources.dart';
import 'global_text.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      minLeadingWidth: 0,
      onTap: onTap,
      title: GlobalText(
        str: title,
        color: ColorRes.deep300,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: trailing,
    );
  }
}

class CustomIconListTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final void Function()? onTap;

  const CustomIconListTile({
    super.key,
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title ?? ''),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}

class CustomSubListTile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final Color? iconColor;
  final void Function()? onTap;

  const CustomSubListTile({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title ?? '', style: const TextStyle(fontSize: 14, color: ColorRes.white)),
        leading: Icon(icon, size: 25, color: iconColor
        ),
        onTap: onTap,
        subtitle: Text(subTitle ?? '', style: const TextStyle(fontSize: 12, color: ColorRes.grey),
        ));
  }
}