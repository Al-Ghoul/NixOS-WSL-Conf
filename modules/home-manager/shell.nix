{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [{
      inherit (pkgs.fishPlugins.grc) src;
      name = "grc";
    }];
  };
}
