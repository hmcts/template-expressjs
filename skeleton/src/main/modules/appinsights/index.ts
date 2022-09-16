import config from 'config';

const appInsights = require('applicationinsights');

export class AppInsights {
  enable(): void {
    if (config.get('appInsights.instrumentationKey')) {
      appInsights.setup(config.get('appInsights.instrumentationKey')).setSendLiveMetrics(true).start();
      const tag = appInsights.defaultClient.context.keys.cloudRole;
      appInsights.defaultClient.context.tags[tag] = '${{ values.app_full_name }}';
      appInsights.defaultClient.trackTrace({ message: 'App insights activated' });
    }
  }
}
