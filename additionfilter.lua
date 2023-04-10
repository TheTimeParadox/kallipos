function Image(img)
  if img.classes:find('additionfilter',1) then
    local f = io.open("TheParadoxNotes/" .. img.src, 'r')
    local doc = pandoc.read(f:read('*a'))
    f:close()
    local caption = pandoc.utils.stringify(doc.meta.caption) or "No Caption Found"
    local student = pandoc.utils.stringify(doc.meta.student) or "No Student Found"
    local AM = pandoc.utils.stringify(doc.meta.AM) or "No AM Found"
    local add = "> " .. caption .. "\n\n>"  .."**Ον/μο:**" .. student .. " " ..  "**Aριθμός Μητρώου:**" .. AM
    return pandoc.RawInline('markdown',add)
  end
end
