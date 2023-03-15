# lib-helm

Helm utils template definitions for Deckhouse modules.

See list of definitions [here](charts/helm_lib/README.md)

## Usage

### Deckhouse

Use the following [instruction](https://github.com/deckhouse/deckhouse/blob/main/helm_lib/README.md) to update `lib-helm` in the Deckhouse repo.

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

`lib-helm` tries to collect documentation for the every _define_ and put documentation into the [README file](charts/helm_lib/README.md) of a chart.
Documentation of the define consists of the following sections:
- The name of the define.
- The description of the define.
- Usage example of the define.
- Arguments description of the define.

#### Algorithm

We use a naive [algorithm](tools/build-doc.go) to extract documentation.

We split `tpl` file by line. Each line is checked for a define definition using a regular expression.

If define is found, we look for all consecutive comments above define.
All the comments found except those that start with the `Usage:` become `The description of the define`.
Comments starting with `Usage:` become `Usage example of the define`.
After it, we look for all consecutive comments beyond the define.
Every found comment becomes `Arguments description of the define`.
See [`helm_lib_pod_anti_affinity_for_ha`](charts/helm_lib/templates/_spec_for_high_availability.tpl) for [example](charts/helm_lib/README.md#helmlibpodantiaffinityforha).

We use the name of the `tpl` file with the following transformation for the category of definitions: 
the '_' symbol is replaced by the space symbol, 
the first letter of each word is capitalized, and spaces from either side of a result are ignored. 
E.g., `_foo_bar.tpl` converts to `Foo Bar`.

#### Rebuild documentation

If you change or add definition documentation comment, you should rebuild [README.md](charts/helm_lib/README.md) with documentation.
Use the following command (Go should be installed):

`make doc/build`

### Add feature

- Create a new branch from the `main` branch.
- Modify [templates](charts/helm_lib/templates).
- In [Charts.yaml](charts/helm_lib/Chart.yaml) increase the minor version (maj.**min**.patch) in case of non-significant changes or the major version otherwise.
- Create and merge PR to the `main` branch. The new chart release will be created after merging the PR.

### Fix bug

- Create branch from the `main` branch.
- Fix bug in [templates](charts/helm_lib/templates).
- Increase a patch version (maj.min.**patch**) in [Charts.yaml](charts/helm_lib/Chart.yaml).
- Create and merge PR to the `main` branch. The new chart release will be created after merging the PR.
- Create a new branch from the release branch (`release-maj.min`).
- Cherry pick commit with the fix from the `main` to the new branch.
- Create and merge PR to the release branch (`release-maj.min`).

#### Backport fix in previous minor release X.X

- Create a new branch from the release branch (`release-X.X`).
- Cherry pick commit from the `main` branch.
- Increase a patch version for X.X release (X.X.**patch**) in [Charts.yaml](charts/helm_lib/Chart.yaml).
- Create and merge PR to the release branch (`release-X.X`). The new chart release will be created after merging the PR.
