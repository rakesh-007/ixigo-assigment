* Created a deployment file with 4 replica having version v1
* Created a deploymene file with 1 replica having updated version v2
* in the service we have defined selector which will map with both the deployment
* since ratio of pods in 4:1 the request will be served in this way only.
