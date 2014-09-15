# Rptynan's Dotfiles

Dotfiles I have used and tweaked for the past couple of years. They're simple
and optimized for a 13" laptop and somewhat stolen from @Sirupsen.

## Setup

<table>
  <tr>
    <th>Hardware</th>
    <th>Terminal</th>
    <th>Shell</th>
    <th>Editor</th>
    <th>Version control</th>
    <th>Window Manager</th>
    <th>Font</th>
  </tr>
  <tr>
    <td>Dell Xps 13</td>
    <td>URxvt</td>
    <td>zsh with <a href="https://github.com/sorin-ionescu/prezto">prezto</a></td>
    <td>vim</td>
    <td>git</td>
    <td>i3</td>
    <td><a href="http://www.levien.com/type/myfonts/inconsolata.html">Inconsolata</a></td>
  </tr>
</table>

## Installing

`linker.sh` will symlink all files the files in `home` to your actual home directory. Invoke it to symlink the dotfiles. It will prompt to override if the files already exist.

`install.sh` takes the list of packages from `notes/packagelist` and installs any which are available from the official Arch Linux repos with pacman. It then will symlink any files in `bin` to `/usr/local/bin` (which is in your `PATH`). The script prompts for both.

## Directories

- `bin` and `home` are as said above.
- `notes` contains some information on my setup.
- `configs` are config files for different packages in linux which I've heavily editted and aren't kept in my home directory.
