import http from 'k6/http';
import { check } from 'k6';
export const options = {
  scenarios: { smoke: { executor: 'constant-arrival-rate', rate: 200, timeUnit: '1s', duration: '2m', preAllocatedVUs: 100, maxVUs: 400 } },
  thresholds: { http_req_failed: ['rate<0.01'], http_req_duration: ['p(95)<500'] },
};
const routes = ['/', '/api/health'];   // the agent adds the main pages and endpoints from the spec
export default function () {
  const res = http.get(`${__ENV.BASE_URL}${routes[Math.floor(Math.random() * routes.length)]}`);
  check(res, { 'status 200': (r) => r.status === 200 });
}
