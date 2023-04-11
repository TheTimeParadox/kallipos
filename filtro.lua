function Image(img)
      if img.classes:find('filtro',1) then
        local f = io.open("TheParadoxNotes/" .. img.src, 'r')
        local doc = pandoc.read(f:read('*a'))
        f:close()
        local caption = pandoc.utils.stringify(doc.meta.caption) or "Caption has not been set"
        local person = pandoc.utils.stringify(doc.meta.person) or "Student has not been set"
        local AM = pandoc.utils.stringify(doc.meta.AM) or "AM has not been set"
        local title = ">" .. " Caption:" .. caption .. "  \n>" .. " Student:" .. student .. "  \n>" .. " AM:" .. AM
        return pandoc.RawInline('markdown',title)
      end
end
