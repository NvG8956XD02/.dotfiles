{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "Lisp Shell";
    nativeBuildInputs = with pkgs; [ sbcl ];
    shellHook = ''
      echo "Welcome in LISP Shell";
      echo "sbcl '${pkgs.sbcl}/bin/sbcl --version'"
    '';
}

