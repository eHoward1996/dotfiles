import sys
import os

def main():
    colors = sys.argv[1:]
    colorMap = {}

    for c in range(len(colors)):
        colorMap[c] = colors[c]

    initialString = """/* global settings and color variables */
    * {{
        highlight:        bold {0};
        urgentcolor:      {1};
        fgwhite:          {8};
        blackdarkest:     {3};
        blackwidget:      {4};
        blackentry:       {5};
        blackselect:      {6};
        darkgray:         {7};
        scrollbarcolor:   {8};
        font: "SFNS Display Bold 16";
        background-color: @blackdarkest;
    }}\n\n""".format(
        colorMap[0], colorMap[1], colorMap[2],
        colorMap[3], colorMap[4], colorMap[5],
        colorMap[6], colorMap[7], colorMap[8],
    )

    f = open(os.path.expanduser('~/.config/rofi/rofi-theme.rasi'), 'w+')
    f.write(initialString)

if __name__ == '__main__':
    main()