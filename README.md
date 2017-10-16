# vim-foldfocus #

## What is it? ##

A plugin that extracts the text from the current fold level and outputs it into a new temporary buffer.

The ideia behind this plugin is to separate a specific piece of code in to its own context (buffer). This is useful when you are trying to understand a particular messy piece of code, and you want to be able to search words using ```/```, ```*```, ```#``` without leaving the context of the code that you are exploring.

Also, if you do change anything in the temp buffer, those changes will automatically be syncronized with the original buffer.

## Installation ##

Using vundle, add this to your .vimrc:

```
Bundle 'lfv89/vim-foldfocus'
```

Than run:

```
:BundleInstall
```

## Usage ##

All you have to do is to map the function to a key of your choice.

If you want to focus in place, use:

```vimscript
nmap <CR> :call FoldFocus('e')<CR>
```

In this case, you can hit ```q``` to leave the temporary buffer and get
back to the original one.

If you want to focus in a side buffer, use:

```vimscript
nmap <Leader><CR> :call FoldFocus('vnew')<CR>
```

Of course, you are free to change the mapping to use whatever keys you want.

## Me

[luisvasconcellos.com](http://www.luisvasconcellos.com)

Feel free to talk to me about anything related to this project.
