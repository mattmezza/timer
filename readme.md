timer
===

`timer` is a utility to quickly start a timer without leaving the terminal. Thanks to `terminal-notifier` it also supports notification so that you are aware when time elapses.

![](timer.gif)



Installation
===

You can download the latest verions of `timer` (via this repository) and you can then source the `timer.sh` file in your bash profile. You can see an example of how I did it in my [dotfiles](https://github.com/mattmezza/dotfiles) (see plugins.sh and plugins.txt).

```bash
git clone --branch 1.0.0 git@github.com/mattmezza/timer.git timer && source timer/timer
```

`timer` should be compatible with any *nix OS but it has been tested with macOS Big Sur (and the prev version).


Dependencies
===

`timer` depends on [terminal-notifier](https://github.com/julienXX/terminal-notifier). `timer` automatically installs this dependency via `brew install terminal-notifier` if it cannot find it installed on your system.
Of course, you need to have `brew` installed.

Usage
===
```
Usage:
  $ ./timer 'Message' [OPTIONS]
Options:
  -M|--msg|--message
  -h|--hours:                 specifies the amount in hours
  -m|--minutes:               specifies the amount in minutes
  -s|--seconds:               specifies the amount in seconds
  -T|--title
  -t|--subtitle
  -o|--open:                  optional URL to open when clicking
  -i|--ignore-do-not-disturb: ignores DnD and awakes\!
  -a|--audio:                 whether or not to have the 'bling'
E.g.:
  $ ./timer -h 0 -m 0 -s 5 'Text'  # timer elapsing in 5sec
  $ ./timer -h 0 -m 30 'Text'  # timer elapsing in 30min
  $ ./timer --audio -m 1 'Text'  # timer with audio feedback

```
`timer` can be used also from `stdin` with a pipe: `echo "Message" | timer -i`. In case you also specify a message, the CLI option will prevail.


Development
===

Developing this utility is quite easy: just clone this repo and start editing the `timer.sh` file.
