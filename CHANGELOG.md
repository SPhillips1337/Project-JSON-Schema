# Changelog

All notable changes to this project are documented in this file.

## Unreleased

- docs: Add CHANGELOG.md (this file)

## 1.0.1 - 2025-11-20

- feat(schema): add operational fields
  - Added optional properties to `schema/project.schema.json` to improve machine-readability and operational handoffs:
    - `repository` (URI)
    - `api_endpoints` (array of `{endpoint, method, description}`)
    - `external_services` (map of service name → connection string)
    - `required_env` (array of required environment variable names)
    - `current_capabilities` (array of strings)
    - `next_steps` (array of strings)
    - `architecture` (overview + components)
    - `development_plan` (currentPhase + phases)
    - `infrastructure` (deployment notes/files)
  - These fields are optional and non-breaking.

- chore(schema): add `lastUpdated` optional field (ISO 8601 string) to allow tools to detect when a manifest was last changed.

- chore: bump example and template `schemaVersion` to `1.0.1` and update `templates/project.template.json` and the examples under `examples/` to include placeholders or extracted values.

Commits:
- d61c317 — chore(schema): bump schemaVersion to 1.0.1 — add optional lastUpdated and update template/examples
- a7fbbc9 — feat(schema): add operational fields (repository, api_endpoints, external_services, required_env, capabilities, next_steps, architecture, development_plan, infrastructure)

Notes:
- Local validation with Ajv succeeded for the template and examples. Ajv emitted warnings about `format: "uri"` and `format: "date-time"` being ignored because `ajv-formats` is not enabled; consider adding `ajv-formats` to CI if you want strict format validation in the workflow.

---

(End of changelog)
