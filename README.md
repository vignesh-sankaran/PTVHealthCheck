# PTVHealthCheck

![Screen recording](screencapture.gif "Screen recording")

## Overview

An app that hits the health check endpoint of Public Transport Victoria's V2 API, and displays the results on the screen.

## Architecture

The MVVM architecture pattern is followed for this app, where the request is made through `HealthCheckService`, and
the request is managed through the `ViewModel`. Upon request completion, the `ViewModel` sends a Notification to
the `ViewController`, which displays the results of the health check request.

## Testing

Basic unit tests are set up for business logic functions contained within `HealthCheckService`
