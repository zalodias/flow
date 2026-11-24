# Make Flow the source of truth

## Context

Flow covers both events and items. Syncing with external calendars, such as Google or Apple Calendar, would mean two places where an event can live, plus legends that tell imported events apart from native ones.

## Decision

Flow is the only home for present and future events and items. There is no ongoing sync with external calendars. Past events are brought in once, through a manual import.

## Why

One source of truth keeps the app simple and the UI free of "imported vs. native" distinctions. The app is not built around online meetings, so the usual reason to sync a work calendar does not apply.
