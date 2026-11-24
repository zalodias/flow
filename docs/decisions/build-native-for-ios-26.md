# Build native for iOS 26

## Context

The design leans on system surfaces: Action Button, widgets, Live Activity, Dynamic Island and Control Center. Cross-platform frameworks can reach these only through hand-written native extensions.

## Decision

Flow is a native SwiftUI app for iPhone, with iOS 26 as the minimum version.

## Why

The system surfaces need Apple's own frameworks either way. It is a personal app on one phone, so supporting older iOS versions or other platforms buys nothing. iOS 26 brings the current SwiftData and the on-device language model for natural-language capture later. The trade-off is that an Android or web version would be a rewrite.
