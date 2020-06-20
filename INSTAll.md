## Install

1. Install Gawk 
   - For instructions on that, see [here](https://github.com/golden/dev/blob/master/.travis.yml).
2. Download GOLD via
   - `curl -o en https://raw.githubusercontent.com/golden/gold/master/en`
   - or, if you are a Github user,  `git clone http://github.com/golden/gold`
3. Set up and test:

```
sh en
./d
```

The `./d` runs the unit
tests in `src/gold` directory.
In that run, there should only be on failing test (which is a test that the tests can
  catch a failing test).

## Advanced Install

For those that use Git or travis CI or vim or tmux, there is a little more support
(and note that the `-e`, `-t` flags won't work unless you first run `en -I`): 

- `. en -I`: advanced install tricks
   - ensure that `./.gitignore` file exists that  knows how ignore `*.awk` files
   - ensure that `./.travis.yml` file exists
   - ensure that `./.vimrc` file exists
   - ensure that `./.tmux.conf' file exists
   - adds some useful alias to the local envrionment (`gg` = git pull; `gp`= git commit, the pusn, then status.)
- `en -e`: 
   - edit a file using vim, tuned to GOLD files
- `en -t`: run tmux
   - run `tmux`

