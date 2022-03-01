local status, colorizer = pcall(require, "colorizer")
if (not status) then return end

colorizer.setup({
  '*';
  css = { css = true; };
}, {
  -- default_options
  RGB      = false;        -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = false;        -- "Name" codes like Blue
	RRGGBBAA = true;         -- #RRGGBBAA hex codes
	rgb_fn   = true;         -- CSS rgb() and rgba() functions
	hsl_fn   = false;        -- CSS hsl() and hsla() functions
	css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
})