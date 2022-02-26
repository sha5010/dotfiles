local status, range_highlight = pcall(require, "range-highlight")
if (not status) then return end

range_highlight.setup{}
