Contributing

Thank you for your interest in improving the Project JSON Schema!

Guidelines
- Keep the schema stable: add non-breaking fields when possible.
- Add realistic examples under `examples/` to help others and LLMs understand
  usage patterns.
- Update `schema/project.schema.json` and bump `schemaVersion` when making
  breaking changes.

How to validate locally
1. Install dependencies: `npm install`
2. Run validation:
   - All files: `npm run validate`
   - Templates only: `npm run validate:template`
   - Examples only: `npm run validate:examples`
   - With linting: `npm test`

Alternative (manual validation)
1. Install Node.js and global tools: `npm install -g ajv-cli ajv-formats jsonlint`
2. Run validation:
   `ajv validate -s schema/project.schema.json -d templates/project.template.json examples/*.json --formats`

Pull requests
- Open a PR to add an example or fix schema issues.
- Provide a short description and rationale for changes.
- The CI workflow will validate JSON files automatically.
