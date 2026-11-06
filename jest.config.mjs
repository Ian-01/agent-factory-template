import nextJest from "next/jest.js";

const createJestConfig = nextJest({ dir: "./" });

export default createJestConfig({
  testEnvironment: "node",
  testPathIgnorePatterns: ["/node_modules/", "/.next/", "/tests/"],
  collectCoverageFrom: [
    "app/api/**/*.ts",
    "lib/**/*.ts",
    "!**/*.test.ts",
    "!**/*.d.ts",
  ],
  coverageThreshold: { global: { lines: 80 } },
});
