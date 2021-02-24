# webster-cli

A command-line tool for generating a PDF file from a URL (rendered by WebKit).

## Example

```
$> swift build
[3/3] Linking webster-cli

> ./.build/debug/webster-cli -h
USAGE: webster-cli <source> <destination> [--dpi <dpi>] [--width <width>] [--height <height>] [--margin <margin>] [--bleed <bleed>]

ARGUMENTS:
  <source>                The URL you want to generate a PDF from. 
  <destination>           The path where your PDF document will be created. 

OPTIONS:
  --dpi <dpi>             The DPI (dots per inch) of your output document. (default: 72.0)
  --width <width>         The width (in inches) of your document. (default: 8.5)
  --height <height>       The height (in inches) of your document. (default: 11.0)
  --margin <margin>       The margin (in inches) for each page in your document. (default: 1.0)
  --bleed <bleed>         The bleed (in inches) for each page in your document. (default: 0.0)
  -h, --help              Show help information.
```  

## Credits

This build's on @msmollin's original [webster](https://github.com/msmollin/webster) and currently exists as a separate project because it is full of Swift Package Manager -isms and I am not sure what the best way to create a PR is yet.

## See also

* https://github.com/aaronland/swift-webster