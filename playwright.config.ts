import { defineConfig } from "@playwright/test";

const base = process.env.BASE_URL;
export default defineConfig({
  testDir: "tests",
  use: {
    baseURL: base ?? "http://localhost:3000",
    screenshot: "only-on-failure",
  },
  webServer: base
    ? undefined
    : {
        command: "npm run dev",
        url: "http://localhost:3000",
        reuseExistingServer: true,
        timeout: 120000,
      },
  reporter: [["list"], ["html", { open: "never" }]],
});
