# Quick and dirty guide to using tmux for shells

##### INTERNAL ONLY
##### Created date: 10.09.15
##### Authors: Davy Jones (TS)

--------

## 1. What is tmux?

tmux is a terminal multiplexer!

## 2. What is a terminal multiplexer?

It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal.

Effectively a shell within a shell. Or a Ghost in the shell?

## 3. Why should I care?

Say you are SSH'd into a box and want to run a process that you know will have to run for a long time and you do not want to get interuppted by say your SSH session closing. Then you are going to want to run a tmux session once you are SSH'd into a box so that the process is owned by a service that is local.

You can do much more with tmux than this, have a read of the docs to see if it's of use!

## 4. How to set up tmux

- Install tmux:
  - `sudo apt-get update && sudo apt-get install tmux`
- Create a new tmux session:
  - `tmux new -s nameofsession`
  - we name the session for ease of reference
- Run the command you require
- Detach from session:
  - `<ctrl>+b :detach <enter>`
  - Press ctrl+b then a colon and type detach and press enter
- You are now free to close your ssh session.

## 5. How to reattach to a running tmux session

- SSH into box
- Attach to running session:
  - `tmux attach -t nameofsession`

## 6. References

[tmux Home Page](https://tmux.github.io/)
[tmux Cheat Sheet](https://gist.github.com/MohamedAlaa/2961058)
