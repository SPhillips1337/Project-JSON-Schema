Contributing

Thank you for your interest in improving the Project JSON Schema!

Guidelines
- Keep the schema stable: add non-breaking fields when possible.
- Add realistic examples under `examples/` to help others and LLMs understand
  usage patterns.
- Update `schema/project.schema.json` and bump `schemaVersion` when making
  breaking changes.

How to validate locally
1. Install Node.js and `ajv-cli`: `npm install -g ajv-cli`
2. Run validation:
   `ajv validate -s schema/project.schema.json -d templates/project.template.json examples/*.json`

Pull requests
- Open a PR to add an example or fix schema issues.
- Provide a short description and rationale for changes.
- The CI workflow will validate JSON files automatically.
