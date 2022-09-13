# ---- Base image ----
FROM hmctspublic.azurecr.io/base/node:16-alpine as base

USER root
RUN corepack enable
USER hmcts

COPY --chown=hmcts:hmcts . .

RUN yarn build:prod && \
  rm -rf webpack/ webpack.config.js

EXPOSE ${{ values.http_port }}
