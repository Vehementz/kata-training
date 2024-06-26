# Substitution

All `sed` functions are denoted by single characters. Substitution is
one of the most frequently used functions and is marked by `s`.

The format for substitution is

```
s<delimiter><pattern><delimiter><replacement><delimiter><flags>
```

Every substitution command has exactly 3 occurences of a delimiter.
Typically, the delimiter used is `/`, but it can be any character
except space or newline. For readability, it is best to use a
delimiter not found in `<pattern>`.

For this lesson, we'll be working with the `config.json` template
file. Our goal is to use `sed` to substitute keywords with actual
values to generate a hypothetical configuration file. Our config
file uses two keywords: `$NAME` and `$USERNAME`.

Let's start by substituting `$NAME` for your name.

```sh
sed 's/$NAME/Jose Falcon/' config.json
```
```
{
    name: Jose Falcon,
    username: $USERNAME,
    paths: ['/Users/$USERNAME/Desktop', '/Users/$USERNAME/Code'],
}
```

Let's do the same with `$USERNAME`.

```sh
sed 's/$USERNAME/falcon/' config.json
```
```
{
    name: $NAME,
    username: falcon,
    paths: ['/Users/falcon/Desktop', '/Users/$USERNAME/Code'],
}
```

First, notice that $NAME reappears in our output. We aren't modifying
our template file, when we run `sed` so the last invocation does not
persist. We'll address this shortly.

Second, notice that only the first occurence of `$USERNAME` on each
line was replaced. Thus we see the following for `paths`.

```
    paths: ['/Users/falcon/Desktop', '/Users/$USERNAME/Code'],
```


The two command above in the same time 

```sh
sed -e 's/\$USERNAME/falcon/' -e 's/\$NAME/Jose Falcon/' config.json
```


By default, `s` only replaces the first occurence of each match on
each line. We can use the `g` flag to replace all matches on a line.



```sh
sed 's/$USERNAME/falcon/g' config.json
```
```
{
    name: $NAME,
    username: falcon,
    paths: ['/Users/falcon/Desktop', '/Users/falcon/Code'],
}
```

Suppose we want to update our template to change the default user
paths. Instead of `/Users/$USERNAME/` we'd like to put new user paths
at `/Local/User/$USERNAME/`.

```sh
sed 's/\/Users/\/Local\/User/g' config.json
```
```
{
    name: $NAME,
    username: $USERNAME,
    paths: ['/Local/User/$USERNAME/Desktop', '/Local/User/$USERNAME/Code'],
}
```

The command does what we'd like, but it is difficult to read.  When
the pattern or replacement text includes an instance of the delimiting
character it must be escaped with a backslash, thus polluting the
command. To improve readability we can use a different delimiting
character.

```sh
sed 's:/Users:/Local/User:g' config.json
```

Or with underscores,

```sh
sed 's_/Users_/Local/User_g' config.json
```

Both are significantly easier to read and understand.

## Chaining

What if we want to replace to `$NAME` and `$USERNAME` with
a single command?

The `-e` option specifies a string as an 'editing command'.  Until
this point, all of our examples have only used a single editing
command. The `-e` option may be omitted when only one editing command
is specified.

However, multiple editing commands can be specified. Let's chain
together two commands from our previous example.

```sh
sed -e 's/$NAME/Jose Falcon/' -e 's/$USERNAME/falcon/g' config.json
```
```
{
    name: Jose Falcon,
    username: falcon,
    paths: ['/Users/falcon/Desktop', '/Users/falcon/Code'],
}
```

Before processing starts, `sed` compiles all editing commands into a
single form. Commands are applied in the order they are specified.
Commands are applied to every line (note that an addressed command will
still only affect lines for which the address matches). 

Some implementations of `sed` allow `;` to delimit multiple commands.

```sh
sed 's/$NAME/Jose Falcon/;s/$USERNAME/falcon/g' config.json
```

## Special Characters

The `<replacement>` text is not a pattern, but it does support
a few special characters. An `&` character in the replacement text
is replaced by the entire string matching the pattern. Note that
this behaviour can be escaped with `\&`.

