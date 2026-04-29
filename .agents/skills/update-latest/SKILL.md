# Update -latest Guix Packages

This skill updates `-latest` suffix packages to use the latest commits from their upstream git repositories.

## Workflow

1. **Find all -latest packages**: Search through all `.scm` files in `p-snow/packages/` for package definitions ending with `-latest`

2. **Extract package info**: For each -latest package, extract:
   - Package name
   - Git repository URL
   - Current commit hash
   - Current revision
   - File location (for updating)

3. **Check for updates**: For each package:
   - Use `git ls-remote` to get the latest commit from the default branch
   - Compare with the current commit

4. **Calculate new hash**: If commit changed:
   - Fetch the new commit using `guix hash-git --url=<url> --commit=<new-commit>`
   - Update the hash in the package definition

5. **Verify builds**: After updating, verify each package builds correctly:
   ```
   guix build -L . <package-name>
   ```

6. **Update files**: Write the updated package definitions back to the .scm files

## Usage

Load this skill, then invoke with description like "update-latest" and prompt describing the task.

Example prompt:
```
Find all -latest packages in p-snow/packages/, check each upstream repository for new commits, and update any packages where the commit has changed. Make sure to recalculate the hash values for updated packages. After updating, verify the builds with guix build.
```

## Notes

- Only packages with `-latest` suffix should be updated
- Use `guix hash-git` to calculate the hash for git sources
- Preserve the existing code style and formatting
- Show a summary of what was updated
- Always verify builds after updating packages
