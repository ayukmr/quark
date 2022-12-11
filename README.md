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
After you have set up `quark`, use it using the `q` command:
```sh
$ q text
```

With this command, `quark` will fuzz its database for a directory matching `text`.

## Notes
`quark` operates by latching on to a `chpwd` hook or a `$PWD` change in your shell.
This gives it the best experience over multiple shells.

`quark run` returns the name of the directory it found, so it will not work by itself.
Use one of the lines above to create the `q` command which will `cd` into the found directory.
