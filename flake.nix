{
  description = "FFLinuxPrint NixOS Flake";
  # Download the binary from https://shop.tiertime.com/product/catfish/

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = 
      with import nixpkgs { system = "x86_64-linux"; };
      
      stdenv.mkDerivation (finalAttrs: {
        pname = "UpStudio Catfish 1.2.6";
        version = "1.2.6";
      
	src = ./Catfish_L_1.2.6.zip;
        sourceRoot = "./";
        unpackCmd = "unzip $src -d $sourceRoot";
      
        nativeBuildInputs = [
	  autoPatchelfHook
	  unzip
	  stdenv.cc.cc.lib
	  fontconfig
	  libGL
	  glib
	  libgpg-error
	  libdrm
	  qt6.qtwayland
	  qt6.wrapQtAppsHook
        ];
      
        buildInputs = [
        ];
      
        dontConfigure = true;
        dontBuild = true;
     # autoPatchelfHook --recursive $out/LinuxApp/Catfish
        installPhase = ''
	runHook preInstall
	cp -r $sourceRoot $out
	runHook postInstall
        '';
      
        meta = {
          description = "TierTime UpStudio - Catfish";
          homepage = "https://shop.tiertime.com/product/catfish/";
          license = lib.licenses.unfree;
          maintainers = with lib.maintainers; [ jaduff ];
          platforms = lib.platforms.linux;
          sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
        };
      });
  };
}
