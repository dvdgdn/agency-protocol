/**
 * Development server entry point
 */

// Must be imported first
import 'reflect-metadata';

// Import the main bootstrap function
import('./main').then(module => {
  // The main.ts file exports the bootstrap function
  // We're dynamically importing to ensure reflect-metadata is loaded first
}).catch(err => {
  console.error('Failed to start server:', err);
});