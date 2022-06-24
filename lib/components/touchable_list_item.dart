import 'package:flutter/material.dart';

class TouchableListItem extends StatelessWidget {
  const TouchableListItem({
    Key? key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  final void Function()? onTap;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xffeeeeee),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                icon,
                size: 56,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 40.0,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 40.0,
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
