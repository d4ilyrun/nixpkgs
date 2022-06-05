{ stdenv, fetchFromGitHub, kernel }:

stdenv.mkDerivation rec {
  pname = "v4l2loopback-dc";
  version = "0";

  src = fetchFromGitHub {
    owner = "aramg";
    repo = "droidcam";
    rev = "v1.5";
    sha256 = "tIb7wqzAjSHoT9169NiUO+z6w5DrJVYvkQ3OxDqI1DA=";
  };

  sourceRoot = "source/linux/v4l2loopback";

  KVER = "${kernel.modDirVersion}";
  KBUILD_DIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    mkdir -p $out/lib/modules/${KVER}/kernels/media/video
    cp v4l2loopback-dc.ko $out/lib/modules/${KVER}/kernels/media/video/
  '';

  meta = with stdenv.lib; {
    description = "DroidCam kernel module v4l2loopback-dc";
    homepage = https://github.com/aramg/droidcam;
  };
}
