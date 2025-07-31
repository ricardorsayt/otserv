# -*- coding: utf-8 -*-
import re
from xml.etree import ElementTree as ET

xml_file = 'realmap-spawn.xml'
log_file = 'spawn_erros.log'

ansi_escape = re.compile(r'\x1b\[[0-9;]*m')

tree = ET.parse(xml_file)
root = tree.getroot()

invalid_spawns = set()
with open(log_file, 'r', encoding='utf-8') as f:
    for line in f:
        clean_line = ansi_escape.sub('', line)
        match = re.search(r'on position: \( (\d+) / (\d+) / (\d+) \)', clean_line)
        if match:
            x, y, z = map(int, match.groups())
            invalid_spawns.add((x, y, z))

print("Total de posicoes invalidas encontradas:", len(invalid_spawns))
for pos in list(invalid_spawns)[:5]:
    print("Exemplo:", pos)

removed = 0
for spawn in root.findall('spawn'):
    try:
        cx = int(spawn.get('centerx'))
        cy = int(spawn.get('centery'))
    except (TypeError, ValueError):
        continue

    for tag in ['monster', 'npc']:
        for entity in list(spawn.findall(tag)):
            try:
                mx = int(entity.get('x')) + cx
                my = int(entity.get('y')) + cy
                mz = int(entity.get('z'))
                if (mx, my, mz) in invalid_spawns:
                    spawn.remove(entity)
                    removed += 1
            except (TypeError, ValueError):
                continue

print(f"{removed} entidades removidas do spawn.xml.")

tree.write('realmap-spawn-limpo.xml', encoding='utf-8', xml_declaration=True)
