import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/app_colors.dart';
import 'app_text.dart';

class _AppButton extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final Color color;
  final double? borderRadius;
  final double? wigth;
  final double? heigth;
  final TextStyle? styleTitle;
  final FontWeight? textWeight;

  final Color? textColor;
  final bool? withElevation;
  final double? size;

  const _AppButton({
    Key? key,
    this.title,
    this.onTap,
    this.size,
    this.styleTitle,
    this.heigth,
    this.wigth,
    this.borderRadius,
    this.textWeight,
    required this.color,
    this.textColor,
    this.withElevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimatedButton(
      width: wigth ?? double.infinity,
      height: heigth,
      pressEvent: () {
        if (onTap != null) {
          onTap!();
        }
      },
      withElevation: withElevation,
      color: color,
      buttonTextStyle: GoogleFonts.montserrat(
        fontSize: size ?? 16,
        fontWeight: textWeight ?? FontWeight.normal,
        color: textColor ?? Colors.white,
      ),
      text: title,
      borderRadius: BorderRadius.circular(borderRadius ?? 15),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  final String? hero;
  final bool enabled;
  final Color? backGroundColor;
  final double? borderRadius;
  final TextStyle? textStyle;

  const PrimaryButton({
    Key? key,
    this.title,
    this.onTap,
    this.textStyle,
    this.borderRadius,
    this.hero,
    this.enabled = true,
    this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: hero ?? 'primary_button',
      child: SizedBox(
        height: 50,
        child: _AppButton(
          borderRadius: borderRadius,
          title: title,
          size: textStyle?.fontSize,
          textWeight: textStyle?.fontWeight,
          textColor: textStyle?.color,
          color: enabled ? AppColors.primaryColor : AppColors.blackGrey1,
          onTap: onTap,
          withElevation: false,
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final Color? color;
  final String? hero;
  final bool withElevation;
  final double? radius;
  final Widget? child;
  final TextStyle? buttonTextStyle;

  const CircularButton(
      {this.title,
      this.color,
      this.child,
      this.withElevation = true,
      this.buttonTextStyle,
      this.radius,
      this.hero,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return _AnimatedButton(
        borderRadius: BorderRadius.circular(2312312312),
        width: radius ?? 60,
        height: radius ?? 60,
        buttonTextStyle: buttonTextStyle,
        withElevation: withElevation,
        isFixedHeight: false,
        color: color ?? AppColors.white,
        text: title,
        pressEvent: () {
          onTap!();
        },
        child: child);
  }
}

class CustomButton extends StatelessWidget {
  final Widget? child;
  final Function? onTap;
  final Color? color;
  final double? wigth;
  final double? hiegth;
  final double? borderRadius;
  const CustomButton(
      {Key? key,
      this.borderRadius,
      this.child,
      this.color,
      this.hiegth,
      this.onTap,
      this.wigth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AnimatedButton(
        borderRadius: BorderRadius.circular(borderRadius ?? 2312312312),
        width: wigth ?? double.infinity,
        height: hiegth ?? 60,
        isFixedHeight: false,
        withElevation: false,
        color: color ?? AppColors.white,
        child: child,
        pressEvent: () {
          onTap!();
        });
  }

  static Widget iconButton({Function? onTab, Widget? child, double? radius}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(12312),
              onTap: () {
                onTab!();
              },
              child: Container(
                  alignment: Alignment.center,
                  width: radius ?? 45,
                  height: radius ?? 45,
                  child: child))),
    );
  }

  static Widget radio<T>({
    required T value,
    required T groupValue,
    required Function onTab,
  }) {
    return iconButton(
      onTab: () {
        onTab();
      },
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(123), color: AppColors.white),
        child: TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 100),
            tween: Tween(begin: 0, end: value == groupValue ? 8 : 0),
            curve: Curves.bounceOut,
            builder: (context, value, _) {
              return CircleAvatar(
                radius: value,
                backgroundColor: AppColors.primaryColor,
              );
            }),
      ),
    );
  }

  static Widget dropdownButton<T>({
    required Function(String? value) onChanged,
    String? value,
    List<String>? items,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        menuMaxHeight: 200,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        iconEnabledColor: AppColors.grey,
        dropdownColor: AppColors.white,
        alignment: Alignment.center,
        elevation: 0,
        isExpanded: true,
        value: value.toString(),
        items: List.generate(items?.length ?? 0, (index) {
          return DropdownMenuItem(
            value: items![index],
            child: AppText(
              (items[index]),
              size: 18,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        onChanged: onChanged,
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final Function pressEvent;
  final String? text;
  final double width;
  final double? height;
  final bool isFixedHeight;
  final Widget? child;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? buttonTextStyle;
  final bool? withElevation;

  const _AnimatedButton({
    required this.pressEvent,
    this.text,
    this.child,
    this.color,
    this.height,
    this.isFixedHeight = false,
    this.width = double.infinity,
    this.borderRadius,
    this.buttonTextStyle,
    this.withElevation,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  static const int _forwardDurationNumber = 150;
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _forwardDurationNumber),
      reverseDuration: const Duration(milliseconds: 100),
    )..addStatusListener(
        _animationStatusListener,
      );
    _scale = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTap() async {
    _animationController.forward();
    //Delayed added in purpose to keep same animation behavior as previous version when dialog was closed while animation was still playing
    await Future.delayed(
      const Duration(milliseconds: _forwardDurationNumber ~/ 2),
    );
    widget.pressEvent();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: _animatedButtonUI,
    );
  }

  Widget get _animatedButtonUI => SizedBox(
        width: widget.width,
        height: widget.isFixedHeight ? 50 : widget.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: (widget.withElevation ?? true) ? 3 : 0,
              primary: widget.color,
              shadowColor: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: widget.borderRadius ??
                    const BorderRadius.all(
                      Radius.circular(15),
                    ),
              )),
          onPressed: _onTap,
          child: Stack(
            children: [
              Align(
                child: widget.child ??
                    AppText(
                      '${widget.text}',
                      // maxLines: 1,
                      color: widget.buttonTextStyle?.color ?? AppColors.white,
                      fontWeight: widget.buttonTextStyle?.fontWeight ??
                          FontWeight.normal,
                      size: widget.buttonTextStyle?.fontSize,
                    ),
              ),
            ],
          ),
        ),
      );
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    this.onTap,
    this.icon,
    this.borderRadius,
    required this.label,
    required this.color,
    this.size,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget? icon;
  final String label;
  final Color color;
  final Size? size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onTap?.call();
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
          color: color,
          width: 2,
        )),
        overlayColor: MaterialStateProperty.all<Color>(color.withOpacity(0.1)),
        minimumSize: MaterialStateProperty.all<Size>(
          size ?? Size(MediaQuery.of(context).size.width * .8, 45),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
            side: BorderSide(color: color),
          ),
        ),
      ),
      child: AppText(
        label,
        size: 16,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
