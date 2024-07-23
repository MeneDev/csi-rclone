{ pkgs, containerPkgs, csiDriverLinux, architecture}:

pkgs.dockerTools.streamLayeredImage {
  name = "csi-rclone";
  tag = "latest";
  architecture = architecture;
  config.Cmd = [ (if architecture == "amd64" then "/bin/linux_amd64/csi-rclone-plugin" else "/bin/linux_arm64/csi-rclone-plugin") ];
  contents = [
    csiDriverLinux

    containerPkgs.bashInteractive
    containerPkgs.cacert
    containerPkgs.coreutils
    containerPkgs.fuse3
    containerPkgs.gawk
    containerPkgs.rclone
    containerPkgs.findutils
  ];

  extraCommands = ''
    mkdir -p ./plugin
    mkdir -p ./tmp
  '';
}
