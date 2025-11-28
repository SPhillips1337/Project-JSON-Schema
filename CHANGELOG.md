# Changelog

All notable changes to this project are documented in this file.

## Unreleased

### Added
- `package.json` for proper dependency management and npm scripts
- Comprehensive test suite (`test`) for schema validation edge cases
- Pre-commit hooks configuration (`.pre-commit-config.yaml`) for code quality
- `.gitignore` file for Node.js development
- `SCHEMA_REFERENCE.md` with comprehensive field documentation
- Enhanced validation patterns for hex colors, semantic versions, and time formats
- Multiple npm scripts for different validation scenarios
- JSON linting and formatting support

### Fixed
- **CRITICAL**: Removed trailing comma in `templates/project.template.json` (line 69)
- **CRITICAL**: Fixed CI/CD workflow paths to match actual repository structure
- Added missing `ajv-formats` dependency for proper URI and date-time validation
- Enhanced schema validation with better error patterns and descriptions
- Corrected documentation commands to match actual file structure

### Changed
- Updated `.github/workflows/validate.yml` to use npm dependencies and proper file paths
- Enhanced schema with stricter validation patterns and better descriptions
- Improved `README.md` and `CONTRIBUTING.md` with correct commands and file references
- Added comprehensive validation for rarity system colors (hex pattern validation)
- Enhanced demo_stats validation with proper percentage and time format patterns
- Improved generation_modes with better time format validation

### Technical Improvements
- Added `additionalProperties: false` to prevent schema pollution in nested objects
- Enhanced type validation with `oneOf` patterns for flexible field types
- Added minimum/maximum constraints for numeric fields
- Improved regex patterns for version validation and time formats
- Added comprehensive descriptions to all schema fields


## 1.1.0 - 2025-11-24

- feat(schema): extend schema with non-breaking project-specific fields
  - Added optional properties to `schema/project.schema.json` to support generation metadata, progress tracking, and operational handoffs:
    - `status` (string) — human-friendly state (e.g. `planning`, `in_progress`, `completed`)
    - `concept` (string) — short project concept statement
    - `current_goals` (array[string]) — high-priority goals
    - `key_files` (object<string,string>) — map of important files to short descriptions
    - `rarity_system` (object) — named rarity groups; each entry is an object with:
      - `chance` (number, 0–100) — percentage chance
      - `colors` (string | array[string]) — hex color or list of colors
      - `traits` (string | array[string]) — single trait or list of traits
    - `generation_modes` (object) — named modes; each entry is an object with:
      - `command` (string)
      - `url` (string, `uri` format) — optional remote endpoint
      - `description` (string)
      - `features` (array[string])
      - `time` (string | number) — numeric seconds or descriptive string
    - `features` (object) — grouped feature lists: `completed`, `demo_ready`, `future_enhancements`
    - `demo_stats` (object):
      - `total_generated` (integer)
      - `generation_success_rate` (number | string) — numeric preferred (percentage), string allowed for legacy values like `"98.7%"`
      - `average_generation_time` (number | string) — seconds preferred
      - `rarity_breakdown` (object<string,string>)
    - `progress_percent` (number, 0–100)
    - `progress_state` (string)
    - `next_version_goals` (string | array[string])
  - These additions are optional and intentionally non-breaking; existing manifests remain valid.

- docs: update examples and template to include placeholders and example values for the new fields

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

Notes:
- Local validation with Ajv succeeded for the template and examples. Ajv emitted warnings about `format: "uri"` and `format: "date-time"` being ignored because `ajv-formats` is not enabled; consider adding `ajv-formats` to CI if you want strict format validation in the workflow.

---

(End of changelog)
