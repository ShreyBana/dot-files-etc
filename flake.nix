{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # river-next.url = "github:dmkhitaryan/river-next-nix-module";
    # river-next.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, river-next, ... }: {
    nixosConfigurations."section_pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit river-next; };
      modules = [
        ./configuration.nix
        # "${river-next}/river-module.nix"
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users."shrey_bana" = import .config/home-manager/home.nix;
        }
      ];
    };
  };
}
