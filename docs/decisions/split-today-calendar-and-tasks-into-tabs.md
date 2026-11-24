# Split Today, Calendar and Tasks into tabs

## Context

The explorations went two ways: a Calendar and Tasks split, and Chronicle's single timeline with everything in it. An earlier comment worried that Today would make a weak default, since a single day holds little.

## Decision

The app has three tabs:
- Today is the default tab and shows every event and item for the current day.
- Calendar shows events, day by day, past and future.
- Tasks shows items, day by day, past and future.

## Why

Today mixes events and items for the day you're living, the way Chronicle does. Calendar and Tasks each give one kind of thing a dedicated view across every day, past and future. Looking back is scrolling back in those tabs, so there is no separate Past tab.
