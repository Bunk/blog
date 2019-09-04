+++
categories = []
date = "2019-09-03T05:00:00+00:00"
draft = true
slug = "multi-file-docker-builds"
tags = ["docker"]
title = "Multi-file Docker builds for fun & profit"

+++
When working with Docker it's a best practice to strip images that you build down into their smallest possible size.  The smaller a Docker image is, the less bytes need to get sent back and forth over the network (and into the Docker host when working locally), the less disk space is required to store and build the image, the lower the disk seek time needs to be, and the less headaches you'll have when working with 500MB+ "microservices".

Fortunately, Docker supports what they call "multi-stage builds" — which are _awesome!_  They effectively give you a pipeline of Docker images that can pipe their resulting resources downwards into a final resulting image that contains only those resources necessary for running your app.

Unfortunately, this pipeline only has a single output.  **There's no way to output _both_ the "development" image with all of the development dependencies installed, and the "production" image with those dependencies removed**.  Why might you want both, you ask?  Personally, I find it useful to run my development environment within the same container environment that eventually gets deployed into production for maximum integrity.  This provides for a fast feedback cycle during development, but provides a super fat image for production use — _bad developer!_

To combat this issue, I've started using a combination of "multi-stage builds" for generating small images, multiple docker files for representing different discrete steps in the build process, and a `Makefile` that defines the required pipeline.  Typically I will have _at least_ two `Dockerfiles` in the pipeline:  one for a "dev" image which includes dependencies, and a second "prod" image which removes those developer dependencies in one stage before copying only the necessary resources in another.

Here's an example of what I mean:

{{< gist Bunk 2294d394e552c3c0024d167a4f2967d9 "Dockerfile-deps.dockerfile" >}}