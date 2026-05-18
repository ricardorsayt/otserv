-- talkaction_export_minimap.lua
-- Exporta os minimaps de todos os floors em formato BMP
-- Compatível com TFS 1.3 / The Violet Project (sem dependências extras)
-- Autor: ChatGPT & Homero ??

function onSay(player, words, param)
    local outputPath = "/var/www/html/public/map/map_tiled_bmp/"
    local floors = 15

    player:sendTextMessage(MESSAGE_INFO_DESCR, "Iniciando exportacao dos minimaps...")
    print(string.format("[Minimap Export] Iniciando exportacao para '%s'", outputPath))

    for z = 0, floors do
        local fileName = string.format("%smap_%d.bmp", outputPath, z)

        -- Função interna que exporta o mapa para arquivo BMP
        local result = Game.saveMiniMap(z, fileName)
        if result then
            print(string.format("[Minimap Export] Floor %d exportado com sucesso (%s)", z, fileName))
        else
            print(string.format("[Minimap Export] Falhou ao exportar floor %d", z))
        end
    end

    player:sendTextMessage(MESSAGE_INFO_DESCR, "Exportacao concluida! Verifique a pasta de destino.")
    print("[Minimap Export] Finalizado com sucesso.")
    return false
end
