# ---- Base image ----
FROM hmctspublic.azurecr.io/base/node:16-alpine as base
USER root
RUN corepack enable
USER hmcts
COPY --chown=hmcts:hmcts . .
RUN yarn install \
  && yarn cache clean

# ---- Build image ----
FROM base as build

USER root
# Remove when switched to dart-sass
RUN apk add --update --no-cache python3
USER hmcts

RUN PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true yarn install && yarn build:prod

# ---- Runtime image ----
FROM base as runtime
RUN rm -rf webpack/ webpack.config.js
COPY --from=build $WORKDIR/src/main ./src/main
EXPOSE ${{ values.http_port }}
