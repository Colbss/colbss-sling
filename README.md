# colbss-sling

Sling system for qb-core. Any weapons in player inventory (or only hotbar) will show as a prop on their body.

Inspired by https://github.com/nagsterFVZ/fjh-sling

This script also fixes some of the issues in qb-core with props attached to players such as car-nado and when moving between buckets (dimensions, i.e. apartments).

### Installation

Add ``start colbss-sling`` or ``ensure colbss-sling`` to your server.cfg or mods.cfg if you use one.

<u>**IMPORTANT**</u> - You must remove / comment out the default `/refreshskin` command in `[qb]\qb-clothing\client\main.lua`. This script can run with refreshskin still existing, but it is not recommended. If you have any other sling scripts make sure to remove these too.


### Config file
All available weapons and their ideal positions are defined in the `config.lua`. Comment out the weapons that you <u>**do not**</u> want to show on players bodies. If you want items to only show on back if they are in the players hotbar you can enable this with `Config.HotbarOnly = true`. However, keep in mind that players can stil take weapons directly out of their pockets and negate the whole point of the sling.

### Commands
`/sling` - Toggle the position that the weapon will be shown. Different weapons types have different positions, i.e. assault rifles show on your back and front, while pistols only show on your hip.

`/slingoffset` - Adjust how far from the player body the prop will be. This isnt really necessary but if the player has a ped with a larger body or larger clothing they may adjust as needed.

`/reloadskin` - Similar to refreskskin, but has additional features such as retaining the armour of the player and a progress bar to stop spamming to exploit health back. 

### Idle usage
![Resmon](https://i.imgur.com/DtMgxED.png)

