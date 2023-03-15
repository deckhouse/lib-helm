# Testing

This directory contains chart for unit testing `lib-helm`.
`lib-helm` uses [unittest](https://github.com/helm-unittest/helm-unittest) helm plugin for unit testing.

## Run tests

For running tests use the next command:

```bash
make tests/unit
```

## How to add test

For definition (for example `helm_lib_is_ha_to_value`) you need to create two files.
Create first file in [templates](templates) directory with name **define_name**.yaml (for example, `helm_lib_is_ha_to_value.yaml`). 
This file should contain include definition (see [this example](templates/helm_lib_is_ha_to_value.yaml)).

Second file (with test suite) you should create in [tests](tests) directory with name **define_name**_test.yaml (for example `helm_lib_is_ha_to_value_test.yaml`).
For write test see [official documentation](https://github.com/helm-unittest/helm-unittest/blob/main/DOCUMENT.md) and see
examples for [helm_lib_is_ha_to_value](tests/helm_lib_is_ha_to_value_test.yaml)
and for [helm_lib_kube_rbac_proxy_ca_certificate](tests/helm_lib_kube_rbac_proxy_ca_certificate_test.yaml) definitions.

### Snapshot asserts

If you use [snapshot asserts](https://github.com/helm-unittest/helm-unittest#snapshot-testing) 
you should create/update snapshot file, for it use the next command

```bash
make tests/unit/update-snapshot
```

and commit files.