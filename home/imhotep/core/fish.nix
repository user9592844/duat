{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source

      for file in ~/.config/fish/functions/*.fish
        source $file
      end
    '';
    functions = {
      # GCC Aliases
      gcc = "command gcc -Wall -Wextra -Werror -Wpedantic $argv";
      gcc-asm = "gcc -c $argv";
      gcc-com = "gcc -S $argv";
      gcc-pre = "gcc -E $argv";

      # G++ Aliases
      "g++" = "command g++ -Wall -Wextra -Werror -Wpedantic $argv";
      "g++-asm" = "g++ -c $argv";
      "g++-com" = "g++ -S $argv";
      "g++-pre" = "g++ -E $argv";

      # Git Aliases
      gita = "git add $argv";
      gitb = "git branch $argv";
      gitc = "git checkout $argv";
      gitd = "git branch -D $argv";
      gitf = "git fetch --prune --recurse-submodules $argv";
      gitl = "git log $argv";
      gitr = "git restore $argv";
      gits = "git status $argv";
      gitv = "git version $argv";
      gcom = "git commit $argv";
      gpul = "git pull $argv";
      gpus = "git push --recurse-submodules=on-demand $argv";
      gsub = "git submodule $argv";

      # Grep Aliases
      grep = "command grep --color=auto $argv";
      egrep = "command egrep --color=auto $argv";
      fgrep = "command fgrep --color=auto $argv";

      # Ripgrep Aliases
      rg = "command rg --color=auto -Suuu $argv";
      erg = "command erg --color=auto $argv";

      # List Directory Aliases
      ls = "lsd $argv";
      ll = "ls -la $argv";
      "l." = "ll -d .*";

    };
  };
}
