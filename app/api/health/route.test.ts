import { GET } from "./route";

describe("GET /api/health", () => {
  it("returns 200 with status ok and is not cached", async () => {
    const res = GET();
    expect(res.status).toBe(200);
    expect(res.headers.get("cache-control")).toBe("no-store");
    await expect(res.json()).resolves.toEqual({ status: "ok" });
  });
});
