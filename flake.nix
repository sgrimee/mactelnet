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
          autoreconfHook
          pkg-config
        ];
        buildInputs = [
          autoconf
          automake
          gettext
          libtool
          openssl
        ];
        installPhase = ''
          mkdir -p $out/bin;
          cd src
          install -t $out/bin mactelnet;
        '';
      };
  };
}
# wget http://github.com/haakonnessjoen/MAC-Telnet/tarball/master -O mactelnet.tar.gz
# tar zxvf mactelnet.tar.gz
# cd haakonness*/
# # Install dependencies
# brew install gettext autoconf automake libtool openssl
# export GETTEXT_PATH=$(brew --prefix gettext)
# export OPENSSL_PATH=$(brew --prefix openssl)
# export PATH="${GETTEXT_PATH}/bin:${OPENSSL_PATH}/bin:$PATH"
# export LDFLAGS="-L${GETTEXT_PATH}/lib"
# export CPPFLAGS="-I${GETTEXT_PATH}/include -I${OPENSSL_PATH}/include"
# export CRYPTO_CFLAGS="-I${OPENSSL_PATH}/include"
# export CRYPTO_LIBS="-L${OPENSSL_PATH}/lib ${OPENSSL_PATH}/lib/libcrypto.3.dylib"
# ./autogen.sh
# make all install

