extends Node

var planet_1 : Dictionary = {
	"id" = 1, 
	"name" = "Name",
	"density" = 1.2, #Valor original es 1.2
	"temp" = 20, #Valor original es 1. Menor temperatura, mejor empuje pero menos escudo y fallo de armas. Mayor temperatura, peor empuje y recibe daño continuo
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/Planeta azul claro.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA AZUL CLARO XL.png"), 
	"parallaxID" = null
}

var planet_2 : Dictionary = {
	"id" = 2, 
	"name" = "Name",
	"density" = 2,
	"temp" = 70,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/planeta azul.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA AZUL XL.png"), 
	"parallaxID" = null
}

var planet_3 : Dictionary = {
	"id" = 3, 
	"name" = "Name",
	"density" = 0.5,
	"temp" = -50,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/planeta blanco.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/PLANETA BLANCO XL.png"), 
	"parallaxID" = null
}

var planet_4 : Dictionary = {
	"id" = 4, 
	"name" = "Name",
	"density" = 2.5,
	"temp" = 400,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/Sol Amarillo.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/SOL AMARILLO XL.png"), 
	"parallaxID" = null
}

var planet_5 : Dictionary = {
	"id" = 5, 
	"name" = "Name",
	"density" = 3,
	"temp" = -200,
	"icon" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas Botones/sol rojo.png"), 
	"background" = preload("res://Prototypes/Shmup/Assets/Demo/mapa/Planetas XL/SOL ROJO XL.png"), 
	"parallaxID" = null
}

@onready var planets : Array = [planet_1, planet_2, planet_3, planet_4, planet_5]

var referenced_planets : Dictionary = {}

func assign_refs(planet : Dictionary, ref : String)-> void:
	print("refs assigned")
	referenced_planets.get_or_add(str(ref))
	referenced_planets.set(str(ref), planet)
