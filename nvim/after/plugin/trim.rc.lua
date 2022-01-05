local status, trim = pcall(require, "trim")
if (not status) then return end


-- default config
local config = {
  disable = {"markdown", "no ft", "text"},
  patterns = {
    [[%s/\s\+$//e]],                -- 行末の空白文字を削除
    [[%s/\($\n\s*\)\+\%$//]],       -- ファイル末尾の連続した空白、空行を削除
    [[%s/\%^\n\+//]],               -- ファイル先頭の連続した空白、空行を削除
    [[%s/\(\n\n\n\)\n\+/\1/]],      -- 3行以上連続した空行は、2行に圧縮
  },
}


trim.setup(config)
