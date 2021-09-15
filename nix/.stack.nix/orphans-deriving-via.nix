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
    flags = { development = false; };
    package = {
      specVersion = "1.10";
      identifier = { name = "orphans-deriving-via"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "IOHK";
      maintainer = "operations@iohk.io";
      author = "IOHK";
      homepage = "";
      url = "";
      synopsis = "Orphan instances for the base-deriving-via hooks";
      description = "";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."base-deriving-via" or (errorHandler.buildDepError "base-deriving-via"))
          (hsPkgs."deepseq" or (errorHandler.buildDepError "deepseq"))
          (hsPkgs."nothunks" or (errorHandler.buildDepError "nothunks"))
          ];
        buildable = true;
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/input-output-hk/cardano-base";
      rev = "46502694f6a9f0498f822068008b232b3837a9e9";
      sha256 = "04bvsvghkrjhfjb3phh0s5yfb37fishglrrlcwbvcv48y2in1dcz";
      }) // {
      url = "https://github.com/input-output-hk/cardano-base";
      rev = "46502694f6a9f0498f822068008b232b3837a9e9";
      sha256 = "04bvsvghkrjhfjb3phh0s5yfb37fishglrrlcwbvcv48y2in1dcz";
      };
    postUnpack = "sourceRoot+=/orphans-deriving-via; echo source root reset to \$sourceRoot";
    }