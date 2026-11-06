import http from 'k6/http';
import { check } from 'k6';
export const options = {
  scenarios: { users10k: { executor: 'constant-arrival-rate', rate: 1500, timeUnit: '1s', duration: '10m', preAllocatedVUs: 1000, maxVUs: 3000 } },
  thresholds: { http_req_failed: ['rate<0.01'], http_req_duration: ['p(95)<800'] },
};
const routes = ['/', '/api/health'];   // the agent adds the real user journeys from the spec
export default function () {
  const res = http.get(`${__ENV.BASE_URL}${routes[Math.floor(Math.random() * routes.length)]}`);
  check(res, { 'status 200': (r) => r.status === 200 });
}
