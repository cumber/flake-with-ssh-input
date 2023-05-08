{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    trivial.url = "git+ssh://git@github.com/cumber/flake-trivial.git?ref=main";
    trivial.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, trivial }: {

    packages.x86_64-linux.slightly-less-trivial = nixpkgs.legacyPackages.x86_64-linux.writeTextFile {
      name = "slightly-less-trivial";
      text = ''
        I am a slightly less trivial package, because I depend on this one:

        ${trivial.packages.x86_64-linux.trivial}
      '';
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.slightly-less-trivial;
  };
}
