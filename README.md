# Prometheus Example App

This example app serves as an example of how one can easily instrument HTTP handlers with [Prometheus](https://prometheus.io/) metrics.

Usage is simple, on any request to `/sayhello/{name}` the request will result in a `200` response code. This increments the counter for this response code. A request to any other endpoint will result in a `404` response code, therefore increments that respective counter. A POST request will result in a 500 error code.

In the endpoint `/metrics` the app will expose different prometheus metrics, being `greeting_seconds_*` the metrics generated to expose HTTP requests information.

PromQL requests for the golden signals:
  - Requests per second
sum(rate(greeting_seconds_count{}[2m]))  //Including errors
rate(greeting_seconds_count{code="200"}[2m])  //Only 200 OK requests
  - Average request time
sum(greeting_seconds_sum)/sum(greeting_seconds_count)
  - Errors per second
sum(rate(greeting_seconds_count{code!="200"}[2m]))
  - Saturation to be generated upon system metrics (cpu,)
A Docker image is available at: `sysdiglabs/prom-example:latest`
