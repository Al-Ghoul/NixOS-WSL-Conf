_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Abdo .AlGhoul";
        email = "Abdo.AlGhouul@gmail.com";
      };
      url = { "ssh://git@github.com" = { insteadOf = "https://github.com"; }; };
    };
  };
}
