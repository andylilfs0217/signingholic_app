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
// const ENV = EnvironmentStage.development;
const ENV = EnvironmentStage.staging;
// const ENV = EnvironmentStage.production;

/// Global variables
int bottomNavBarIndex = 0;
bool hideNavBar = false;

/// Global paths
const String LOGO_PATH = 'assets/icons/app_logo.jpg';
