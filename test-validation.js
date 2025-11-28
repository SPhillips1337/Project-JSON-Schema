#!/usr/bin/env node

/**
 * Quick test to verify validation setup works
 */

const { execSync } = require('child_process');

console.log('Testing validation setup...\n');

try {
  // Test template validation
  console.log('Testing template validation...');
  execSync('node validate.js templates/project.template.json', { stdio: 'inherit' });
  
  // Test examples validation
  console.log('\nTesting examples validation...');
  execSync('node validate.js examples/comfy-image.project.json examples/phpaichatbot.project.json', { stdio: 'inherit' });
  
  console.log('\n✅ All validation tests passed!');
} catch (error) {
  console.error('\n❌ Validation test failed:', error.message);
  process.exit(1);
}