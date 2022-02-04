import { fail } from 'assert';
import axios, { AxiosResponse } from 'axios';

const testUrl = process.env.TEST_URL || 'http://localhost:8080'

describe('Smoke Test', () => {
  describe('Home page loads', () => {
    test('with correct content', async () => { // eslint-disable-line @typescript-eslint/no-empty-function
        try {
          const response: AxiosResponse = await axios.get(testUrl, {
            headers: {
              'Accept-Encoding': 'gzip',
            },
          });
          if (!response.data.includes('<h1 class="govuk-heading-xl">Default page template</h1>')) {
            console.log(response.data)
            throw new Error('Heading not present and/or correct')
          }
        } catch (e) {
          fail(e);
        }
      });
    });
  });