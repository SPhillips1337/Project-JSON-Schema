#!/usr/bin/env node

/**
 * Custom validation script for Project JSON Schema
 * Properly integrates ajv with ajv-formats for URI and date-time validation
 */

const Ajv = require('ajv');
const addFormats = require('ajv-formats');
const fs = require('fs');
const path = require('path');

// Initialize AJV with formats
const ajv = new Ajv({ allErrors: true, verbose: true });
addFormats(ajv);

// Load schema
const schemaPath = path.join(__dirname, 'schema/project.schema.json');
const schema = JSON.parse(fs.readFileSync(schemaPath, 'utf8'));
const validate = ajv.compile(schema);

// Get files to validate from command line arguments
const filesToValidate = process.argv.slice(2);

if (filesToValidate.length === 0) {
  console.error('Usage: node validate.js <file1.json> [file2.json] ...');
  process.exit(1);
}

let hasErrors = false;

// Validate each file
filesToValidate.forEach(filePath => {
  try {
    console.log(`Validating ${filePath}...`);
    
    if (!fs.existsSync(filePath)) {
      console.error(`❌ File not found: ${filePath}`);
      hasErrors = true;
      return;
    }
    
    const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    const isValid = validate(data);
    
    if (isValid) {
      console.log(`✅ ${filePath} is valid`);
    } else {
      console.error(`❌ ${filePath} is invalid:`);
      validate.errors.forEach(error => {
        console.error(`  - ${error.instancePath || 'root'}: ${error.message}`);
      });
      hasErrors = true;
    }
  } catch (error) {
    console.error(`❌ Error validating ${filePath}: ${error.message}`);
    hasErrors = true;
  }
});

if (hasErrors) {
  console.error('\n❌ Validation failed');
  process.exit(1);
} else {
  console.log('\n✅ All files are valid');
}