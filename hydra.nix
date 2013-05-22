/* Build instructions for the continuous integration system Hydra. */

{ hydraSrc ? { outPath = ../hydra; revCount = 0; gitTag = "dirty"; }
}:

builtins.removeAttrs (import "${hydraSrc}/release.nix" { inherit hydraSrc; }) ["tests"]
