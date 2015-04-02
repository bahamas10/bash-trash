bash-trash
============

Instead of `rm`'ing files into the void, put them in your trash/recycle bin

Installation
------------

### bics

Use [bics](https://github.com/bahamas10/bics) to manage this plugin

After installing `bics`, install this plugin by running

    bics install git://github.com/bahamas10/bash-trash.git

### manual

Add the code to your `~/.bashrc`

Usage
-----

Instead of using `rm`, you can just use the function `trash`.  Running `trash` without
arguments shows an overview of the current trash directory.

```
$ trash
/Users/dave/.Trash: trash is empty
```

We can see that the trash directory (`$TRASH_DIR`) is empty, let's trash some files

```
$ trash fileA fileB fileC
$ trash
8.0K    /Users/dave/.Trash/fileA
8.0K    /Users/dave/.Trash/fileB
8.0K    /Users/dave/.Trash/fileC
 24K    total
```

The overview present by `trash` shows file sizes as well as a grand total (via `du`)

Unlike `rm`, you can `trash` directories just like you would with files, as the underlying command
used to do this is `mv`.

```
$ mkdir dirA dirB dirC
$ trash dirA dirB dirC
$ trash
  0B    /Users/dave/.Trash/dirA
  0B    /Users/dave/.Trash/dirB
  0B    /Users/dave/.Trash/dirC
8.0K    /Users/dave/.Trash/fileA
8.0K    /Users/dave/.Trash/fileB
8.0K    /Users/dave/.Trash/fileC
 24K    total
```

If you `trash` a file with the same name as a file already in the `trash`, it is
given a unique name (similar to how a browser handles downloading multiple files of the same name).

```
$ touch fileA
$ trash fileA
$ trash
  0B    /Users/dave/.Trash/dirA
  0B    /Users/dave/.Trash/dirB
  0B    /Users/dave/.Trash/dirC
8.0K    /Users/dave/.Trash/fileA
  0B    /Users/dave/.Trash/fileA.1
8.0K    /Users/dave/.Trash/fileB
8.0K    /Users/dave/.Trash/fileC
 24K    total
```

And finally, to really remove the data, simply empty the trash

```
$ emptytrash
$ trash
/Users/dave/.Trash: trash is empty
```

Also, consider adding something like this to your `~/.bashrc`

``` bash
alias rm=trash
```

Exports
-------

### Global Variables

- `TRASH_DIR` - the dir to use as trash, defaults to `~/.Trash` (OS X default)

### Environmental Variables

None

### Functions

- `trash` - command use to view the trash, or trash files/directories
- `emptytrash` - simple function to effectively run `rm -rf "$TRASH_DIR"/*`
- `_bash_trash_is_empty` - (private) determines if the trash is empty

### Aliases

None

License
-------

MIT
