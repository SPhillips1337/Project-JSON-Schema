# Project JSON Schema Reference

This document provides comprehensive documentation for all fields in the Project JSON Schema.

## Required Fields

### `schemaVersion` (string)
- **Format**: Semantic version (e.g., `"1.1.0"`)
- **Description**: Version of the schema being used
- **Example**: `"1.1.0"`

### `name` (string)
- **Description**: Human-readable project name
- **Constraints**: Minimum length of 1 character
- **Example**: `"My Awesome Project"`

### `slug` (string)
- **Format**: Lowercase letters, numbers, hyphens, and underscores only
- **Pattern**: `^[a-z0-9_-]+$`
- **Description**: URL-safe project identifier
- **Example**: `"my-awesome-project"`

### `summary` (string)
- **Description**: Brief project description
- **Constraints**: Minimum length of 1 character
- **Example**: `"A web application for managing project tasks"`

### `version` (string)
- **Format**: Semantic version with optional pre-release identifiers
- **Pattern**: `^\\d+\\.\\d+\\.\\d+(-[a-zA-Z0-9.-]+)?$`
- **Description**: Current project version
- **Examples**: `"1.0.0"`, `"2.1.0-beta.1"`

## Optional Core Fields

### `license` (string)
- **Description**: Project license identifier
- **Examples**: `"MIT"`, `"GPL-3.0"`, `"Apache-2.0"`

### `repository` (string, URI format)
- **Description**: Canonical code repository URL
- **Example**: `"https://github.com/owner/repo"`

### `lastUpdated` (string, date-time format)
- **Format**: ISO 8601 timestamp
- **Description**: When the manifest was last updated
- **Example**: `"2025-01-15T10:30:00Z"`

## Project Structure Fields

### `goals` (array of strings)
- **Description**: High-level project objectives
- **Example**: `["Improve user experience", "Reduce load times"]`

### `primary_features` (array of strings)
- **Description**: Main features of the project
- **Example**: `["User authentication", "Real-time chat"]`

### `secondary_features` (array of strings)
- **Description**: Additional or planned features
- **Example**: `["Dark mode", "Mobile app"]`

### `tech_stack` (object)
- **Description**: Technologies used in the project
- **Format**: Key-value pairs where keys are technology categories
- **Example**:
  ```json
  {
    "language": "JavaScript",
    "framework": "React",
    "database": "PostgreSQL"
  }
  ```

## Development Management

### `todo` (array of objects)
Each todo item has:
- **`id`** (string, required): Unique identifier
- **`title`** (string, required): Task description
- **`status`** (string, required): One of `"pending"`, `"in_progress"`, `"completed"`
- **`priority`** (string, optional): Task priority level

**Example**:
```json
[
  {
    "id": "1",
    "title": "Implement user login",
    "status": "in_progress",
    "priority": "high"
  }
]
```

### `development_plan` (object)
- **`currentPhase`** (integer): Current development phase number
- **`phases`** (array): List of development phases

Each phase contains:
- **`number`** (integer): Phase number
- **`name`** (string): Phase name
- **`description`** (string): Phase description
- **`tasks`** (array): List of tasks with `name` and `status`

## Progress Tracking

### `status` (string)
- **Description**: Current project status
- **Examples**: `"planning"`, `"in_progress"`, `"demo_ready"`, `"completed"`

### `progress_percent` (number)
- **Range**: 0-100
- **Description**: Overall project completion percentage
- **Example**: `75`

### `progress_state` (string)
- **Description**: Human-friendly progress description
- **Example**: `"Backend complete, working on frontend"`

### `current_goals` (array of strings)
- **Description**: Prioritized goals for current work cycle
- **Example**: `["Fix authentication bug", "Add user dashboard"]`

## Generation and Rarity System

### `rarity_system` (object)
Named rarity groups where each entry contains:
- **`chance`** (number, required): Percentage chance (0-100)
- **`colors`** (string or array): Hex color(s) - must match pattern `^#[0-9A-Fa-f]{6}$`
- **`traits`** (string or array): Associated traits

