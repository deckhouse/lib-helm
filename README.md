# lib-helm

Helm utils template definitions for Deckhouse modules.

See list of definitions [here](charts/helm_lib/README.md)

## Usage

### Deckhouse

For updating `lib-helm` in the Deckhouse repo use [next](https://github.com/deckhouse/deckhouse/blob/main/helm_lib/README.md) instruction.

### Third-party repositories

You can install library as helm dependency:

```yaml
dependencies:
  - name: deckhouse_lib_helm
    version: 0.0.7
    repository: https://deckhouse.github.io/lib-helm
```

## Working with repo

### Add documentation for helm define

`lib-helm` try to collect documentation for every define and put documentation to chart [README file](charts/helm_lib/README.md).
Define documentation consists of next section:
- Define name.
- Define description.
- Define usage example.
- Define arguments description.

#### Algorithm
We use a naive [algorithm](tools/build-doc.go) to extract documentation.
We split `tpl` file by line. Each line test on define definition by regexp.
If define is found, we look for all consecutive comments above define.
Found comments become `Define description` expect of comment start with `Usage: ` string.
Comment starts with `Usage:` become `Define usage`.
After it, we look for all consecutive comments beyond define.
Every found comment become `Define arguments description`.
See [`helm_lib_pod_anti_affinity_for_ha`](charts/helm_lib/templates/_spec_for_high_availability.tpl) for [example](charts/helm_lib/README.md#helmlibpodantiaffinityforha).
`tpl` file name replace `_` on space symbol each word will be titled.
The resulting string use as category for definitions.

### Add feature
- Create new branch from `main` branch.
- Modify [templates](charts/helm_lib/templates).
- Increase minor version (0.X.0, for example set 0.2.0) or major version if changes contains breaking changes in [Charts.yaml](charts/helm_lib/Chart.yaml).
- Create PR to `main` branch and merge PR. Merging to `main` branch creates new chart release.

### Fix bug in minor release X.X
- Create new branch from release branch (`release-X.X`).
- Fix bug in [templates](charts/helm_lib/templates).
- Increase patch version (X.X.Y) in [Charts.yaml](charts/helm_lib/Chart.yaml)
- Create PR to release branch (`release-X.X`) and merge PR. Merging to release branch creates new chart release.

### Rebuild documentation

Use command (golang should be installed in system):

`make doc/build`