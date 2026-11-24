Tailwinder
===

A simple pre-commit hook to compile Tailwind CSS file.

Versioning is done using `<HOOK_VERSION>.<TAILWIND_VERSION>`, e.g. 1.4.1.18 means hook version 1 and Tailwind CSS version 4.1.18.

### Usage:
Add to your `.pre-commit-config.yaml`:

```yaml
-   repo: https://github.com/LaCH-UW/tailwinder
    rev: 3.4.3.3
    hooks:
    -   id: tailwinder
        args: ["-i", "path/to/input.css", "-o", "path/to/output.css", "--minify"]
```

Use `-i` (or `--input`) to specify the input CSS file and `-o` (or `--output`) for the compiled output.
Skip `--minify` to keep the output unminified. All other args are passed directly to the Tailwind CLI.
Do not use `--watch`, as it does not make sense in the context of a pre-commit hook.
