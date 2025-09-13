## Adding new items to the game

### items.otb / items.xml
- adds two new items to items.otb: 
**both with flags Movable, Pickupable and Type Container**
    - id 5090: arrow quiver
    - id 5091: bolt quiver

- add two new items to items.xml
```xml
	<item id="5090" article="a" name="arrow quiver">
		<attribute key="weapontype" value="quiver"/>
		<attribute key="weight" value="1800"/>
		<attribute key="containersize" value="5" />
		<attribute key="ammotype" value="arrow"/>
	</item>
	<item id="5091" article="a" name="bolt quiver">
		<attribute key="weapontype" value="quiver"/>
		<attribute key="weight" value="1800"/>
		<attribute key="containersize" value="5" />
		<attribute key="ammotype" value="bolt"/>
	</item>
```

## Implementation details

Quiver is an item of type _ITEM\_GROUP\_CONTAINER_.
The size of container(quiver) is defined on items.xml
Quiver of "ammotype" -> "bolt" can only hold bolts and power bolts (or any other kind of custom bolt). Same for "ammotype" -> "bolt"
