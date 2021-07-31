{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "typed-protocols"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "2019 Input Output (Hong Kong) Ltd.";
      maintainer = "alex@well-typed.com, duncan@well-typed.com, marcin.szamotulski@iohk.io";
      author = "Alexander Vieth, Duncan Coutts, Marcin Szamotulski";
      homepage = "";
      url = "";
      synopsis = "A framework for strongly typed protocols";
      description = "";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."io-classes" or (errorHandler.buildDepError "io-classes"))
          ];
        buildable = true;
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/input-output-hk/ouroboros-network";
      rev = "f026e71e8925dc2cb1a55a9a77b54bbeb1273ef0";
      sha256 = "0wmlrkdi7q868872p4ah35z51511yqkr8pj90fwadlr6ipkbpkl9";
      }) // {
      url = "https://github.com/input-output-hk/ouroboros-network";
      rev = "f026e71e8925dc2cb1a55a9a77b54bbeb1273ef0";
      sha256 = "0wmlrkdi7q868872p4ah35z51511yqkr8pj90fwadlr6ipkbpkl9";
      };
    postUnpack = "sourceRoot+=/typed-protocols; echo source root reset to \$sourceRoot";
    }