import { expect, test } from "@playwright/test";

test("US-000: health endpoint says hello", async ({ page }) => {
  const res = await page.goto("/api/health");
  expect(res?.status()).toBe(200);
  await page.screenshot({
    path: "docs/evidence/US-000/health-endpoint.png",
    fullPage: true,
  });

  await page.goto("/");
  await page.screenshot({
    path: "docs/evidence/US-000/home-page.png",
    fullPage: true,
  });
});
