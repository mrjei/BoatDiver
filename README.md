# BoatDiver — Login Workflow (minimal)

This repository contains a minimal Flutter app that implements the login workflow (splash → welcome → login → new-account decision → role selection → forms → review → success).

Important notes
- Authentication is simulated. Google/Apple buttons and the login dialog do not call real backends.
- The UI is intentionally minimal and meant to be wired to your real auth/backend later.

Run locally (PowerShell on Windows)

1. Ensure Flutter is installed and on your PATH. Verify with:

```powershell
flutter --version
```

2. Add platform projects (if you want web/windows support) and fetch packages:

```powershell
cd "C:\Users\jblan\OneDrive\Desktop\BoatDiver Frontend"
flutter create .
flutter pub get
```

3. Analyze and run (example: Chrome or Windows):

```powershell
flutter analyze
flutter run -d chrome   # run on web (Chrome)
flutter run -d windows  # run a Windows desktop build
```

If you see a message saying devices are found but not supported by the project, `flutter create .` will generate the platform directories.

If any command prints errors, copy the terminal output here and I'll help fix them.

What I changed locally in this workspace
- `lib/main.dart` — full Flutter app implementing the login workflow
- `pubspec.yaml` — minimal manifest
- `README.md` — this file with run instructions

Next steps I can take for you
- Wire forms to a backend stub or local persistence
- Add simple unit/widget tests for the flow
- Add platform-specific adjustments or assets

Tell me which next step you prefer, or paste any `flutter` command output and I'll iterate on fixes.
