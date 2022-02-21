/// log的统一调用；后续可以再改善
mixin Log {
  static bool _debug = true;

  /// 默认true，打印log，可以在适当的时候进行设置false 不打印
  static void setDebug({bool debug = true}) {
    _debug = debug;
  }

  static const String _baseType = 'demo';

  static void v(dynamic msg) {
    if (!_debug) {
      return;
    }
    print('${_baseType}_v_$msg');
  }

  static void d(dynamic msg) {
    if (!_debug) {
      return;
    }
    print('${_baseType}_d_$msg');
  }

  static void i(dynamic msg) {
    if (!_debug) {
      return;
    }
    print('${_baseType}_i_$msg');
  }

  static void w(dynamic msg) {
    if (!_debug) {
      return;
    }
    print('${_baseType}_w_$msg');
  }

  static void e(dynamic msg) {
    if (!_debug) {
      return;
    }
    print('${_baseType}_e_$msg');
  }
}
