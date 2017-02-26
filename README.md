# Pure.fish

A [Pure][pure]-inspired prompt for [fish shell][fish]. It’s very similar to Pure, but not identical—it’s not intended to have feature parity.

![Screenshot of Pure.fish](https://cloud.githubusercontent.com/assets/4727/9908269/cc5a20d8-5c47-11e5-8cb9-4d45378a60f3.png)

* A clean, beautiful, and minimal prompt
* The perfect prompt character. [Sindre Sorhus][sindre] went through the entire unicode range to find it. 
* Takes up two lines with a blank space preceding it. At first I thought this was weird but now I can’t imagine going back.
* Shows the working directory
* Shows the current git branch or revision
* Shows up/down arrows if you have unpushed/unpulled commits
* The prompt character turns red if the last command’s exit status is 1
* Shows the command duration

## Installation

fish doesn’t have any kind of plugin system so you just have to [download the file](https://raw.githubusercontent.com/funnell/pure.fish/master/fish_prompt.fish) and save it as `~/.config/fish/functions/fish_prompt.fish`.

Here’s a one-liner you can run.

```shell
curl https://raw.githubusercontent.com/funnell/pure.fish/master/fish_prompt.fish > ~/.config/fish/functions/fish_prompt.fish
```

To make it easier to update you can clone this repo and then symlink the prompt into place.

```shell
git clone https://github.com/funnell/pure.fish.git
ln -s ./pure.fish/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
```

[pure]: https://github.com/sindresorhus/pure
[fish]: http://fishshell.com
[sindre]: https://github.com/sindresorhus
