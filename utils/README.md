
## Primer Utilities

These scripts are capable of creating/updating manifests for all primers (`updateManifests.R`) and deploying the primers to an RStudio Connect server (`deployPrimers.R`). The Dockerfile in the root of this repo can be used to reproducibly run these scripts.

### Build the docker image

To build the Docker image, run the following **in the root directory of this repo** (not this directory).

```
docker build -t rstudio-primers .
```

### Create/Update Manifests

If renv dependencies have changed, you'll need to update the manifests associated with the primers so that they'll realize the new package updates next time they're deployed. You can update the manifests using the Docker image by running the following command **from the root directory of this repo** (not this directory):

```
docker run -v `pwd`:/primers rstudio/primers
```

This mounts in the primers at `/primers` and then has the docker container crawl through the known, authoritative primers (enumerated in `listPrimers.R`) to generate their manifests. It takes a few minutes to run.

### Deploy Primers to RStudio Connect

In order to deploy the primers to RStudio Connect, you'll have the docker container run `deployPrimers.R`. **From the root directory of this repo** (not this directory), run:

```
export CONNECT_SERVER="http://whatever.com"
export CONNECT_API_KEY="abc123"
docker run -e CONNECT_SERVER -e CONNECT_API_KEY -v `pwd`:/primers rstudio/primers R -f "utils/deployPrimers.R"
```

This will deploy all of the authoritative primers using the given API key to the provided Connect server. Currently, it will set a vanity URL using the same name as the directory in which the primer is contained, but does not set permissions or configure the runtime of the content.
