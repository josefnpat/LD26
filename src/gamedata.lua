local gd = {}

local actions = {}

actions.usegrog = {}
actions.usegrog.desc = "Drink Grog!"
actions.usegrog.mod = {anger=-1,fear=-1,grog=-5}

actions.walkplank = {}
actions.walkplank.desc = "Make a mate walk the plank!"
actions.walkplank.mod = {anger=-3,fear=6,crew=-1}

actions.beatcrew = {}
actions.beatcrew.desc = "Beat the crew to improve moral!"
actions.beatcrew.mod = {anger=2,fear=2}

actions.findballs = {}
actions.findballs.desc = "Get more cannonballs."
actions.findballs.mod = {treasure=-1,cannonballs=20}

actions.findcrew = {}
actions.findcrew.desc = "Find more Mateys!"
actions.findcrew.mod = {treasure=-5,crew=5}

actions.restup = {}
actions.restup.desc = "Let the lads take a rest."
actions.restup.mod = {day=-1,fear=-1,anger=-1}

actions.ingoreport = {}
actions.ingoreport.desc = "Ignore Port."
actions.ingoreport.mod = {anger=2}

actions.ingoreship = {}
actions.ingoreship.desc = "Ignore Ship."
actions.ingoreship.mod = {anger=2}

actions.findgrog = {}
actions.findgrog.desc = "Get more grog!"
actions.findgrog.mod = {treasure=-1,grog=10}

actions.pillage = {}
actions.pillage.desc = "Grape and Pillage!"
actions.pillage.mod = {treasure=10,grog=10,crew=-2,fear=-5,anger=-5}

actions.plunder_a = {}
actions.plunder_a.desc = "Attack and Plunder the ship!"
actions.plunder_a.mod = {cannonballs=-10,crew=-1,treasure=4}

actions.plunder_b = {}
actions.plunder_b.desc = "Attack and Plunder the ship!"
actions.plunder_b.mod = {cannonballs=-20,crew=-2,treasure=8}

actions.plunder_c = {}
actions.plunder_c.desc = "Attack and Plunder the ship!"
actions.plunder_c.mod = {cannonballs=-40,crew=-4,treasure=16}

actions.burytreasure = {}
actions.burytreasure.desc = "Bury some treasure!"
actions.burytreasure.mod = {anger=-5,treasure=-5,fear=-5}

actions.maroon = {}
actions.maroon.desc = "Maroon a matey!"
actions.maroon.mod = {anger=-5,crew=-1,fear=5}

gd.actions = actions

local places = {}

places['friendly_port'] = {}
places['friendly_port'].name = "Friendly Port"
places['friendly_port'].desc = "You find a port full of debauchery."
places['friendly_port'].opt = {}
places['friendly_port'].opt[1] = actions.findballs
places['friendly_port'].opt[2] = actions.findcrew
places['friendly_port'].opt[3] = actions.restup
places['friendly_port'].opt[4] = actions.ingoreport

places['hostile_port'] = {}
places['hostile_port'].name = "Hostile Port"
places['hostile_port'].desc = "You find a port full of wig wearers."
places['hostile_port'].opt = {}
places['hostile_port'].opt[1] = actions.findgrog
places['hostile_port'].opt[2] = actions.pillage
places['hostile_port'].opt[3] = actions.ingoreport

places['neutral_port'] = {}
places['neutral_port'].name = "Neutral Port"
places['neutral_port'].desc = "You find a port full of wiseguys."
places['neutral_port'].opt = {}
places['neutral_port'].opt[1] = actions.restup
places['neutral_port'].opt[2] = actions.findgrog
places['neutral_port'].opt[3] = actions.pillage
places['neutral_port'].opt[4] = actions.ingoreport

places['island'] = {}
places['island'].name = "Island"
places['island'].desc = "You find a sandy island with a lone coconut tree."
places['island'].opt = {}
places['island'].opt[1] = actions.burytreasure
places['island'].opt[2] = actions.maroon

places['open_sea'] = {}
places['open_sea'].name = "Open Sea"
places['open_sea'].desc = "You find yourself in the middle of nowhere."
places['open_sea'].opt = {}
places['open_sea'].opt[1] = actions.usegrog
places['open_sea'].opt[2] = actions.walkplank
places['open_sea'].opt[3] = actions.beatcrew

places['ship_a'] = {}
places['ship_a'].name = "Enemy Ship"
places['ship_a'].desc = "You encounter a tasty target."
places['ship_a'].opt = {}
places['ship_a'].opt[1] = actions.plunder_a
places['ship_a'].opt[2] = actions.ingoreship

places['ship_b'] = {}
places['ship_b'].name = "Enemy Ship"
places['ship_b'].desc = "You encounter a tasty target."
places['ship_b'].opt = {}
places['ship_b'].opt[1] = actions.plunder_b
places['ship_b'].opt[2] = actions.ingoreship

places['ship_c'] = {}
places['ship_c'].name = "Enemy Ship"
places['ship_c'].desc = "You encounter a tasty target."
places['ship_c'].opt = {}
places['ship_c'].opt[1] = actions.plunder_c
places['ship_c'].opt[2] = actions.ingoreship

gd.places = places

return gd
