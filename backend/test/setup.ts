// Global test setup
beforeAll(async () => {
  // Setup code that runs before all tests
  // Example: Initialize test database, start test server, etc.
});

afterAll(async () => {
  // Cleanup code that runs after all tests
  // Example: Close database connections, stop test server, etc.
});

// Global test teardown
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});

