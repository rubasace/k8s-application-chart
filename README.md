# Kubernetes Application Chart
[![Build Status](https://cloud.drone.io/api/badges/rubasace/k8s-application-chart/status.svg)](https://cloud.drone.io/rubasace/k8s-application-chart)
[![GitHub release](https://img.shields.io/github/release/rubasace/k8s-application-chart.svg)](https://GitHub.com/rubasace/k8s-application-chart/releases/)
[![GitHub license](https://img.shields.io/github/license/rubasace/k8s-application-chart.svg)](https://github.com/rubasace/k8s-application-chart/blob/master/LICENSE)

> **_DISCLAIMER:_**  this repository is just a proof of concept that isn't meant to be used by any means at a company. Use it at your own risk.
 
## Description 
Generic Helm Chart for deploying applications to Kubernetes.

Inspired by [TicketMaster's talk at KubeCon (2017)](https://www.youtube.com/watch?v=HzJ9ycX1h0c), this Chart pretends to be the one used on the deployment process of our
 applications. This way a team/company can centralize all good-practices and standardize their deployment process in a friction-less manner.
 
## How to use
This Chart was created to be used from a CI/CD pipeline, but nothing stops you to use it directly from the command line.

### Command Line

```bash
helm repo add k8s-apps https://rubasace.github.io/k8s-application-chart 
helm install my-app -n my-namespace -f values.yaml k8s-apps/kubernetes-application
```    
 
### CI/CD Pipeline

It's really as simple as the Command Line version, with the only difference that it's a good practice to ping the pipeline to a specific version of the Chart, to ensure that it
's reproducible and avoid surprises.

There's also an extension for [Drone](https://drone.io) that can be found [here](https://github.com/rubasace/drone-helm-k8s) (can easily be applied to any Docker based CI/CD tool).

## Notes
While this Chart works out-of-the-box, it's too generic for being used as it is. Things like the domain are left in the air, so it's a good practice to just extend/fork it in
order to adapt it to your specific scenario, instead of having to provide the same values over and over again.
 
