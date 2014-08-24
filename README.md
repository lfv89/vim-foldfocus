# vim-foldfocus #

## What is it? ##

Foldfocus is a vim plugin that extracts the text from the current fold level and outputs it into a new temporary buffer.

The ideia behind this plugin is to separate a specific piece of code in to its own context (buffer). This is useful when you are trying to a particular messy piece of code, and you want to be able to search words using ```/```, ```*```, ```#``` without leaving the context of the code that you are exploring.

## Screengifs ##

In place focus:
![Screenshot](images/ff2.gif)

Side buffer focus:
![Screenshot](images/ff3.gif)

## Installation ##

Using vundle, add this to your .vimrc:

```
Bundle 'vasconcelloslf/vim-foldfocus'
```

Than run:

```
:BundleInstall
```

## Usage ##

All you have to do is to map the function to a key of your choice.

If you want to focus in place, use:

```vimscript
map <Leader>ff :call FoldFocus('e')<CR>
```

If you want to focus in a side buffer, use:

```vimscript
map <Leader>ff :call FoldFocus('vnew')<CR>
```

## About

Follow-me! [@vasconcelloslf](http://twitter.com/vasconcelloslf)

[http://luisvasconcellos.com](http://www.luisvasconcellos.com)
