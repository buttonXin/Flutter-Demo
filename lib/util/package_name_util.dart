/// 对比的类型
enum CompareType {
  // 正常，包名与手机品牌对应
  normal,
  // 不正常，需要卸载apk，不能往下走流程。
  uninstall,
  // 其他，可以下载nebula，但是不下载service。
  other
}

/// 获取包名以及类型的结果
class PkgNameTypeResult {
  CompareType compareType;
  String servicePkg;
  String nebulaPkg;
}

class PackageNameUtil {
  /// 通过model与pkgName的结果来显示不同的内容
  PkgNameTypeResult getPkgNameTypeResult({String model, String nebulaPkgName}) {
    final Map<String, Map<String, String>> allMap = {};

    const String _nebula = 'ai.nreal.nebula';
    // 通用的nebula
    const String _nebulaUniversal = 'ai.nreal.nebula.universal';
    // KDDI 三星
    allMap['SCG06'] = {'$_nebula.jp.ss': '$_nebula.service.jp.ss'};
    // KDDI sony
    allMap['SOG02'] = {'$_nebula.jp.xperia': '$_nebula.service.jp.xperia'};
    // DT  一加
    allMap['HD1900'] = {_nebulaUniversal: '$_nebula.service.oneplus'};
    allMap['IN2010'] = {_nebulaUniversal: '$_nebula.service.oneplus'};
    allMap['IN2020'] = {_nebulaUniversal: '$_nebula.service.oneplus'};

    // 默认的正常情况
    final PkgNameTypeResult pkgNameTypeResult = PkgNameTypeResult()
      ..compareType = CompareType.normal
      ..nebulaPkg = nebulaPkgName;

    // model是否在集合中
    if (allMap.keys.contains(model)) {
      // 获取当前model对应的nebula和service的包名。
      final Map<String, String> eachModelMap = allMap[model];
      // 如果key中存在当前的包名，则表示一一对应。
      if (eachModelMap.keys.contains(nebulaPkgName)) {
        pkgNameTypeResult.servicePkg = eachModelMap[nebulaPkgName];
      } else {
        // 不在集合中， 表示安装的包名不对，需要卸载。
        pkgNameTypeResult.compareType = CompareType.uninstall;
      }
    } else {
      // model 不在集合中，表示可以使用nebula，但是不进行下载service
      pkgNameTypeResult.compareType = CompareType.other;
    }

    return pkgNameTypeResult;
  }
}
