# ![chezmoi logo](https://github.com/twpayne/chezmoi/blob/master/assets/images/logo-144px.svg) My Personal dotfiles with [chezmoi](https://www.chezmoi.io/)

Personal and Opinionated dotfiles managed with [`chezmoi`](https://www.chezmoi.io/) + [`age`](https://github.com/FiloSottile/age)

With chezmoi, I can setup my daily driver in a few minutes on any machine.
It is a great tool for managing dotfiles and keeping them in sync across multiple machines.

```bash
# for truly fresh install of macOS you need to install CommandLineTools first
xcode-select --install

# initialize chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kholisrag

# transitory environments
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot kholisrag

```

## Stack

- [chezmoi](https://www.chezmoi.io/), main tool for managing my personal dotfiles

- [age](https://github.com/FiloSottile/age), for managing secrets with encryptions

- [antidote](https://antidote.sh/) + [use-omz](https://github.com/getantidote/use-omz), for managing zsh plugins

- [oh-my-zsh](https://ohmyz.sh/), for my main zsh framework

- [zdotdir](https://github.com/getantidote/zdotdir/), clean + bundling standard for [antidote](https://antidote.sh/) with [oh-my-zsh](https://ohmyz.sh/) and [zsh](https://www.zsh.org/)

## Notes

- Currently only tested on `macOS`

## Roadmap

- [x] Add support for `macOS`

- [ ] Add support for `linux`

- [ ] Add support for `codespaces` and friends
