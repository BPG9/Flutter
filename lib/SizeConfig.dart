import 'package:flutter/widgets.dart';

class SizeConfig {
			static MediaQueryData _mediaQueryData;
			static double screenWidth;
			static double screenHeight;
			static double blockSizeHorizontal;
			static double blockSizeVertical;
			
			static double _safeAreaHorizontal;
			static double _safeAreaVertical;
			static double safeBlockHorizontal;
			static double safeBlockVertical;
      static Orientation orientationDevice;
			
			void init(BuildContext context) {
				_mediaQueryData = MediaQuery.of(context);
				screenWidth = _mediaQueryData.size.width;
				screenHeight = _mediaQueryData.size.height;
				blockSizeHorizontal = screenWidth / 100;
				blockSizeVertical = screenHeight / 100;
        orientationDevice = _mediaQueryData.orientation;

        // TODO find ideal offset (first test: +42)
				_safeAreaHorizontal = _mediaQueryData.padding.left + 
					_mediaQueryData.padding.right+42;
				_safeAreaVertical = _mediaQueryData.padding.top +
					_mediaQueryData.padding.bottom;
				safeBlockHorizontal = (screenWidth -
					_safeAreaHorizontal) / 100;
				safeBlockVertical = (screenHeight -
					_safeAreaVertical) / 100;
			}
		}