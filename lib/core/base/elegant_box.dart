//Models
// ┌─┬─┐  ╔═╦═╗  ╓─╥─╖  ╒═╤═╕  ╭─┬─╮
// │ │ │  ║ ║ ║  ║ ║ ║  │ │ │  │ │ │
// ├─┼─┤  ╠═╬═╣  ╟─╫─╢  ╞═╪═╡  ├─┼─┤
// └─┴─┘  ╚═╩═╝  ╙─╨─╜  ╘═╧═╛  ╰─┴─╯
// ┌───────────────────┐
// │  ╔═══╗ Some Text  │▒
// │  ╚═╦═╝ in the box │▒
// ╞═╤══╩══╤═══════════╡▒
// │ ├──┬──┤           │▒
// │ └──┴──┘           │▒
// └───────────────────┘▒
//  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
class ElegantBox {
  //Rect simple
  static const topLeft = '┌';
  static const topRight = '┐';
  static const bottomLeft = '└';
  static const bottomRight = '┘';

  //Rect double
  static const topLeftDouble = '╔';
  static const topRightDouble = '╗';
  static const bottomLeftDouble = '╚';
  static const bottomRightDouble = '╝';

  //Rounded
  static const topLeftArc = '╭';
  static const topRightArc = '╮';
  static const bottomLeftArc = '╰';
  static const bottomRightArc = '╯';

  //Single common
  static const verticalLine = '│';
  static const middleLeft = '├';
  static const middleRight = '┤';
  static const middleTop = '┰';
  static const middleBottom = '┸';
  static const cross = '┼';
  static const line = '─';
  static const dashedRight = '╶';
  static const dashedLeft = '╴';

  //Double common
  static const verticalLineDouble = '║';
  static const middleLeftDouble = '╟';
  static const middleRightDouble = '╢';
  static const middleTopDouble = '╦';
  static const middleBottomDouble = '╩';
  static const crossDouble = '╬';
  static const lineDouble = '═';

  //Mixed common
  static const dashedUp = '╵';
  static const dashedDown = '╷';
  static const middleLeftMix = '╞';
  static const middleRightMix = '╡';
  static const crossHorizontalDouble = '╪';
  static const crossVerticalDouble = '╫';

  //Blocks
  static const blockLightShade = '░';
  static const blockMediumShade = '▒';
  static const blockDarkShade = '▓';
  static const noEmoji = '☐';
}
