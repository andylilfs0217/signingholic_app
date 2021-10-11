/// Environments

/// Environment stages
enum EnvironmentStage {
  development,
  staging,
  production,
}

/// Environment paths
const Map<EnvironmentStage, String> ENV_PATHS = {
  EnvironmentStage.development: 'env/development.env',
  EnvironmentStage.staging: 'env/staging.env',
  EnvironmentStage.production: 'env/production.env',
};

/// Current environment
const ENV = EnvironmentStage.development;
// const ENV = EnvironmentStage.staging;
// const ENV = EnvironmentStage.production;

/// Global variables
int bottomNavBarIndex = 0;
bool hideNavBar = false;
int accountId = ENV == EnvironmentStage.staging ? 52 : 2;

/// Global paths
const String LOGO_PATH = 'assets/icons/app_logo.png';

/// App Parameters
const String APP_NAME = 'Circle Studio';
const String APP_TITLE = 'Circle Studio';
// ignore: non_constant_identifier_names
String APP_CODE = ENV == EnvironmentStage.staging ? 'demo' : 'vizualize';
