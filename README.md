# Neovim Configuration folder

## Installation

Place this folder or a symlink (ln -a <folder_path> ~/.config/nvim) in config folder of user

Install [Packer](https://github.com/wbthomason/packer.nvim): 

`git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim`

Install [RipGrep](https://github.com/BurntSushi/ripgrep):

 `sudo apt-get install ripgrep`


Open Neovim `nvim .` in any folder and do PackerSynch (`:PackerSync`).

Install LSP servers for languages using Mason (`:Mason`)


## Additional Hints
### Rust

Install rust-analyzer and make sure it is in `$PATH`
