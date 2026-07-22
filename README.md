# UOSL Emulator

An archived Delphi 6 UOSL server/emulator, preserved from the r5y2006 source release and rebuilt successfully on a modern Windows system.

This is historical software. It is useful as a reference implementation and a basis for preservation or modernisation work, not as a hardened public-facing server.

## Status

The original Delphi 6 project compiles successfully with its original third-party dependencies restored. The generated executable is:

```text
bin\uoslserver.exe
```

The project uses a GUI, even though its old project settings mark it as a console application.

## Source layout

Keep the original relative layout. The Delphi project settings depend on it:

```text
uoslemu/
├── src/
│   ├── uoslserver.dpr
│   ├── uoslserver.dof
│   ├── Unit1.pas / Unit1.dfm
│   ├── Unit2.pas / Unit2.dfm
│   └── supporting project files
├── lib/
│   ├── ifps3/
│   ├── ics/
│   │   └── Delphi/
│   │       └── Vc32/
│   └── richSyntax/
└── bin/                 # build output, created as needed
```

The existing `uoslserver.dof` has these paths:

```text
Search path:       ..\lib\ifps3;..\lib\ics\Delphi\Vc32;..\lib\richSyntax;..\lib
Unit output:       dcu
Executable output: ..\bin
```

## Build requirements

- **Borland Delphi 6 for Windows**. This is an Object Pascal / VCL project, not a C++Builder project.
- **Overbyte ICS (Internet Component Suite)**, using the historical `Delphi\Vc32` source layout compatible with Delphi 6.
  - Required units: `WSocket`, `WSocketS`, and `HttpSrv`.
  - These provide the `TWSocketServer` and `THttpServer` form components.
- **Innerfuse Pascal Script 3 (IFPS3)**, providing `ifpscomp`, `ifps3`, `oldifps3utl`, and `Hashes`.
- **RichSyntax / PSV Pascal syntax-highlighting** component, providing `psvPas`.

The exact dependency locations are preserved in the project settings. If a component is reported missing while loading `Unit1.dfm`, install the relevant design-time package first. Do not choose **Ignore All** and save the form: Delphi may remove unrecognised components from the DFM.

## Build from a clean checkout

1. Clone the repository and arrange the project in the layout above.
2. Install Delphi 6. Running it elevated is only necessary if it was installed under a protected directory.
3. Place the legacy dependency source trees under `lib`, or change the Delphi library/search paths to their locations.
4. For ICS:
   - Make sure `lib\ics\Delphi\Vc32` is writable.
   - Build and install the Delphi 6 ICS design-time package (normally `IcsDel60.dpk`, if supplied by the archive).
   - Confirm the ICS component palette is present, then open `src\uoslserver.dpr`.
5. In Delphi, open **Project → Options → Directories/Conditionals** and verify:
   - **Search path** includes all three `..\lib` paths above.
   - **Unit output directory** is `dcu`.
   - **Output directory** is `..\bin`.
6. Select **Project → Build uoslserver**. Use **Run → Run** / `F9` if you want to launch it under the debugger.
7. Retrieve the binary from `bin\uoslserver.exe`.

## Common build failures

| Error | Cause | Fix |
| --- | --- | --- |
| `Class TWSocketServer not found` or `Class THttpServer not found` | ICS design-time package is not installed. | Install the matching old ICS package, then reopen the form. |
| `Could not create output file dcu\\WSockBuf.dcu` | ICS source/its `dcu` folder is not writable or does not exist. | Move ICS outside `Program Files`, create its `dcu` directory, and ensure write permission. |
| `File not found: ifpscomp.pas`, `ifps3.pas`, or `psvPas.pas` | A legacy dependency is absent from the search path. | Restore the relevant `lib\ifps3` or `lib\richSyntax` source tree, or update the project search path. |
| The IDE only launches the debugger | That is normal for `F9`. | Use **Project → Build** for a build-only operation; the EXE is written to `bin`. |

## Runtime notes

The server configuration is stored in `uoslserver.cfg`. The UI asks for paths to Ultima Online client data such as `statics0.mul`; those game data files are not included in this repository.

Do not expose this legacy server directly to the internet without a separate security review and isolation layer.

## Provenance

This repository preserves an older source release that identifies itself as `r5y2006`. The source has been recovered and made buildable; it has not yet been functionally modernised.
