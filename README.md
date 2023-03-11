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