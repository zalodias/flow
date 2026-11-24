# Infer habits from recurring events

## Context

Several explorations treated habits as a separate entity, with their own list and check-ins.

## Decision

There is no habit entity. A habit is a recurring event seen over time, and its streak comes from that event's history.

## Why

A habit is already something that happens on a schedule, which is what a recurring event is. A separate entity would duplicate the calendar and add a third kind of thing to capture.
