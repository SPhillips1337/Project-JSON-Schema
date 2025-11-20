Project JSON Schema

This repository contains a small, practical JSON Schema and supporting files for
standardizing machine-friendly project manifests ("project.json") that can be
used to hand off work to language models and developers.

Why
- Having a single schema and canonical template makes it easy for LLMs to pick up
  and continue work across projects.
- The manifest is intentionally human-readable and machine-actionable: it lists
  goals, features, TODOs, files of interest, and security notes.

Contents
- `schema/project.schema.json` — JSON Schema (v1) describing the manifest format.
- `templates/project.template.json` — starter template for new projects.
- `examples/` — example project manifests (including `comfy-image.project.json`).
- `.github/workflows/validate.yml` — CI workflow to validate JSON files against
  the schema.
- `CONTRIBUTING.md` — how to contribute examples or changes.

Quick validation
- Install `ajv-cli` (Node): `npm install -g ajv-cli`
- Validate examples and templates:
  `ajv validate -s schema/project.schema.json -d templates/project.template.json examples/*.json`

Usage for LLMs
- Read `schema/project.schema.json` to understand field requirements.
- Load an example from `examples/` to see real-world usage.
- Use `todo` items as actionable steps and update the manifest as work progresses.

Publishing
- When breaking schema changes are needed, bump `schemaVersion` and add
  migration notes.

License
- MIT (see `LICENSE`).
