extends Node

var planet_1 : Dictionary = {
	"id" = 1, 
	"name" = "Name",
	"density" = 1.2, #Valor original es 1.2
	"density_factor" = 0.25, #Factor por el que se reduce en cada capa la densidad del aire
	"temp_factor" = 6.5, #Factor por el que se reduce en cada capa la temperatura
	"temp" = 20, #Valor original es 1. Menor temperatura, mejor empuje pero menos escudo y fallo de armas. Mayor temperatura, peor empuje y recibe daño continuo
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/Planeta azul claro.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA AZUL CLARO XL.png"), 
	"parallaxID" = null
}

var planet_2 : Dictionary = {
	"id" = 2, 
	"name" = "Name",
	"density" = 2,
	"density_factor" = 0.25,
	"temp_factor" = 2.43,
	"temp" = -73,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/planeta azul.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA AZUL XL.png"), 
	"parallaxID" = null
}

var planet_3 : Dictionary = {
	"id" = 3, 
	"name" = "Name",
	"density" = 0.5,
	"density_factor" = 0.25,
	"temp_factor" = 1.76,
	"temp" = -137,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/planeta blanco.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA BLANCO XL.png"), 
	"parallaxID" = null
}

var planet_4 : Dictionary = {
	"id" = 4, 
	"name" = "Name",
	"density" = 3.5,
	"density_factor" = 0.05,
	"temp_factor" = 75.8,
	"temp" = 583,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/Sol Amarillo.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/SOL AMARILLO XL.png"), 
	"parallaxID" = null
}

var planet_5 : Dictionary = {
	"id" = 5, 
	"name" = "Name",
	"density" = 2.75,
	"density_factor" = 0.08,
	"temp_factor" = 55,
	"temp" = 414,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/sol rojo.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/SOL ROJO XL.png"), 
	"parallaxID" = null
}

