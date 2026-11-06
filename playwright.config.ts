import { defineConfig, devices } from "@playwright/test";

// When BASE_URL is set (the release workflow), test that deployment.
// Otherwise start the app locally on a dedicated port so the tests never
// talk to some other program that happens to be using port 3000.
const port = Number(process.env.TEST_PORT ?? 3100);
const baseURL = process.env.BASE_URL ?? `http://localhost:${port}`;

export default defineConfig({
  testDir: "./tests",
  testIgnore: ["load/**"],
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 1 : 0,
  reporter: process.env.CI ? "github" : "list",
  use: { baseURL, trace: "on-first-retry" },
  projects: [{ name: "chromium", use: { ...devices["Desktop Chrome"] } }],
  webServer: process.env.BASE_URL
    ? undefined
    : {
        command: `npx next dev --port ${port}`,
        url: `http://localhost:${port}/api/health`,
        reuseExistingServer: !process.env.CI,
        timeout: 120_000,
      },
});
