![MIDIKit](Images/midikit-banner.png)

# MIDIKit

[![CI Build Status](https://github.com/orchetect/MIDIKit/actions/workflows/build.yml/badge.svg)](https://github.com/orchetect/MIDIKit/actions/workflows/build.yml) [![Platforms - macOS 10.12-13.0 | iOS 10-16](https://img.shields.io/badge/platforms-macOS%2010.12–13.0%20|%20iOS%2010–16-lightgrey.svg?style=flat)](https://developer.apple.com/swift) ![Swift 5.5-5.7](https://img.shields.io/badge/Swift-5.5–5.7-orange.svg?style=flat) [![Xcode 13-14](https://img.shields.io/badge/Xcode-13–14-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/MIDIKit/blob/main/LICENSE)

An elegant and modern CoreMIDI wrapper in pure Swift supporting MIDI 1.0 and MIDI 2.0.

- Modular, user-friendly I/O
- Automatic MIDI endpoint connection management and identity persistence
- Strongly-typed MIDI events that seamlessly interoperate between MIDI 1.0 and MIDI 2.0
- Automatically uses appropriate Core MIDI API and defaults to MIDI 2.0 on platforms that support it
- Supports Swift Playgrounds on iPad and macOS
- Full documentation available in Xcode Documentation browser, including helpful guides and getting started information

## Abstractions

Over and above I/O and events, MIDI extension abstractions can be found in MIDIKit:

- Reading/writing Standard MIDI Files (SMF)
- Control Surface protocols (HUI, etc.)
- Synchronization protocols (MTC, etc.)

## Getting Started

The library is available as a Swift Package Manager (SPM) package.

Use the URL `https://github.com/orchetect/MIDIKit` when adding the library to a project or Swift package.

See the [getting started guide](https://orchetect.github.io/MIDIKit/documentation/midikit/midikit-getting-started) for a detailed walkthrough of how to get the most out of MIDIKit.

## Documentation

See the [online documentation](https://orchetect.github.io/MIDIKit/) or view it in Xcode's documentation browser by selecting the **Product → Build Documentation** menu.

This includes a getting started guide, links to examples, and troubleshooting tips.

## System Compatibility

- Xcode 13.0 / macOS 11.3 are minimum requirements to compile
- Once compiled, MIDIKit supports macOS 10.12+ and iOS 10.0+.

  tvOS and watchOS are not supported (as there is no Core MIDI implementation) but MIDIKit will build successfully on those platforms in the event it is included as a dependency in multi-platform projects.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/MIDIKit/blob/master/LICENSE) for details.

## Sponsoring

If you enjoy using MIDIKit and want to contribute to open-source financially, GitHub sponsorship is much appreciated. Feedback and code contributions are also welcome.

## Contributions

Contributions are welcome. Discussion in Issues is encouraged prior to new features or modifications.
