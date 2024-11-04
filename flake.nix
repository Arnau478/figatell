{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.figatell = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/figatell
        ./system.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.arnau = {
            imports = [
              ./home
	            nixvim.homeManagerModules.nixvim
            ];
            home.stateVersion = "24.05";
          };
        }
      ];
    };
  };
}