**Example**:
```json
{
  "common": {
    "chance": 70,
    "colors": "#ffffff",
    "traits": "basic"
  },
  "rare": {
    "chance": 20,
    "colors": ["#ff0000", "#00ff00"],
    "traits": ["special", "unique"]
  }
}
```

### `generation_modes` (object)
Named generation modes where each entry contains:
- **`command`** (string): Command to execute
- **`url`** (string, URI format): Optional endpoint URL
- **`description`** (string): Mode description
- **`features`** (array of strings): Supported features
- **`time`** (number or string): Generation time (seconds preferred, descriptive strings allowed)

**Example**:
```json
{
  "fast": {
    "command": "generate --fast",
    "url": "https://api.example.com/generate",
    "description": "Quick generation with basic features",
    "features": ["basic", "quick"],
    "time": 2.5
  }
}
```

### `demo_stats` (object)
Operational metrics:
- **`total_generated`** (integer): Total items generated
- **`generation_success_rate`** (number or string): Success rate (0-100 for numbers, percentage strings allowed)
- **`average_generation_time`** (number or string): Average time (seconds preferred)
- **`rarity_breakdown`** (object): Rarity occurrence statistics

**Example**:
```json
{
  "total_generated": 1000,
  "generation_success_rate": 98.5,
  "average_generation_time": 2.3,
  "rarity_breakdown": {
    "common": "70%",
    "rare": "20%",
    "legendary": "10%"
  }
}
```

## Feature Management

### `features` (object)
Grouped feature lists:
- **`completed`** (array): Finished features
- **`demo_ready`** (array): Features ready for demonstration
- **`future_enhancements`** (array): Planned improvements

## Architecture and Infrastructure

### `architecture` (object)
- **`overview`** (string): High-level architecture description
- **`components`** (object): System components with descriptions, implementation details, files, and status

### `infrastructure` (object)
- **`type`** (string): Infrastructure type (e.g., "docker-compose", "kubernetes")
- **`notes`** (string): Deployment notes
- **`files`** (array): Related infrastructure files

### `api_endpoints` (array of objects)
Each endpoint contains:
- **`endpoint`** (string, required): API endpoint path
- **`method`** (string): HTTP method
- **`description`** (string): Endpoint description

## External Dependencies

### `external_services` (object)
- **Format**: Service name to connection string mapping
- **Example**: `{"database": "postgresql://localhost:5432/mydb"}`

### `required_env` (array of strings)
- **Description**: Required environment variables
- **Example**: `["DATABASE_URL", "API_KEY"]`

## File Management

### `files_of_interest` (array of strings)
- **Description**: Important project files
- **Example**: `["src/main.js", "config/database.yml"]`

### `key_files` (object)
- **Format**: File path to description mapping
- **Example**: `{"README.md": "Project documentation", "package.json": "Dependencies"}`

## Planning and Communication

### `open_questions` (array of strings)
- **Description**: Unresolved questions or decisions needed
- **Example**: `["Which database to use?", "Should we support mobile?"]`

### `next_steps` (array of strings)
- **Description**: Immediate next actions
- **Example**: `["Set up CI/CD", "Write unit tests"]`

### `next_version_goals` (string or array of strings)
- **Description**: Goals for the next version
- **Example**: `["Performance improvements", "New user interface"]`

### `contact` (object)
- **Format**: Contact type to identifier mapping
- **Example**: `{"owner": "john_doe", "email": "john@example.com"}`

## Validation Notes

- All URI fields are validated using the JSON Schema URI format
- Date-time fields must follow ISO 8601 format
- Hex colors must be 6-digit hex codes with # prefix
- Semantic version fields are strictly validated
- Percentage values should be between 0-100 when numeric

## Best Practices

1. **Use numeric values** for machine-readable fields (percentages, times) when possible
2. **Keep slugs simple** - use lowercase, hyphens for word separation
3. **Update lastUpdated** whenever making significant changes
4. **Be specific in descriptions** - help LLMs and developers understand context
5. **Use consistent naming** - follow the established patterns in examples
6. **Validate regularly** - use `npm run validate` to check your manifest