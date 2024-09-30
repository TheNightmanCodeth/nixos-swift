{
  description = "Swift 6, god willing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    swift-github = {
      url = "github:swiftlang/swift";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }: 
    let
      pkgs = import nixpkgs { system = "aarch64-linux"; };
      swiftPkg = import ./swift {
        # TODO: Lazy
        inherit pkgs; 
        lib = pkgs.lib; 
        newScope = pkgs.newScope;
        darwin = pkgs.darwin;
        llvmPackages = pkgs.llvmPackages;
        llvmPackages_17 = pkgs.llvmPackages_17;
        overrideCC = pkgs.overrideCC;
        swift_toolchain = pkgs.swiftPackages.swift-driver;
        host_libdispatch = pkgs.swift-corelibs-libdispatch;
      };
    in {
    nixosModules = rec {
      swift_6 = swiftPkg.swift;
      default = swift_6;
    };
  };
}
