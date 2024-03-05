# najawa/.dotfiles

This is a fork of grepsedawk/.dotfiles
This is a configuration/dotfile repository for me to fast track rebuilding my development environment.

## Usage

Remote:
```bash
curl -fsSL https://raw.githubusercontent.com/najawa/.dotfiles/main/install | bash
```

Local:
```bash
chmox +x install
./install
```

## Included

TODO

## "Try it before you buy it"

This is available via docker for shell/tmux/vim demos

Just run `docker run -it najawa/dotfiles`


## TODO Items

- Update list of included items in this README
- Wire up the directory `setup_scripts` to loop through files and install them on first run. Maybe with a special flag or cli prompts?
- Describe the bin directory and why it is ignored by version control here
    - The short answer is it is something I add to the PATH in order to have a place to add C code I compile myself
