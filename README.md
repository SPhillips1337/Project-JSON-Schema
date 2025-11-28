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
- `schema/project.schema.json` — JSON Schema (draft-07) describing the manifest format.
- `templates/project.template.json` — starter template for new projects.
- `examples/` — example project manifests (including `comfy-image.project.json`).
- `.github/workflows/validate.yml` — CI workflow to validate JSON files against the schema.
- `package.json` — Node.js dependencies and validation scripts.
- `CONTRIBUTING.md` — how to contribute examples or changes.

Quick validation
- Install dependencies: `npm install`
- Validate all files: `npm run validate`
- Validate only templates: `npm run validate:template`
- Validate only examples: `npm run validate:examples`
- Run all tests: `npm test`

Manual validation (alternative)
- Install `ajv-cli` globally: `npm install -g ajv-cli ajv-formats`
- Validate examples and templates:
  `ajv validate -s schema/project.schema.json -d templates/project.template.json examples/*.json --formats`

New schema fields (added in Unreleased)
- This repository added a set of optional, non-breaking fields to better capture
  generation metadata, progress, and operational details. Key additions and
  expected formats:
  - `status` (string): human-friendly status keyword (e.g. `planning`, `in_progress`, `demo_ready`, `completed`).
  - `concept` (string): a short one-line concept statement.
  - `current_goals` (array[string]): prioritized goals for the current work cycle.
  - `key_files` (object<string,string>): map of important file paths to short descriptions.
  - `rarity_system` (object): named rarity groups (object) where each group is an object with:
    - `chance` (number, 0–100): percentage chance for the rarity group.
    - `colors` (string | array[string]): hex color string (e.g. `"#ffd700"`) or list of colors.
    - `traits` (string | array[string]): single trait or list of trait strings.
  - `generation_modes` (object): named generation modes where each entry is an object with:
    - `command` (string)
    - `url` (string, `uri` format) — optional endpoint URL for remote generation
    - `description` (string)
    - `features` (array[string])
    - `time` (string | number) — numeric seconds preferred, but descriptive strings allowed (e.g. `"~2s"`)
  - `features` (object): grouped arrays `completed`, `demo_ready`, `future_enhancements`.
  - `demo_stats` (object): operational demo metrics:
    - `total_generated` (integer)
    - `generation_success_rate` (number | string) — numeric percentage preferred (e.g. `98.7`), strings like `"98.7%"` are allowed for legacy reasons.
    - `average_generation_time` (number | string) — seconds preferred.
    - `rarity_breakdown` (object<string,string>)
  - `progress_percent` (number, 0–100): overall progress estimate.
  - `progress_state` (string): human-friendly progress state.
  - `next_version_goals` (string | array[string])

Notes on formats and compatibility
- Where both `string` and `number` are allowed, numeric values are preferred
  for machine consumption (calculations, aggregations). Strings are allowed for
  backward compatibility or human-friendly display values.
- Fields are optional and non-breaking — existing manifests remain valid.
- `url` uses the JSON Schema `uri` format; CI using `ajv` may need `ajv-formats`
  to validate these formats strictly.
- `lastUpdated`, where present, should be an ISO8601 `date-time` (e.g. `2025-11-18T12:50:00Z`).

Usage for LLMs
- Read `schema/project.schema.json` to understand field requirements.
- Load an example from `examples/` to see real-world usage.
- Use `todo` items as actionable steps and update the manifest as work progresses.

Publishing
- When breaking schema changes are needed, bump `schemaVersion` and add
  migration notes.

License
- MIT (see `LICENSE`).
