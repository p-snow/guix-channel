# Private Guix Channel

## Build System

To verify a specific package from this channel:
```
guix build -L . <package-name>
```

## Coding Standards

- All documentation, skill files, and AGENTS.md must be written in English
- All package definition files (.scm) must be written in English

## Testing

## Updating -latest Packages

Packages with `-latest` suffix should be periodically updated to track the latest commits from upstream repositories.

See `update-latest.skill` for the detailed workflow.

## Committing Changes

After updating packages and verifying builds with `guix build`, it is acceptable to commit the changes directly without asking for confirmation.
