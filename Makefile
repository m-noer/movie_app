.Nero: format
format:
	flutter format lib test

.Nero: test_cov
test_cov:
	flutter test --coverage

.Nero: integrate_test
integrate_test:
	flutter drive --flavor staging --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart

.Nero: feature
feature:
	mason make nero_feature -c assets/json/$(name).json -o lib

.Nero: analyze
analyze:
	flutter analyze lib test

.Nero: runner
runner:
	flutter pub run build_runner build --delete-conflicting-outputs

.Nero: build_runner
build_runner:
	flutter pub run build_runner build

.Nero: icon
icon:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*

.Nero: splash
splash:
	flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml

.Nero: apk_staging
apk_staging:
	flutter build apk --flavor staging -t lib/main_staging.dart

.Nero: apk_production
apk_production:
	flutter build apk --flavor production -t lib/main_production.dart

.Nero: production
production:
	flutter build appbundle --flavor production -t lib/main_production.dart --target-platform android-arm,android-arm64,android-x64 --obfuscate --split-debug-info=build

.Nero: ios_production
ios_production:
	flutter build ipa --flavor production -t lib/main_production.dart