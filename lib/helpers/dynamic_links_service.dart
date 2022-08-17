import 'package:e_commerce_num2/models/product_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info/package_info.dart';

class DynamicLinksService {
  static Future<String> createDynamicLink(ProductModel model) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.packageName);
    String uriPrefix = "https://ecommerce82.page.link";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('$uriPrefix/${model.id}'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 125,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: packageInfo.version,
        // appStoreId: '123456789',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: model.title,
        description: model.name,
        imageUrl: Uri.parse(model.image!),
      ),
    );

    final shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl.toString();
  }

  static Future<void> initDynamicLinks() async {
    print("initDynamicLinks");

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      print("Deep Link");
      print(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLinkData) {
        _handleDynamicLink(dynamicLinkData.link);
      },
      onError: (error) {
        print("Error ${error.toString()}");
      },
      onDone: () {
        print("Done Function");
      },
    );
  }

  static void _handleDynamicLink(Uri uri) async {
    List<String> separated = [];
    separated = uri.pathSegments;

    print("separated : $separated");
    print("LastPath : ${separated.last}");
  }
}
