with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";

  # Mandatory boilerplate for buildable env
  env = buildEnv { name = name; paths = buildInputs; };
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup; ln -s $env $out
  '';

  # Customizable development requirements
  buildInputs = [
    # Add packages from nix-env -qaP | grep -i needle queries
    #redis

    dot2tex
    graphviz
    gmp

    # With Python configuration requiring a special wrapper
    (python3.buildEnv.override {
      ignoreCollisions = true;
      extraLibs = with python3Packages; [
        # Add pythonPackages without the prefix
        pygments
        pygame
        pillow
      ];
    })
  ];

  # Customizable development shell setup with at last SSL certs set
  #shellHook = ''
  #  export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  #'';
}


# { pkgs ? import <nixpkgs> {} }:
#   pkgs.mkShell {
#     buildInputs = [python3Packages.pygments];
# }

