# RemoteBLE: a simple GoPro remote app for iPhone

A native iOS app that controls a GoPro camera over Bluetooth Low Energy. You can start and stop recording, switch modes, change video settings and monitor battery and storage without touching the camera.

![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0071E3?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?logo=apple&logoColor=white)
![Bluetooth](https://img.shields.io/badge/Bluetooth%20LE-0082FC?logo=bluetooth&logoColor=white)

## Overview

RemoteBLE is written in Swift with SwiftUI and CoreBluetooth. It scans for nearby BLE devices and connects to the selected GoPro. It then discovers the camera's GoPro BLE services and talks to the camera by writing raw command, setting and query byte packets to its characteristics and parsing the notification responses. It was developed and tested with a GoPro HERO9.

## Features

- **Device scanning.** Lists nearby named Bluetooth devices, with *Clear and Rescan*.
- **Connection handling.** Retries automatically after a timeout (for cameras that are slow to wake up), offers tap-to-reconnect after a disconnect, and warns you if the connected device is not a GoPro.
- **Recording.** Start/stop shutter with an animated recording indicator.
- **Modes.** Switch between Video, Photo and Timelapse.
- **Live status.** Battery level, recording time left, number of videos, and the camera's current mode and busy state.
- **Date and time sync.** The camera's clock is set to the phone's time on connect.
- **Put to sleep.** Turns the camera off remotely.
- **Video settings.** Resolution (1080p / 2.7K / 4K / 5K), FPS, lens, HyperSmooth, shutter speed, EV, white balance, ISO min/max, sharpness, color, wind reduction and GPS. Settings are read from the camera when connecting and stay in sync.
- **Localization.** English and Vietnamese.
- **Other.** The screen stays awake while the remote is open, and a disclaimer screen is shown on first launch.

## Tech stack

- Swift 5, SwiftUI (MVVM with `ObservableObject` models)
- CoreBluetooth (`CBCentralManager`, `CBPeripheralDelegate`)
- Xcode project and workspace (CocoaPods `Podfile`, no third-party pods)
- `Localizable.strings` (en, vi)

## Project structure

```
GoProBLE/
├── GoProBLEApp.swift          # App entry point
├── Authentication/            # First-launch disclaimer / intro screen
├── BLE/                       # BLEConnection (central manager: scan, connect, retry) + scanning view
├── Peripheral/                # PeripheralModel (CBPeripheralDelegate), remote control view,
│   └── Settings/              #   settings view model and one type per camera setting (SettingParams/)
├── GoPro/                     # Service and characteristic UUIDs, command bytes, status and setting parsers
├── CustomDesigns/             # Shutter and busy button styles
├── Utils/                     # Bi-directional dictionary, Data helpers
├── en.lproj / vi.lproj        # Localized strings
└── Assets.xcassets
GoProBLETests/, GoProBLEUITests/
```

Each camera setting type (for example `Resolution`) has a BLE setting ID and a two-way map between display values and byte codes. That one mapping both builds the command packet and parses the camera's response. Setting types are injected into a single generic `ParseSetting` function.

## Getting started

### Requirements

- macOS with Xcode (SwiftUI, iOS 14+/15 SDK)
- A physical iPhone. Bluetooth does not work in the iOS Simulator.
- A GoPro camera with Bluetooth enabled and paired/awake

### Build and run

```bash
git clone https://github.com/khangzxrr/RemoteBLE.git
cd RemoteBLE
pod install            # optional: the Podfile currently declares no pods
open RemoteBLE.xcworkspace
```

In Xcode, select the `RemoteBLE` scheme, set your own signing team and bundle identifier, then run the app on your iPhone. Allow Bluetooth access when prompted.

## Disclaimer

This product and/or service is not affiliated with, endorsed by or in any way associated with GoPro Inc. or its products and services. GoPro, HERO and their respective logos are trademarks or registered trademarks of GoPro, Inc.
