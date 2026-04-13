extends Node

class NationColor:
	var primary: Color
	var secondary: Color
	func _init(p: Color, s: Color) -> void:
		primary = p
		secondary = s

# Nations that have qualified for at least one UEFA Euro or FIFA World Cup (2004–2024)
# Colors are approximations using Godot named Color constants
var NationColors: Dictionary[String, NationColor] = {
	# Europe
	"Germany":          NationColor.new(Color.WHITE,     Color.BLACK),
	"France":           NationColor.new(Color.BLUE,      Color.WHITE),
	"Spain":            NationColor.new(Color.RED,       Color.GOLD),
	"Italy":            NationColor.new(Color.DARK_BLUE, Color.WHITE),
	"England":          NationColor.new(Color.WHITE,     Color.RED),
	"Netherlands":      NationColor.new(Color.ORANGE,    Color.WHITE),
	"Portugal":         NationColor.new(Color.RED,       Color.GREEN),
	"Belgium":          NationColor.new(Color.RED,       Color.BLACK),
	"Croatia":          NationColor.new(Color.RED,       Color.WHITE),
	"Poland":           NationColor.new(Color.WHITE,     Color.RED),
	"Denmark":          NationColor.new(Color.RED,       Color.WHITE),
	"Sweden":           NationColor.new(Color.YELLOW,    Color.BLUE),
	"Switzerland":      NationColor.new(Color.RED,       Color.WHITE),
	"Czech Republic":   NationColor.new(Color.RED,       Color.WHITE),
	"Turkey":           NationColor.new(Color.RED,       Color.WHITE),
	"Greece":           NationColor.new(Color.WHITE,     Color.BLUE),
	"Ukraine":          NationColor.new(Color.YELLOW,    Color.BLUE),
	"Russia":           NationColor.new(Color.RED,       Color.WHITE),
	"Serbia":           NationColor.new(Color.RED,       Color.BLUE),
	"Hungary":          NationColor.new(Color.RED,       Color.WHITE),
	"Romania":          NationColor.new(Color.YELLOW,    Color.BLUE),
	"Slovakia":         NationColor.new(Color.BLUE,      Color.WHITE),
	"Slovenia":         NationColor.new(Color.WHITE,     Color.BLUE),
	"Austria":          NationColor.new(Color.RED,       Color.WHITE),
	"Bulgaria":         NationColor.new(Color.WHITE,     Color.GREEN),
	"Iceland":          NationColor.new(Color.BLUE,      Color.WHITE),
	"Wales":            NationColor.new(Color.RED,       Color.WHITE),
	"Scotland":         NationColor.new(Color.DARK_BLUE, Color.WHITE),
	"Northern Ireland": NationColor.new(Color.GREEN,     Color.WHITE),
	"Ireland":          NationColor.new(Color.GREEN,     Color.WHITE),
	"Albania":          NationColor.new(Color.RED,       Color.BLACK),
	"Bosnia":           NationColor.new(Color.BLUE,      Color.YELLOW),
	"Montenegro":       NationColor.new(Color.RED,       Color.GOLD),
	"North Macedonia":  NationColor.new(Color.RED,       Color.YELLOW),
	"Finland":          NationColor.new(Color.WHITE,     Color.BLUE),
	"Georgia":          NationColor.new(Color.WHITE,     Color.RED),
	"Armenia":          NationColor.new(Color.RED,       Color.BLUE),
	# South America
	"Brazil":           NationColor.new(Color.YELLOW,    Color.GREEN),
	"Argentina":        NationColor.new(Color.CYAN,      Color.WHITE),
	"Uruguay":          NationColor.new(Color.CYAN,      Color.WHITE),
	"Colombia":         NationColor.new(Color.YELLOW,    Color.BLUE),
	"Chile":            NationColor.new(Color.RED,       Color.WHITE),
	"Ecuador":          NationColor.new(Color.YELLOW,    Color.BLUE),
	"Peru":             NationColor.new(Color.WHITE,     Color.RED),
	"Paraguay":         NationColor.new(Color.RED,       Color.WHITE),
	"Bolivia":          NationColor.new(Color.GREEN,     Color.RED),
	# North/Central America
	"Mexico":           NationColor.new(Color.GREEN,     Color.RED),
	"USA":              NationColor.new(Color.WHITE,     Color.BLUE),
	"Canada":           NationColor.new(Color.RED,       Color.WHITE),
	"Costa Rica":       NationColor.new(Color.RED,       Color.BLUE),
	"Honduras":         NationColor.new(Color.BLUE,      Color.WHITE),
	"Panama":           NationColor.new(Color.RED,       Color.WHITE),
	"El Salvador":      NationColor.new(Color.BLUE,      Color.WHITE),
	"Trinidad & Tobago":NationColor.new(Color.RED,       Color.BLACK),
	"Jamaica":          NationColor.new(Color.YELLOW,    Color.BLACK),
	"Haiti":            NationColor.new(Color.BLUE,      Color.RED),
	# Asia
	"Japan":            NationColor.new(Color.DARK_BLUE, Color.WHITE),
	"South Korea":      NationColor.new(Color.RED,       Color.WHITE),
	"Iran":             NationColor.new(Color.WHITE,     Color.GREEN),
	"Saudi Arabia":     NationColor.new(Color.GREEN,     Color.WHITE),
	"Australia":        NationColor.new(Color.GOLD,      Color.GREEN),
	"Qatar":            NationColor.new(Color.PURPLE,    Color.WHITE),
	"Iraq":             NationColor.new(Color.GREEN,     Color.WHITE),
	"Jordan":           NationColor.new(Color.WHITE,     Color.RED),
	# Africa
	"Nigeria":          NationColor.new(Color.GREEN,     Color.WHITE),
	"Senegal":          NationColor.new(Color.WHITE,     Color.GREEN),
	"Morocco":          NationColor.new(Color.RED,       Color.GREEN),
	"Ghana":            NationColor.new(Color.WHITE,     Color.BLACK),
	"Cameroon":         NationColor.new(Color.GREEN,     Color.RED),
	"Ivory Coast":      NationColor.new(Color.ORANGE,    Color.WHITE),
	"Algeria":          NationColor.new(Color.WHITE,     Color.GREEN),
	"Tunisia":          NationColor.new(Color.RED,       Color.WHITE),
	"Egypt":            NationColor.new(Color.RED,       Color.WHITE),
	"South Africa":     NationColor.new(Color.GOLD,      Color.GREEN),
	"Angola":           NationColor.new(Color.RED,       Color.BLACK),
	"Mali":             NationColor.new(Color.GREEN,     Color.YELLOW),
	"Togo":             NationColor.new(Color.GREEN,     Color.YELLOW),
	"New Zealand":      NationColor.new(Color.WHITE,     Color.BLACK),
}

var NationsList: Array[String] = NationColors.keys()

func _ready() -> void:
	NationsList.sort()
