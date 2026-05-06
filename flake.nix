{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        # standard toolkit
        pkgs.nodejs # nixpkgs provides a "nodejs" package that corresponds to the current LTS version of nodejs, but you can specify a version (i.e node_20) if necessary
        pkgs.yarn
        pkgs.pnpm # a faster alternative to npm and yarn, with a less adopted toolchain

        # optionally required by your code editor to lint and format your code
        pkgs.prettier # formatter
        pkgs.eslint # linter

        # LSP
        pkgs.vscode-langservers-extracted
        pkgs.typescript-language-server

        # example package to serve a static nextjs export
        pkgs.serve
      ];
    };
  };
}

