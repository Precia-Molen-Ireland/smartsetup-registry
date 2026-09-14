# Precia Molen Ireland Smart Setup registry

Product catalogue for [TMS Smart Setup](https://doc.tmssoftware.com/smartsetup/).
One folder per product, each holding a `tmsbuild.yaml` that tells Smart Setup
where the product's git repository is and how to build it. No source code lives here.

Smart Setup reads this catalogue straight from GitHub's zip of the `main` branch:

```
https://github.com/Precia-Molen-Ireland/smartsetup-registry/archive/refs/heads/main.zip
```

That is why the repo is public: it must be fetchable without credentials, the same way the
TMS community server is. It contains only these `tmsbuild.yaml` files. The product repos it
points at stay private; Smart Setup clones them with git and your own GitHub login.

## Setup on a machine

`GenMobileMultiTenancy\Build.ps1` registers the server automatically. By hand:

```
cd C:\Delphi\Comps\tms
tms server-add pmi zipfile https://github.com/Precia-Molen-Ireland/smartsetup-registry/archive/refs/heads/main.zip
tms install gdk.markdown4d
```

## Changing the catalogue

Edit or add a `<product.id>\tmsbuild.yaml`, commit, push. Smart Setup notices the new zip on
its next run through GitHub's ETag; there is nothing to rebuild locally.

## Products

| id | source | notes |
|---|---|---|
| `gdk.markdown4d` | https://github.com/GDKsoftware/Markdown4D | upstream has no tmsbuild.yaml, so the copy here is used |
| `pmi.bi400` | https://github.com/Precia-Molen-Ireland/bi400-comms | private repo, needs org access; tmsbuild.yaml also lives in the repo |
| `pmi.common` | https://github.com/Precia-Molen-Ireland/misc | private repo; source-only units plus the jsonadapt package |
| `pmi.kastri` | https://github.com/DelphiWorlds/Kastri | upstream Kastri, unmodified; community definition plus library paths for Core, FeaturesConnectivity, API, Include |
| `pmi.modlink` | https://github.com/Precia-Molen-Ireland/ModLink2 | private repo; purchased Modbus components |
| `pmi.propc` | https://github.com/Precia-Molen-Ireland/propc | private repo; OPC kit, design package plus server units from source |
| `pmi.sigplus` | https://github.com/Precia-Molen-Ireland/sigplus-delphi | private repo; Topaz SigPlus ActiveX import; run Installer\sigplus.exe once per machine |
| `vsoft.delphimocks` | https://github.com/VSoftTechnologies/Delphi-Mocks | upstream, unmodified |
| `grijjy.foundation` | https://github.com/grijjy/GrijjyFoundation | upstream, unmodified; source on the library path, small generated package |
| `pleriche.fastmm4` | https://github.com/pleriche/FastMM4 | upstream, unmodified; source on the library path, small generated package |
