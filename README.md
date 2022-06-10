<img src="media/logo.png" alt="Quark logo" width="125" align="right">

# `quark` - atomically jump around
### `quark` is a command-line tool for quickly jumping to directories.

## Getting Started
Add one of the lines below to your shell's config file to get started with `quark`.

ZSH:
```sh
eval "$(quark hook zsh)"
```

Bash:
```sh
eval "$(quark hook bash)"
```

Fish:
```sh
quark hook fish | source
```

**Make sure to restart your shell after adding the hook!**

## Usage
After you have set up `quark`, using it is as easy as one command:
```sh
$ q text
```

With this command, `quark` will fuzz its database for a directory matching `text`.

## Notes
`quark` operates by latching on to a `chpwd` hook or a `$PWD` change in your shell.
This gives the experience over multiple shells.

`quark run` returns the name of the directory it found, so it will not work by itself.
Use one of the lines above to create the `q` command which will `cd` to the found directory.
