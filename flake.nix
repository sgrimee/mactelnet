{
  description = "MAC-Telnet for Posix systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    defaultPackage.aarch64-darwin = with import nixpkgs {system = "aarch64-darwin";};
      stdenv.mkDerivation {
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
  };
}
