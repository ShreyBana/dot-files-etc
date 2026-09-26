{
  lib,
  stdenv,
  zig_0_15,
  libxkbcommon,
  wayland,
  wayland-protocols,
  river,
  callPackage,
  pkg-config,
  wayland-scanner,
  bison,
  libxml2,
  expat,
  systemd,
  dbus,
  libffi,
  writeShellScript,
  writeTextFile
}:
let
  rijan-fork = stdenv.mkDerivation (finalAttrs: {
    pname = "rijan-fork";
    version = "vendored-patched";
    src = ./.;
    deps = callPackage ./build.zig.zon.nix { };

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
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
    };
  });

  init-script = writeShellScript "rijan-init" ''
    export XDG_CURRENT_DESKTOP=river

    ${systemd}/bin/systemctl --user import-environment \
      WAYLAND_DISPLAY \
      XDG_CURRENT_DESKTOP \
      XDG_RUNTIME_DIR \
      DISPLAY
    ${dbus}/bin/dbus-update-activation-environment --systemd \
      WAYLAND_DISPLAY \
      XDG_CURRENT_DESKTOP \
      XDG_RUNTIME_DIR \
      DISPLAY

    ${systemd}/bin/systemctl --user start river-session.target

    exec /run/current-system/sw/bin/rijan-fork
  '';

  river-launcher = writeShellScript "river-rijan-launcher" ''
    exec dbus-run-session -- ${river}/bin/river -c ${init-script} \
         > "/tmp/river-$(date +%s).log" 2>&1 
  '';

  desktop-file = writeTextFile {
    name = "river-rijan-session";
    destination = "/share/wayland-sessions/river-rijan.desktop";
    text = ''
      [Desktop Entry]
      Name=River (rijan)
      Type=Application
      Comment=Launch River with rijan as window manager.
      Exec=${river-launcher}
    '';
    passthru.providedSessions = [ "river-rijan" ];
  };
in
{
  package = rijan-fork;
  desktop-file = desktop-file;
}
