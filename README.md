# iOS Toddler Lockdown

A parental control app for iOS that locks down an iPhone for safe toddler use.

## Features

- **Locked View** - Colorful, engaging interface with large shapes for toddlers to tap
- **Admin Panel** - Password-protected settings for parents
- **Lockdown Mode** - Locks device for a specified duration
- **Haptic Feedback** - Tactile response to touches
- **Secure Password Storage** - Uses Keychain for password security
- **Configurable Duration** - Adjustable lockdown time limits (5 minutes to 8 hours)
- **Auto-Unlock** - Automatically unlocks after duration expires

## Getting Started

### Requirements
- Xcode 14.0+
- iOS 15.0+
- Swift 5.7+

### Installation

1. Clone the repository
```bash
git clone https://github.com/babyalexandrahawryluk-afk/ios-toddler-lockdown.git
```

2. Open in Xcode
```bash
cd ios-toddler-lockdown
open ios-toddler-lockdown.xcodeproj
```

3. Build and run on an iOS device or simulator

## Usage

1. **Activate Lockdown**: Tap "Activate Lockdown" to enter toddler mode
2. **Admin Panel**: Tap the gear icon to access parent controls (default password: 1234)
3. **Configure Settings**: 
   - Change admin password
   - Adjust lockdown duration
4. **Unlock**: Enter admin password to deactivate lockdown

## Default Settings

- **Admin Password**: 1234
- **Lockdown Duration**: 1 hour
- **Auto-unlock**: After duration expires

## Security

⚠️ **Important**: This is a demonstration app. For production use:
- Change the default password immediately
- Implement additional security measures
- Test thoroughly before production deployment
- Consider MDM (Mobile Device Management) solutions for enterprise use

## License

MIT License - See LICENSE file for details
