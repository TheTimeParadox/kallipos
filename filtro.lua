function Image(img)
      if img.classes:find('vscode',1) then
        local f = io.open("./TheParadoxNotes/" .. img.src, 'r')
        local doc = pandoc.read(f:read('*a'))
        f:close()
        local title = pandoc.utils.stringify(doc.meta.title) or "Title has not been set"
        local caption = pandoc.utils.stringify(doc.meta.caption) or "Caption has not been set"
        local person = pandoc.utils.stringify(doc.meta.person) or "Student has not been set"
        local AM = pandoc.utils.stringify(doc.meta.AM) or "AM has not been set"
        local title = "> " .. title .. "  \n>" .. " Caption:" .. caption .. "  \n>" .. " Student:" .. student .. "  \n>" .. " AM:" .. AM
        return pandoc.RawInline('markdown',caption)
      end
end
