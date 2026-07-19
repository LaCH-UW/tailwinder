Tailwinder
===

A simple pre-commit hook to compile Tailwind CSS file.

Versioning is done using `<HOOK_VERSION>.<TAILWIND_VERSION>`, e.g. 1.4.1.18 means hook version 1 and Tailwind CSS version 4.1.18.

### Usage:
Add to your `.pre-commit-config.yaml`:

```yaml
-   repo: https://github.com/LaCH-UW/tailwinder
    rev: 2.4.3.3
    hooks:
    -   id: tailwinder
        args: ["-o", "path/to/output.css", "--minify"]
```
or skip `--minify` to keep the output unminified. All the args are passed directly to the Tailwind CLI. Do not use
`--watch`, though, as it does not make sense in the context of a pre-commit hook.
