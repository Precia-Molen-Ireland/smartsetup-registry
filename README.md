# Precia Molen Ireland Smart Setup registry

Product catalogue for [TMS Smart Setup](https://doc.tmssoftware.com/smartsetup/).
One folder per product, each holding a `tmsbuild.yaml` that tells Smart Setup
where the product's git repository is and how to build it. No source code lives here.

Smart Setup cannot fetch a zip from a private GitHub repo, so each developer
machine keeps a clone of this repo and Smart Setup reads a zip built from that
clone (`GenMobileMultiTenancy\Build.ps1` does the clone, pull, zip and
`tms server-add pmi zipfile file://...` steps automatically).

## Manual setup

```
git clone https://github.com/Precia-Molen-Ireland/smartsetup-registry.git C:\Delphi\Comps\smartsetup-registry
powershell -c "Compress-Archive -Path C:\Delphi\Comps\smartsetup-registry\* -DestinationPath C:\Delphi\Comps\smartsetup-registry.zip -Force"
cd C:\Delphi\Comps\tms
tms server-add pmi zipfile file://C:\Delphi\Comps\smartsetup-registry.zip
tms install gdk.markdown4d
```

Re-zip after every change to a `tmsbuild.yaml`; Smart Setup reads the zip, not the folder.
`Update-Registry.ps1` does the pull and re-zip in one go (`-NoPull` to zip local edits only).

## Products

| id | source | notes |
|---|---|---|
| `gdk.markdown4d` | https://github.com/GDKsoftware/Markdown4D | upstream has no tmsbuild.yaml, so the copy here is used |
| `pmi.bi400` | https://github.com/Precia-Molen-Ireland/bi400-comms | private repo, needs org access; tmsbuild.yaml also lives in the repo |
| `pmi.common` | https://github.com/Precia-Molen-Ireland/misc | private repo; source-only units plus the jsonadapt package |
| `pmi.kastri` | https://github.com/DelphiWorlds/Kastri | upstream Kastri, unmodified; community definition plus library paths for Core, FeaturesConnectivity, API, Include |
| `pmi.modlink` | https://github.com/Precia-Molen-Ireland/ModLink2 | private repo; purchased Modbus components |
| `pmi.propc` | https://github.com/Precia-Molen-Ireland/propc | private repo; OPC kit, design package plus server units from source |
| `vsoft.delphimocks` | https://github.com/VSoftTechnologies/Delphi-Mocks | upstream, unmodified |
| `grijjy.foundation` | https://github.com/grijjy/GrijjyFoundation | upstream, unmodified; source on the library path, small generated package |
| `pleriche.fastmm4` | https://github.com/pleriche/FastMM4 | upstream, unmodified; source on the library path, small generated package |
