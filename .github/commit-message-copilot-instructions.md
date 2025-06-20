# Commit Message Generation

## Commits Messages

Commit messages should be clear, informative, and professional, aiding readability and project tracking.

## Objective

Follow the Conventional Commits format strictly for commit messages.

## Structure

The commit message should be structured as follows:

```
  <type> [optional scope]: <description>

  [optional body]

  [optional footer(s)]
```

## Guidelines

1. **Title**: Start with a concise, informative title.
2. **Type** Choose an appropriate type (e.g., `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `perf`, `build`, `revert`).

- Use `feat` for new features (this correlates with PATCH in Semantic Versioning).
- Use `fix` for bug fixes (this correlates with MINOR in Semantic Versioning).
- Use `docs` for documentation changes.
- Use `style` for changes that do not affect the meaning of the code (e.g., white-space, formatting, missing semi-colons).
- Use `refactor` for code changes that neither fix a bug nor add a feature.
- Use `test` for adding missing tests or correcting existing tests.
- Use `chore` for changes to the build process or auxiliary tools and libraries such as documentation generation.
- Use `ci` for changes to the CI configuration files and scripts.
- Use `perf` for changes that improve performance.
- Use `build` for changes that affect the build system or external dependencies.
- Use `revert` for reverting a previous commit.
- Use `iac` for changes to the infrastructure as code.

3. **Scope**: optional scope to describe the affected module, resource or feature.
4. **Description**: Write a concise, informative description in the header; use backticks if referencing code or specific terms.
5. **Body**: For additional details, use a well-structured body section:

- Use bullet points (`*`) for clarity.
- Clearly describe the motivation, context, or technical details behind the change, if applicable.

6. **Footers**: other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format

- Use `BREAKING CHANGE` a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.

## Importance

This instructions are important because:

- Critical to the organization's operations
