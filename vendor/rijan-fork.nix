{
  lib,
  stdenv,
  zig_0_15,
  libxkbcommon,
  wayland,
  wayland-protocols,
  callPackage,
  pkg-config,
  wayland-scanner,
  bison,
  libxml2,
  expat,
  libffi,
  riverNextRoot,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "rijan-fork";
  version = "vendored-patched";

  src = ./rijan-fork;

  deps = callPackage "${riverNextRoot}/window-managers/rijan/build.zig.zon.nix" { };

  nativeBuildInputs = [
    zig_0_15
    wayland-scanner
    wayland-protocols
    pkg-config
    bison
  ];
  buildInputs = [
    libxkbcommon
    wayland
    libxml2
    expat
    libffi
  ];

  postInstall = ''
    install -Dm755 $src/example/init.janet -t $out/example/
  '';

  doInstallCheck = true;
  zigBuildFlags = [
    "--system"
    "${finalAttrs.deps}"
    "-Doptimize=ReleaseSafe"
  ];

  meta = {
    description = "rijan, patched to remove built-in opaque background";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
