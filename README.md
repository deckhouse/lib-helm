# lib-helm

Helm utils template definitions for Deckhouse modules.

See list of definitions [here](charts/helm_lib/README.md)

## Usage

You can install library as helm dependency:

```yaml
dependencies:
  - name: deckhouse_lib_helm
    version: 0.0.7
    repository: https://deckhouse.github.io/lib-helm
```

## Working with repo

### Rebuild documentation

Use command (golang should be installed in system):

`make doc/build`