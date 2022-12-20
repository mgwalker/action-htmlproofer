# htmlproofer

This action runs [htmlproofer](https://github.com/gjtorikian/html-proofer) on
HTML files. If there are any identified errors, it will convert them into
annotations to make them easier to read in the test output.

Currently using htmlproofer 5. For configuration arguments, see the
[htmlproofer configuration](https://github.com/gjtorikian/html-proofer#configuration)
documentation. Note that the options listed on that page should be prefixed with
two dashes, and underscores should be replaced with dashes. E.g., the
`allow_missing_href` option would become `--allow-missing-href` when using this
action.

## Usage

```yaml
- uses: mgwalker/action-htmlproofer@v1
  with:
    # The path in your repository to scan for HTML files. In order to ensure
    # this path is present, be sure to checkout the repository before running
    # this action. Defaults to "."
    path: "_pages"

    # Any additional argumets to pass into htmlproofer.
    args: "--disable-external --allow-missing-href"
```