var helia : Dictionary = {
	"id" = 1, 
	"name" = "Helia",
	"surface_type" = "Solid",
	"density" = 0.45, 
	"density_factor" = 0.28,
	"temp_factor" = 1.2, 
	"temp" = -147, 
	"tier" = 0,
	"texture_region" = {"x" : 0, "w": 800, "y" : 0, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var zele : Dictionary = {
	"id" = 2, 
	"name" = "Zele",
	"surface_type" = "Liquid",
	"density" = 2.03, 
	"density_factor" = 1.1,
	"temp_factor" = 1.1, 
	"temp" = 85, 
	"tier" = 1,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 0, "h" : 800},
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var andra : Dictionary = {
	"id" = 3, 
	"name" = "Andra",
	"surface_type" = "Liquid",
	"density" = 0.66, 
	"density_factor" = 0.14,
	"temp_factor" = 7, 
	"temp" = -35, 
	"tier" = 0,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 0, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var terra : Dictionary = {
	"id" = 4, 
	"name" = "Tærra",
	"surface_type" = "Solid",
	"density" = 1.2, 
	"density_factor" = 0.25,
	"temp_factor" = 6.5, 
	"temp" = 25, 
	"tier" = 1,
	"texture_region" = {"x" : 4000, "w": 800, "y" : 0, "h" : 800},
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var solovei : Dictionary = {
	"id" = 5, 
	"name" = "Solovei",
	"surface_type" = "Solid",
	"density" = 0.71, 
	"density_factor" = 0.1,
	"temp_factor" = 0.03, 
	"temp" = -16, 
	"tier" = 0,
	"texture_region" = {"x" : 0, "w": 800, "y" : 800, "h" : 800},
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var wedi : Dictionary = {
	"id" = 6, 
	"name" = "Wedi",
	"surface_type" = "Gas",
	"density" = 2.58, 
	"density_factor" = 0.4,
	"temp_factor" = 3.2, 
	"temp" = 38, 
	"tier" = 2,
	"texture_region" = {"x" : 800, "w": 800, "y" : 800, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var enil : Dictionary = {
	"id" = 7, 
	"name" = "Enil",
	"surface_type" = "Liquid",
	"density" = 1.42, 
	"density_factor" = 0.13,
	"temp_factor" = 3.2, 
	"temp" = -5, 
	"tier" = 1,
	"texture_region" = {"x" : 1600, "w": 800, "y" : 800, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var vina : Dictionary = {
	"id" = 8, 
	"name" = "Vina",
	"surface_type" = "Solid",
	"density" = 1.9, 
	"density_factor" = 0.33,
	"temp_factor" = 10.7, 
	"temp" = 93, 
	"tier" = 2,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 800, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1.62,
	"button_scale" =  0.55,
	"distance_star" = null,
	"parallaxID" = null
}

var trano : Dictionary = {
	"id" = 9, 
	"name" = "Trano",
	"surface_type" = "Gas",
	"density" = 4.1, 
	"density_factor" = 0.33,
	"temp_factor" = 10.7, 
	"temp" = 309, 
	"tier" = 5,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 800, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var qetesh : Dictionary = {
	"id" = 10, 
	"name" = "Qetesh",
	"surface_type" = "Gas",
	"density" = 3.7, 
	"density_factor" = 0.21,
	"temp_factor" = 9.2, 
	"temp" = 288, 
	"tier" = 5,
	"texture_region" = {"x" : 4000, "w": 800, "y" : 800, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1.32,
	"button_scale" =  0.67,
	"distance_star" = null,
	"parallaxID" = null
}

var tyoph : Dictionary = {
	"id" = 11, 
	"name" = "Tyoph",
	"surface_type" = "Gas",
	"density" = 2, 
	"density_factor" = 0.03,
	"temp_factor" = 11.5, 
	"temp" = 149, 
	"tier" = 3,
	"texture_region" = {"x" : 0, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var iriscia : Dictionary = {
	"id" = 12, 
	"name" = "Iriscia",
	"surface_type" = "Solid",
	"density" = 0.87, 
	"density_factor" = 0.21,
	"temp_factor" = 11, 
	"temp" = -131, 
	"tier" = 1,
	"texture_region" = {"x" : 800, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var auder : Dictionary = {
	"id" = 13, 
	"name" = "Auder",
	"surface_type" = "Solid",
	"density" = 1.3, 
	"density_factor" = 0.21,
	"temp_factor" = 2.2, 
	"temp" = 32, 
	"tier" = 2,
	"texture_region" = {"x" : 1600, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var trada : Dictionary = {
	"id" = 14, 
	"name" = "Trada",
	"surface_type" = "Solid",
	"density" = 0.9, 
	"density_factor" = 0.3,
	"temp_factor" = 4.3, 
	"temp" = 22, 
	"tier" = 1,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var ilmare : Dictionary = {
	"id" = 15, 
	"name" = "Ilmare",
	"surface_type" = "Solid",
	"density" = 0.78, 
	"density_factor" = 0.23,
	"temp_factor" = 5, 
	"temp" = 17, 
	"tier" = 1,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var lachesis : Dictionary = {
	"id" = 16, 
	"name" = "Lachesis",
	"surface_type" = "Gas",
	"density" = 1.67, 
	"density_factor" = 0.18,
	"temp_factor" = 14, 
	"temp" = 103, 
	"tier" = 4,
	"texture_region" = {"x" : 4000, "w": 800, "y" : 1600, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var apep : Dictionary = {
	"id" = 17, 
	"name" = "Apep",
	"surface_type" = "Solid",
	"density" = 0.31, 
	"density_factor" = 0.07,
	"temp_factor" = 3, 
	"temp" = -201, 
	"tier" = 1,
	"texture_region" = {"x" : 0, "w": 800, "y" : 2400, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var lanthee : Dictionary = {
	"id" = 18, 
	"name" = "Lanthee",
	"surface_type" = "Liquid",
	"density" = 2.93, 
	"density_factor" = 0.55,
	"temp_factor" = 21, 
	"temp" = 332, 
	"tier" = 5,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 2400, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  1,
	"distance_star" = null,
	"parallaxID" = null
}

var glia : Dictionary = {
	"id" = 19, 
	"name" = "Glia",
	"surface_type" = "Solid",
	"density" = 3.21, 
	"density_factor" = 0.7,
	"temp_factor" = 13, 
	"temp" = 64, 
	"tier" = 4,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 2400, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var kaniea : Dictionary = {
	"id" = 20, 
	"name" = "Kaniea",
	"surface_type" = "Solid",
	"density" = 3.89, 
	"density_factor" = 1,
	"temp_factor" = 13, 
	"temp" = 374, 
	"tier" = 5,
	"texture_region" = {"x" : 4000, "w": 800, "y" : 2400, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var baugi : Dictionary = {
	"id" = 21, 
	"name" = "Baugi",
	"surface_type" = "Solid",
	"density" = 0.23, 
	"density_factor" = 0.02,
	"temp_factor" = 2, 
	"temp" = -214, 
	"tier" = 1,
	"texture_region" = {"x" : 0, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1.31,
	"button_scale" =  0.67,
	"distance_star" = null,
	"parallaxID" = null
}

var xihe : Dictionary = {
	"id" = 22, 
	"name" = "Xihe",
	"surface_type" = "Liquid",
	"density" = 0.57, 
	"density_factor" = 0.02,
	"temp_factor" = 3.7, 
	"temp" = -81, 
	"tier" = 1,
	"texture_region" = {"x" : 800, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var alyosha : Dictionary = {
	"id" = 23, 
	"name" = "Alyosha",
	"surface_type" = "Solid",
	"density" = 2.04, 
	"density_factor" = 0.23,
	"temp_factor" = 19, 
	"temp" = 12, 
	"tier" = 2,
	"texture_region" = {"x" : 1600, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 0.67,
	"button_scale" =  1.3,
	"distance_star" = null,
	"parallaxID" = null
}

var gethee : Dictionary = {
	"id" = 24, 
	"name" = "Gethee",
	"surface_type" = "Gas",
	"density" = 0.93, 
	"density_factor" = 0.27,
	"temp_factor" = 19,
	"temp" = 197, 
	"tier" = 3,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var nosu : Dictionary = {
	"id" = 25, 
	"name" = "Nosu",
	"surface_type" = "Liquid",
	"density" = 1.85, 
	"density_factor" = 0.2,
	"temp_factor" = 22,
	"temp" = 271, 
	"tier" = 4,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 0.68,
	"button_scale" =  1.3,
	"distance_star" = null,
	"parallaxID" = null
}

var irra : Dictionary = {
	"id" = 26, 
	"name" = "Irra",
	"surface_type" = "Solid",
	"density" = 0.31, 
	"density_factor" = 0.1,
	"temp_factor" = 14,
	"temp" = -82, 
	"tier" = 1,
	"texture_region" = {"x" : 4000, "w": 800, "y" : 3200, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var cygni : Dictionary = {
	"id" = 27, 
	"name" = "Cygni",
	"surface_type" = "Gas",
	"density" = 0.57, 
	"density_factor" = 0.2,
	"temp_factor" = 31,
	"temp" = 127, 
	"tier" = 3,
	"texture_region" = {"x" : 0, "w": 800, "y" : 4000, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var darri : Dictionary = {
	"id" = 28, 
	"name" = "Darri",
	"surface_type" = "Solid",
	"density" = 0.2, 
	"density_factor" = 0.03,
	"temp_factor" = 5,
	"temp" = -115, 
	"tier" = 1,
	"texture_region" = {"x" : 800, "w": 800, "y" : 4000, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var ankhet : Dictionary = {
	"id" = 29, 
	"name" = "Ankhet",
	"surface_type" = "Gas",
	"density" = 3, 
	"density_factor" = 0.3,
	"temp_factor" = 42,
	"temp" = 305, 
	"tier" = 5,
	"texture_region" = {"x" : 1600, "w": 800, "y" : 4000, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 0.755,
	"button_scale" =  1.14,
	"distance_star" = null,
	"parallaxID" = null
}

var tali : Dictionary = {
	"id" = 30, 
	"name" = "Tali",
	"surface_type" = "Liquid",
	"density" = 1.9, 
	"density_factor" = 0.2,
	"temp_factor" = 40,
	"temp" = 163, 
	"tier" = 4,
	"texture_region" = {"x" : 2400, "w": 800, "y" : 4000, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var clyade : Dictionary = {
	"id" = 31, 
	"name" = "Clyade",
	"surface_type" = "Gas",
	"density" = 2.62, 
	"density_factor" = 0.49,
	"temp_factor" = 25,
	"temp" = 0, 
	"tier" = 3,
	"texture_region" = {"x" : 3200, "w": 800, "y" : 4000, "h" : 800}, 
	"system_scale" = 0.15,
	"details_scale" = 1,
	"button_scale" =  0.875,
	"distance_star" = null,
	"parallaxID" = null
}

var all_planets_list : Array = [
	helia,zele,andra,terra,solovei,wedi,enil,vina,trano,qetesh,tyoph,iriscia,
	auder,trada,ilmare,lachesis,apep,lanthee,glia,kaniea,baugi,xihe,alyosha,gethee,
	nosu,irra,cygni,darri,ankhet,tali,clyade
]



@onready var planets : Array = [planet_1, planet_2, planet_3, planet_4, planet_5]

var referenced_planets : Dictionary = {}
var current_planet_round : int = 1
var planets_completed : int = 0

var current_location : String
var last_focused_planet : String

func assign_refs(planet_name : String, details: Dictionary, coords : Vector2, distances : Dictionary)-> void:
	var dict_template = {
		"details" : null, 
		"coords" : null,
		"distances" : null
	}
	referenced_planets.get_or_add(planet_name)
	referenced_planets.set(planet_name, dict_template)
	referenced_planets.get(planet_name).set("details", details)
	referenced_planets.get(planet_name).set("coords", coords)
	referenced_planets.get(planet_name).set("distances", distances)


func reset_inplanet_round()->void:
	current_planet_round = 1
