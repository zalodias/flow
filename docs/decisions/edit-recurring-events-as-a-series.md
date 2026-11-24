# Edit recurring events as a series

## Context

Recurring events repeat daily, weekly on chosen weekdays, monthly or yearly, every N periods, with an optional end date. The costly part of recurrence is changing a single occurrence: every override has to be stored and merged back in whenever the timeline renders the series.

## Decision

Edits to a recurring event always apply to the whole series. A single occurrence can only be skipped, which the event stores as a list of skipped dates. Moving or changing one occurrence is left for later.

## Why

Skipping is the simplest exception there is, and it covers cancelling one session. Moving one occurrence is rare at Flow's volume. Until per-occurrence overrides exist, it means skipping the occurrence and adding a one-off event in its place.
