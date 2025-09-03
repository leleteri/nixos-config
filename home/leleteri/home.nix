{ config, pkgs, ... }:

{

	home.username = "leleteri";
	home.homeDirectory = "/home/leleteri";

	home.stateVersion = "25.05-pre";

	program.zsh.enable = true;

	programs.git = 
	{
		enable = true;
		userName = "leleteri";
		userEmail =  "229750936+leleteri@users.noreply.github.com";
	};

	home.packages = with pkgs;
	[
		librewolf
		zoom-us
		tor-browser
	];

}