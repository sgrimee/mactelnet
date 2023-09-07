{
  description = "MAC-Telnet for Posix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      drv = self.packages.${system}.mactelnet;
    in {
      packages = with pkgs; rec {
        mactelnet = stdenv.mkDerivation {
          name = "mactelnet";
          src = fetchFromGitHub {
            owner = "haakonnessjoen";
            repo = "MAC-Telnet";
            rev = "c3dc4515b1aff09372cdb04aef393437dc2d8f60";
            sha256 = "sha256-EKs0x5YsmmVD/2Qrqzi3/OXHQc5VSPs+aJa7cLHtAD8=";
          };
          nativeBuildInputs = [
            autoconf
            automake
            autoreconfHook
            gettext
            libtool
            openssl
            pkg-config
          ];
          installPhase = ''
            cd src
            mkdir -p $out/bin;
            install -t $out/bin mactelnet macping mndp;
            mkdir -p $out/sbin;
            install -t $out/sbin mactelnetd;
          '';
        };
        default = mactelnet;
      };

      apps = rec {
        macping = flake-utils.lib.mkApp {
          inherit drv;
          name = "macping";
        };
        mactelnet = flake-utils.lib.mkApp {inherit drv;};
        mndp = flake-utils.lib.mkApp {
          inherit drv;
          name = "mndp";
        };
        default = mactelnet;
      };
    });
}
