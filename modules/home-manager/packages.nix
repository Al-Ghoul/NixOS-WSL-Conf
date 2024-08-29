{ pkgs, ... }: {
  home.packages = with pkgs; [ grc lazydocker tmux-sessionizer ];
}
