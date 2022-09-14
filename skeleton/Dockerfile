# ---- Base image ----
FROM hmctspublic.azurecr.io/base/node:16-alpine as base

USER root
RUN corepack enable
USER hmcts

COPY --chown=hmcts:hmcts . .

# the yarn install is needed for some reason in Docker even with zero-install, it's very quick though
RUN PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=true \
    PUPPETEER_SKIP_DOWNLOAD=true \
    yarn install --immutable-cache && \
    yarn build:prod && \
    rm -rf webpack/ webpack.config.js

EXPOSE ${{ values.http_port }}
