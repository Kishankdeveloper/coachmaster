enum EnvironmentEnum { dev, prod }

class Environment {
  static late Map<String, dynamic> _config;

  static void setEnvironment(EnvironmentEnum env) {
    switch (env) {
      case EnvironmentEnum.dev:
        _config = _Config.devConstants;
        break;
      case EnvironmentEnum.prod:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get baseUrl {
    return _config[_Config.baseUrl];
  }

  static get authBaseUrl {
    return _config[_Config.authBaseUrl];
  }

  static get whereAmI {
    return _config[_Config.whereAmI];
  }
}

class _Config {
  static const baseUrl = "BASE_SERVER_URL";
  static const authBaseUrl = "AUTH_SERVER_URL";

  static const whereAmI = "WHERE_AM_I";

  static Map<String, dynamic> devConstants = {
    baseUrl: 'https://roams.cris.org.in/trg',
    authBaseUrl: 'https://roams.cris.org.in/testuaa',
    whereAmI: "dev",
  };

  static Map<String, dynamic> prodConstants = {
    baseUrl: 'https://roams.cris.org.in/',
    authBaseUrl: 'https://roams.cris.org.in/uaa',
    whereAmI: "prod",
  };
}