Our configuration example is not valid json. First, our substitutions
for `$NAME` and `$USERNAME` should be enclosed in double quotes.
We'll use `sed` to update our configuration file.

```sh
sed 's/$.*NAME/"&"/' config.json
```
```
{
    name: "$NAME",
    username: "$USERNAME",
    paths: ['/Users/"$USERNAME/Desktop', '/Users/$USERNAME"/Code'],
}
```

This is close, but notice the `paths` line. The pattern `$.*NAME` also
matches `$USERNAME/Desktop', '/Users/$USERNAME`. Our replacement text
uses `&` to wrap the entire match in double quotes, which isn't
correct. We can tighten our regular expression with an anchor.

```sh
sed 's/$.*NAME,$/"&"/' config.json
```
```
{
    name: "$NAME,"
    username: "$USERNAME,"
    paths: ['/Users/$USERNAME/Desktop', '/Users/$USERNAME/Code'],
}
```

The `$` at the end of our pattern specifies the 'end-of-line anchor'.
This fixes the issue with `paths` but introduces a new problem: the
`,` falls within the double quotes. Basic Regular Expressions support
grouping with `\(` and `\)`. We can reference these 'capturing' groups
with back references in our replacement text.

```sh
sed 's/\($.*NAME\),$/"\1",/' config.json
```
```
{
    name: "$NAME",
    username: "$USERNAME",
    paths: ['/Users/$USERNAME/Desktop', '/Users/$USERNAME/Code'],
}
```

Back references are specified by `\n` where `n` is a digit. In this
case, we capture everything but the `,` and anchor, and rewrite the
expression in our replacement text.

### Practice

Our configuration keys also need to be enclosed with double quotes.
Write a `sed` command for wrapping keys with double quotes.

## Flags

There are four possible flags for substitute.

The global flag, `g`, substitutes **all** matches of pattern. We saw
an example of using the `g` flag in our `config.json` example.

If there is a specific occurence of the pattern you'd like to replace,
use a single digit.

```sh
sed 's/$USERNAME/falcon/2' config.json
```
```
{
    name: $NAME,
    username: $USERNAME,
    paths: ['/Users/$USERNAME/Desktop', '/Users/falcon/Code'],
}
```

Notice that only one occurence of $USERNAME is replaced. If there is
only one occurence of the pattern on a line (as in line 3), and the
number specified exceeds 1, no substitution occurs.

Recall our print function `p`. We can use a `p` flag with substitute to
print the pattern space if and only if a replacement was made.

```sh
sed -n 's/$USERNAME/falcon/2p' config.json
```
```
    paths: ['/Users/$USERNAME/Desktop', '/Users/falcon/Code'],
```

We use the `-n` option again to silence printing. The `p` flag at the
end of our command specifies when to print.

The last flag, `w`, functions like `p`, but writes to a file. If the
given file exists, it is overwritten, otherwise it is created.

```sh
sed 's/$USERNAME/falcon/gw /tmp/changes.txt' config.json
```
```sh
cat /tmp/changes.txt
```
```
    username: falcon,
    paths: ['/Users/falcon/Desktop', '/Users/falcon/Code'],
```

## Addresses

`sed` supports extended regular expressions with the `-E` option.
TODO: Go over differences? Perhaps there should be a lesson
TODO: on writing BRE and ERE


```sh
sed -E 's/\$(USER)?NAME/"&"/' config.json
```
```
{
    name: "$NAME",
    username: "$USERNAME",
    paths: ['/Users/"$USERNAME"/Desktop', '/Users/$USERNAME/Code'],
}
```

As in our previous example, this command modifies `paths`.
We can use a context address for conditional application.
We'd like to apply the command for all lines except `paths`.
Recall that addressess can be 'negated' with '!'.

```sh
sed -E '/paths/! s/\$(USER)?NAME/"&"/' config.json
```
```
{
    name: "$NAME",
    username: "$USERNAME",
    paths: ['/Users/$USERNAME/Desktop', '/Users/$USERNAME/Code'],
}
```