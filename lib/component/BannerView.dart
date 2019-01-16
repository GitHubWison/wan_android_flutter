import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/Loading.dart';

class BannerView extends StatelessWidget {
  final List<BannerBean> list;

  BannerView(this.list);

  @override
  Widget build(BuildContext context) {
    if (list.length==0) {
      return Loading();
    }
    return Swiper(
      itemCount: list.length,
      itemBuilder: (context, index) {
        BannerBean temp = list[index];
        return Image.network(
          temp.imagePath,
          fit: BoxFit.fill,
        );
      },
      loop: true,
      autoplay: true,
      pagination: SwiperCustomPagination(builder: (context, config) {
        BannerBean temp = list[config.activeIndex];
        return Text(temp.title);
      }),
    );
  }
}
