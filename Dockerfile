# set up root certificates in a full debian environment before copying them over
FROM gcr.io/cloud-marketplace-containers/google/debian10:latest@sha256:88e503b14c0bfe20a3f99a630dfbfda1d5198138cdd0c32f3138a08245d9dfeb AS build-env

# Add CA files
COPY ./certs/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Build the actual base image
FROM gcr.io/distroless/base-debian10:latest@sha256:aff0b0d6766cce25bd47bacb3ed67ae866952585c0735ff3bdb70fdfeac8992a

# Install ANZ certificates
COPY --from=build-env /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# set nonroot user (65532:65532)
USER 65532
