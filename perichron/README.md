# Perichron

A simple storage interface layer that Astra uses as an intermediary to read 
and write storage values. 

Eventually our goal is to build this into a custom back-end
package for all of our resources that allows them to share data and talk to each other across a network of user's devices. 

### Installation

To add in the command line, use: 
```
flutter pub add perichron
```

### Sample
Below, you can see how we integrate Perichron into Aureus' (another package of ours) Safety Plan functionality. 

```
/*--------- SAFETY PLAN ----------*/
///
///
/// To reduce risk of abuse, all Safety Plan settings are handled directly by Aureus,
/// and not passed to the developer.
///
/// Aureus sets a safety plan through the 3 associated screens:
/// - SafetyPlanOptInView
/// - SafetyPlanConfirmationView
/// - SafetyPlanFunctionalityView
///
/// After that, you interact with the Safety Plan by using the actionSafetyCheck function in SafetyPlan.

class _SafetyPlanStorageLayer {
  /// initializes Perichron's storage layer. 
  final _storage = PerichronStorageLayer();

  /// Switches the option into the relevant key for writing / retrival
  String safetyPlanKey(SafetyPlanOptions option) {
    switch (option) {
      case SafetyPlanOptions.onlyNeccessaryEmails:
        return 'onlyNeccessaryEmails';

      case SafetyPlanOptions.disableNotifications:
        return 'disableNotifications';

      case SafetyPlanOptions.disableBiometrics:
        return 'disableBiometrics';

      case SafetyPlanOptions.enable2FA:
        return 'enable2FA';

      case SafetyPlanOptions.localDataStorage:
        return 'localDataStorage';

      case SafetyPlanOptions.failedPasscodeDataDeletion:
        return 'failedPasscodeDataDeletion';

      case SafetyPlanOptions.exitBar:
        return 'exitBar';

      case SafetyPlanOptions.disableScreenshots:
        return 'disableScreenshots';

      case SafetyPlanOptions.logFailedAttempts:
        return 'logFailedAttempts';
    }
  }

  // READ / WRITE SETTINGS

  /// Reads a setting
  Future<bool> _readSetting(SafetyPlanOptions option) async {
    // Reads item from Perichron
    final settings = _storage.readItem(safetyPlanKey(option));
    return settings.toString() == "true" ? true : false;
  }

  /// Writes a setting
  Future<void> _writeSetting(SafetyPlanOptions option, bool isEnabled) async {
    // Adds item to Perichron
    await _storage.addItem(safetyPlanKey(option), isEnabled.toString());
  }
}
```
