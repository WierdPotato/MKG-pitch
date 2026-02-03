extends Node

var challenge_type_1a : Dictionary = { 
	"typeid" : 0,
	"objective" : "Don´t miss any bullet.",
}

var challenge_type_1b : Dictionary = { #
	"typeid" : 1,
	"objective" : "Don´t recieve any damage",
}

var challenge_type_1c : Dictionary = { #
	"typeid" : 2,
	"objective" : "Don´t destroy any enemy",
}


var descriptions_type_1a : Dictionary = {
	"1" : "Force back the enemy forces to secure a safe landing spot for the infantry.",
	"2" : "Reach the next target, bruteforcing your way through the enemy lines if necessary.",
	"3" : "Patrol the area, taking down any enemy within the designated area."
}

var descriptions_type_1b : Dictionary = {
	"1" : "Hold down the enemy forces until the allied forces secure the area.",
	"2" : "Survive until you reach the target.",
	"3" : "Patrol the area until the next ally substitutes you."
}

var descriptions_type_1c : Dictionary = {
	"1" : "Open your way to the enemy cargo ship and destroy it.",
	"2" : "We detected a bomber approaching our airspace. Intercept it and destroy it.",
	"3" : "Our explorers found a spy ship scaning this area. Intercept it and destroy it."
}

var mission_type_1a : Dictionary = { #Destruir X cantidad de enemigos
	"typeid" : 0,
	"names" : ["Spearhead", "First Strike", "No Mercy"],
	"objective" : "Destroy",
	"goal" : 0,
	"subject" : " enemy ships.",
	"challenges" : [challenge_type_1a, challenge_type_1b],
	"descriptions" : descriptions_type_1a,
	"steps" : [1, 2]
}



var mission_type_1b : Dictionary = { #Aguantar X cantidad de tiempo
	"typeid" : 1,
	"names" : ["Last Bastion", "Hold Them Down", "Last Chance"],
	"objective" : "Survive for",
	"goal" : 0,
	"subject" : " minutes.",
	"challenges" : [challenge_type_1a, challenge_type_1b, challenge_type_1c],
	"descriptions" : descriptions_type_1b,
	"steps" : [1, 2]
}


var mission_type_1c : Dictionary = { #Destruir una nave enemiga en concreto
	"typeid" : 2,
	"names" : ["No Return"],
	"objective" : "Destroy",
	"goal" : 0,
	"subject" : " the designated enemy ship.",
	"challenges" : [challenge_type_1a, challenge_type_1b],
	"descriptions" : descriptions_type_1c,
	"steps" : [3]
}

var step_1_missions : Array = [
	mission_type_1a,
	mission_type_1b
]

var step_2_missions : Array = [
	mission_type_1a,
	mission_type_1b
]

var step_3_missions : Array = [
	mission_type_1c
]

var processed_missions : Dictionary = {}

func assign_refs(mission : Dictionary, ref : Button)-> void:
	processed_missions.get_or_add(str(ref))
	processed_missions.set(str(ref), mission)
