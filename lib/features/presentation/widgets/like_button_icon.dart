import 'package:flutter/material.dart';
import '../bloc/main_app_bloc/main_app_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final double _iconSize;
  final Color _iconColor;
  final bool _isFavorite;
  final Function _valueChanged;
  final Color? _iconDisabledColor;

  FavoriteButton({
    double? iconSize,
    Color? iconColor,
    Color? iconDisabledColor,
    bool? isFavorite,
    required Function valueChanged,
    Key? key,
  })  : _iconSize = iconSize ?? 24.0,
        _iconColor = iconColor ?? Colors.red,
        _iconDisabledColor = iconDisabledColor ?? Colors.grey[400],
        _isFavorite = isFavorite ?? false,
        _valueChanged = valueChanged,
        super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  late CurvedAnimation _curve;

  double _maxIconSize = 0.0;
  double _minIconSize = 0.0;

  final int _animationTime = 500;

  bool _isFavorite = false;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _isFavorite = widget._isFavorite;
    _maxIconSize = (widget._iconSize < 20.0)
        ? 20.0
        : (widget._iconSize > 100.0)
            ? 20.0
            : widget._iconSize;
    final double _sizeDifference = _maxIconSize * 0.10;
    _minIconSize = _maxIconSize - _sizeDifference;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationTime),
    );

    _curve = CurvedAnimation(curve: Curves.ease, parent: _controller);
    Animation<Color?> _selectedColorAnimation = ColorTween(
      begin: widget._iconColor,
      end: widget._iconDisabledColor,
    ).animate(_curve);

    Animation<Color?> _deSelectedColorAnimation = ColorTween(
      begin: widget._iconDisabledColor,
      end: widget._iconColor,
    ).animate(_curve);

    _colorAnimation = (_isFavorite == true)
        ? _selectedColorAnimation
        : _deSelectedColorAnimation;
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _minIconSize,
            end: _maxIconSize,
          ),
          weight: 5,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: _maxIconSize,
            end: _minIconSize,
          ),
          weight: 5,
        ),
      ],
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimationCompleted = true;
        _isFavorite = !_isFavorite;
        widget._valueChanged(_isFavorite);
      } else if (status == AnimationStatus.dismissed) {
        _isAnimationCompleted = false;
        _isFavorite = !_isFavorite;
        widget._valueChanged(_isFavorite);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return InkResponse(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              if (_isAnimationCompleted == true) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            });
          },
          child: Row(
            children: [
              Icon(
                _isFavorite == true?(Icons.favorite):(Icons.favorite_outline),
                color: _colorAnimation.value,
                size: _sizeAnimation.value,
              ),
              const SizedBox(width: 6,),
              const Text('Like',style: TextStyle(color: Colors.black),)
            ],
          ),
        );
      },
    );
  }
}
