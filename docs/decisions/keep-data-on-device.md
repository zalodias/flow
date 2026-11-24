# Keep data on device

## Context

Flow is the source of truth for events and items, so losing the data matters. iCloud sync through CloudKit would protect it, but it imposes rules on the data model and adds sync behavior to design for.

## Decision

Data is stored with plain SwiftData on the phone. There is no iCloud or CloudKit sync for now, and the models are not shaped for CloudKit in advance.

## Why

There is only one device, so sync has nothing to do yet. Preparing the models for a sync that may never come is speculative work. The phone's own iCloud backup covers the local store in the meantime. Adding sync later will need a data migration.
