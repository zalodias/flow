# Keep items off the calendar

## Context

Many calendar-and-to-do apps put to-dos on the calendar next to events. In Flow every item has a due, so items could be placed on the calendar.

## Decision

The Calendar tab shows events only. Items appear on Today and on the Tasks tab, never on the Calendar. An item's due is a date with no time. When capture parses a time for an item, the time is dropped.

## Why

An item on the calendar reads as something happening at that time, which is semantically wrong. An item with a real time is an event.
