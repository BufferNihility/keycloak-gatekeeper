FROM alpine:3.8

ENV NAME keycloak-gatekeeper
ENV KEYCLOAK_VERSION 8.0.0
ENV GOOS linux
ENV GOARCH amd64

LABEL Name=keycloak-gatekeeper \
      Release=https://github.com/keycloak/keycloak-gatekeeper \
      Url=https://github.com/keycloak/keycloak-gatekeeper \
      Help=https://issues.jboss.org/projects/KEYCLOAK

RUN adduser -D -u 1000 gatekeeper

RUN apk add --no-cache ca-certificates curl tar

WORKDIR "/opt"
COPY release/keycloak-gatekeeper-linux-amd64.tar.gz ./
RUN tar -zxf keycloak-gatekeeper-linux-amd64.tar.gz && chmod +x /opt/$NAME
RUN apk del curl tar
COPY templates ./templates

USER 1000

ENTRYPOINT [ "/opt/keycloak-gatekeeper" ]

