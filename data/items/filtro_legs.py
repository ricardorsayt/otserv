import xml.etree.ElementTree as ET

def encontrar_head_items(caminho_arquivo):
    tree = ET.parse(caminho_arquivo)
    root = tree.getroot()

    items_head = []

    for item in root.findall('item'):
        for attribute in item.findall('attribute'):
            if attribute.get('key') == 'slotType' and attribute.get('value') == 'head':
                item_id = item.get('id')
                item_name = item.get('name')
                items_head.append((item_id, item_name))
                break

    return items_head

if __name__ == "__main__":
    arquivo_xml = "items.xml"
    head_items = encontrar_head_items(arquivo_xml)

    if head_items:
        print(f"Foram encontrados {len(head_items)} itens com slotType='head'. Salvando em 'head_items.txt'...")
        with open("head_items.txt", "w", encoding="utf-8") as f:
            for item_id, item_name in head_items:
                f.write(f"ID: {item_id} - Nome: {item_name}\n")
        print("Arquivo gerado com sucesso!")
    else:
        print("Nenhum item com slotType='head' foi encontrado.")
